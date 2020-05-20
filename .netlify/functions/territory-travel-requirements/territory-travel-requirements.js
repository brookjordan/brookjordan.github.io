const PG = require("pg");
const { Client } = PG;
const isUUID = (string) => /^[a-f0-9]{8}(-[a-f0-9]{4}){3}-[a-f0-9]{12}$/.test(string);
const stringify = (string) => JSON.stringify(string);
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
  let error;
  let client = new Client();
  let clientConnection = client.connect();
  let query;

  try {
    await clientConnection.catch(e => error = e);
    if (error) {
      throw {
        errorType: "postgres connection",
        error,
      };
    }

    let bodyData = body && JSON.parse(body);
    if (!bodyData.territory) {
      throw {
        errorType: "missing-param",
        error: "missing territory:parameter: The territory parameter is required",
      };
    }

    let WHERE = "";
    if (bodyData.territory && isUUID(bodyData.territory)) {
      WHERE = `
      WHERE
        passport_travel_requirements.passport_territory = '${bodyData.territory}'`;
    }

    query = tidyQuery(`
      SELECT
        visa_type.ease,
        territory_label.label,
        passport_travel_requirements.uuid,
        passport_travel_requirements.notes,
        passport_travel_requirements.destination_territory
      FROM
        passport_travel_requirements
      LEFT JOIN
        territory_label
      ON
        passport_travel_requirements .destination_territory = territory_label.territory
      LEFT JOIN
        visa_type
      ON
        passport_travel_requirements .visa_type = visa_type.name${
      WHERE};
    `);

    let { rows } = await client.query(query).catch(e => error = e);
    if (error) {
      throw {
        query,
        error,
        errorType: "postgres query",
      };
    }

    let requirements = {};
    rows.forEach(row => {
      requirements[row.uuid] || (requirements[row.uuid] = {
        labels: [],
        ease: row.ease,
        uuid: row.destination_territory,
        notes: row.notes,
      });
      requirements[row.uuid].labels.push(row.label);
    })
    callback(null, {
      statusCode: 200,
      body: stringify({
        query,
        data: Object.values(requirements),
      }),
      headers: {
        "Cache-Control": "max-age=300"
      },
      //isBase64Encoded: false,
    });
  } catch (error) {
    if (error.errorType) {
      callback(null, {
        statusCode: 200,
        body: stringify(error),
      });
    } else {
      callback(null, {
        statusCode: 200,
        body: stringify({
          query,
          error,
          errorType: "unknown",
        }),
      });
    }
  } finally {
    client.end();
  }
};
