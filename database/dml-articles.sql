USE mvc_asp;

DROP PROCEDURE IF EXISTS read_articles;
DELIMITER //
CREATE PROCEDURE read_articles()
BEGIN
    SELECT * FROM articles;
END //
DELIMITER ;

-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS create_article;
DELIMITER //
CREATE PROCEDURE create_article(
    IN a_name VARCHAR(30),
    IN a_init_stock INT,
    IN a_curr_stock INT,
    IN a_price FLOAT(7.2),
    IN a_cost FLOAT(7.2),
    IN a_input INT,
    IN a_output INT
)
BEGIN
    DECLARE a_code_art VARCHAR(8);
    SET a_code_art = LEFT(UUID(), 8);
    
    INSERT INTO articles (code_art, name, init_stock, curr_stock, price, cost, input, output)
    VALUES (a_code_art, a_name, a_init_stock, a_curr_stock, a_price, a_cost, a_input, a_output);
END //
DELIMITER ;


-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS update_article;
DELIMITER //
CREATE PROCEDURE update_article(
    IN a_code_art VARCHAR(8),
    IN a_name VARCHAR(30),
    IN a_init_stock INT,
    IN a_curr_stock INT,
    IN a_price FLOAT(7.2),
    IN a_cost FLOAT(7.2),
    IN a_input INT,
    IN a_output INT
)
BEGIN
    UPDATE articles
    SET name = a_name,
        init_stock = a_init_stock,
        curr_stock = a_curr_stock,
        price = a_price,
        cost = a_cost,
        input = a_input,
        output = a_output
    WHERE code_art = a_code_art;
END //
DELIMITER ;

-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS delete_article;
DELIMITER //
CREATE PROCEDURE delete_article(
    IN a_code_art VARCHAR(8)
)
BEGIN
    DELETE FROM articles WHERE code_art = a_code_art;
END //
DELIMITER ;