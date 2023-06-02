-- Criando a tabela client
CREATE TABLE client (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL
);

-- Criando a tabela product
CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price NUMERIC(10, 2) NOT NULL
);

-- Criando a tabela order
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  client_id INTEGER REFERENCES client(id),
  order_date DATE NOT NULL
);

-- Criando a tabela de relação entre order e product
CREATE TABLE order_product (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id),
  product_id INTEGER REFERENCES product(id),
  quantity INTEGER NOT NULL
);
