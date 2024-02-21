CREATE DATABASE  mvc_asp;

USE mvc_asp;

DROP TABLE IF EXISTS articles;
CREATE TABLE IF NOT EXISTS articles(
    code_art VARCHAR(8) NOT NULL UNIQUE,
    name VARCHAR(30) NOT NULL,
    init_stock INT(6) NOT NULL,
    curr_stock INT(6) NOT NULL,
    price FLOAT(7.2) NOT NULL,
    cost FLOAT(7.2) NOT NULL,
    input INT(6) DEFAULT 0,
    output INT(6) DEFAULT 0,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (code_art)
);

SELECT * FROM articles; 

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions(
    id INT AUTO_INCREMENT NOT NULL,
    type ENUM ("S","E") NOT NULL,
    unit_price FLOAT(7.2) NOT NULL,
    code_artrf VARCHAR(8) NOT NULL,
    status VARCHAR(10) DEFAULT 'done',
    num_units INT (6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (code_artrf) REFERENCES articles(code_art)
);

SELECT * FROM transactions;
