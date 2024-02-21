USE mvc_asp;

DROP PROCEDURE IF EXISTS stock_report;
DELIMITER //
CREATE PROCEDURE stock_report()
BEGIN
    SELECT code_art, name, curr_stock, created_at, updated_at FROM articles;
END //
DELIMITER ;

-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS price_report;
DELIMITER //
CREATE PROCEDURE price_report()
BEGIN
    SELECT code_art, name, price, cost, created_at, updated_at FROM articles;
END //
DELIMITER ;