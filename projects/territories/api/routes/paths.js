import PG from "pg";

const { Client } = PG;
const client = new Client();
client.connect();
//client.end();

export default async (request, response) => {
  let { rows } = await client.query(`
    SELECT
      svg_path.path,
      svg_path.territory,
      territory_label.label
    FROM
      svg_path
    LEFT JOIN territory_label ON svg_path .territory = territory_label.territory;
  `);
  let paths = {};
  rows.forEach(row => {
    paths[row.path] || (paths[row.path] = {
      path: row.path,
      labels: [],
    });
    paths[row.path].labels.push(row.label);
  });

  response.status(200);
  response.json(Object.values(paths));
};
