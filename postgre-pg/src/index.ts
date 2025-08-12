import { Client } from "pg";

export const client = new Client({
  user: "awaizdottech",
  host: "localhost",
  database: "practiceDB",
  password: "practice",
  port: 5432,
});

export const main = async () => {
  await client.connect();
  console.log((await client.query("select * from pg_catalog.pg_tables;")).rows);
  // instead of this if we try to create a template literal for the query string that will allow sql injection
  await client.query("begin;");
  const user = await client.query(
    "insert into users (username, email, apssword) values ($1,$2,$3) inserting id;",
    ["awizdottech", "xyz@abc.com", "sdgbcjdbh"]
  );
  await client.query("insert into addressed (userID,adress) values ($1,$2);", [
    user.rows[0].id,
    "something", // here even if the previous query is not actually fully executed we'll get the id as sql increments the auto-increment field even if the entry isnt successful  or completed, which also means if there's failed queries still the id number will increment, hence not making it suitable to get the count of actutal no. of records
  ]);
  await client.query("rollback;"); // used to abort the transaction
  await client.query("commit;");
};

main();

// sql DBs scale vertically until sharded(separating data that wont need to be joined) unlike nosql which scale horizontally. they can also have master-slave arch where master handles write queries and slaves have replicated data that handles read queries.

// serial -
