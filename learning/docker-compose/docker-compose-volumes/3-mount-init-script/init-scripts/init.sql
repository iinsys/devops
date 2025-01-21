CREATE TABLE demo_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

INSERT INTO demo_table (name) VALUES ('Sample Data');
