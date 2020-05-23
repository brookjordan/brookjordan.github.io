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
  const pathTables = {
    default: {
      table: "svg_path",
      viewBox: "180 70 1800 880",
      // viewBox: "0 0 2000 1001",
    },
    authagraph: {
      table: "authograph_svg_path",
      viewBox: "0 0 360 155.885",
    },
  };

  try {
    await clientConnection.catch(e => error = e);
    if (error) {
      throw {
        errorType: "postgres connection",
        error,
      };
    }

    let WHERE = "";
    let payload = (body ? JSON.parse(body) : queryStringParameters) || {};
    let type = payload.type || "default";
    if (Object.keys(payload).length > 0) {
      if (payload.territory && isUUID(payload.territory)) {
        WHERE = `
      WHERE
        ${pathTables[type].table}.territory = '${payload.territory}'`;
      }
    }
    let query = tidyQuery(`
      SELECT
        ${pathTables[type].table}.path,
        ${pathTables[type].table}.uuid,
        ${pathTables[type].table}.territory,
        territory_label.label
      FROM
        ${pathTables[type].table}
      LEFT JOIN
        territory_label
      ON
        ${pathTables[type].table} .territory = territory_label.territory${
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

    let paths = {};
    rows.forEach(row => {
      paths[row.uuid] || (paths[row.uuid] = {
        labels: [],
        path: row.path,
        territory: row.territory,
      });
      paths[row.uuid].labels.push(row.label);
    })
    callback(null, {
      statusCode: 200,
      body: stringify({
        query,
        data: Object.values(paths),
        viewBox: pathTables[type].viewBox
      }),
      headers: {
        "Cache-Control": "max-age=300",
        "Access-Control-Allow-Origin": "*"
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
        body: `{
          "errorType": "unknown",
          "error": ${stringify(error)}
        }`,
      });
    }
  } finally {
    client.end();
  }
};
