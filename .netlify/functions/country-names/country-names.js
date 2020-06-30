const PG = require("pg");
const { Client } = PG;
const tidyQuery = string => {
  let trimmedString = string.trim();
  let minIndent = Math.min(...trimmedString.match(/(?<=\n)( +)/g).map(a => a.length - 1));
  return trimmedString.replace(RegExp(`(?<=\n) {${minIndent}}`, "g"), "");
}


exports.handler = async ({
  path, // string: Path parameter
  httpMethod, // string: Incoming request’s method name
  headers, // object: Incoming request headers
  queryStringParameters, // object: query string parameters
  body, // string: A JSON string of the request payload.
  isBase64Encoded, // string: A boolean flag to indicate if the applicable request payload is Base64-encoded
}, context, callback) => {
  let errors = [];
  let client = new Client();
  let clientConnection = client.connect();

  let modernCountriesQuery = tidyQuery(`
    SELECT
      uuid
    FROM
      territory
    WHERE
      modern_country IS TRUE
    ;
  `);

  let demonymsQuery = tidyQuery(`
    SELECT
      territory,
      label
    FROM
      demonym
    ;
  `);

  let labelsQuery = tidyQuery(`
    SELECT
      territory,
      the,
      label
    FROM
      territory_label
    ;
  `);

  let ISO2Query = tidyQuery(`
    SELECT
      territory,
      name
    FROM
      "ISO_3166-1_alpha-2"
    ;
  `);

  let ISO3Query = tidyQuery(`
    SELECT
      territory,
      name
    FROM
      "ISO_3166-1_alpha-3"
    ;
  `);

  let queries = [
    modernCountriesQuery,
    demonymsQuery,
    labelsQuery,
    ISO2Query,
    ISO3Query,
  ];

  try {
    await clientConnection.catch(e => errors.push(e));
    if (errors.length) {
      throw {
        errorType: "postgres connection",
        error: errors.join(),
      };
    }

    let [
      modernCountryRows,
      demonymRows,
      labelRows,
      ISO2Rows,
      ISO3Rows,
    ] = (await Promise.all(
      queries.map(query =>
        client.query(query).catch(e => errors.push(e))
      )
    )).map(response => response && response.rows);
    if (errors.length) {
      throw {
        query,
        error: errors.join(),
        errorType: "postgres query",
      };
    }

    let modernCountryUUIds = modernCountryRows.map(row => row.uuid);
    let territories = {};
    function getTerritory(id) {
      territories[id] || (territories[id] = {
        id: id,
        labels: [],
        demonyms: [],
        'ISO 3166-1 alpha-2': null,
        'ISO 3166-1 alpha-3': null,
      });
      return territories[id];
    }

    demonymRows.forEach(({ territory, label }) => {
      getTerritory(territory).demonyms.push(label);
    });

    labelRows.forEach(({ territory, label, the }) => {
      getTerritory(territory).labels.push(`${the ? 'the ' : ''}${label}`);
    });

    ISO2Rows.forEach(({ territory, name }) => {
      getTerritory(territory)['ISO 3166-1 alpha-2'] = name;
    });

    ISO3Rows.forEach(({ territory, name }) => {
      getTerritory(territory)['ISO 3166-1 alpha-3'] = name;
    });

    callback(null, {
      statusCode: 200,
      body: JSON.stringify({
        queries,
        data: Object.values(territories)
          .filter(territory => modernCountryUUIds.includes(territory.id))
      }),
      headers: {
        "Cache-Control": "max-age=300",
        "Access-Control-Allow-Origin": "*"
      },
    });
  } catch (error) {
    if (error.errorType) {
      callback(null, {
        statusCode: 502,
        body: JSON.stringify(error),
        headers: {
          "Cache-Control": "max-age=300",
          "Access-Control-Allow-Origin": "*"
        },
      });
    } else {
      callback(null, {
        statusCode: 502,
        body: JSON.stringify({
          errorType: "unknown",
          error
        }),
        headers: {
          "Cache-Control": "max-age=300",
          "Access-Control-Allow-Origin": "*"
        },
      });
    }
  } finally {
    client.end();
  }
};
