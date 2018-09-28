DROP TABLE transactions;
DROP TABLE tags;
DROP TABLE merchants;

CREATE TABLE merchants
(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)


);

CREATE TABLE tags(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)



);

CREATE TABLE transactions(
id SERIAL4 PRIMARY KEY,
merchant_id INT4 REFERENCES merchants(id),
tag_id INT4 REFERENCES tags(id),
type VARCHAR(255),
description VARCHAR(255),
amount INT2,
t_date DATE

);
