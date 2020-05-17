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

  try {
    await clientConnection.catch(e => error = e);
    if (error) {
      throw {
        errorType: "postgres connection",
        error,
      };
    }

    let WHERE = "";
    if (body) {
      let bodyData = JSON.parse(body);
      if (bodyData.territory && isUUID(bodyData.territory)) {
        WHERE = `
      WHERE
        svg_path.territory = '${bodyData.territory}'`;
      }
    }
    let query = tidyQuery(`
      SELECT
        svg_path.path,
        svg_path.uuid,
        svg_path.territory,
        territory_label.label
      FROM
        svg_path
      LEFT JOIN
        territory_label
      ON
        svg_path .territory = territory_label.territory${
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
