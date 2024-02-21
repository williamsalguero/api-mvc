USE mvc_asp;

DROP PROCEDURE IF EXISTS read_transactions;
DELIMITER //
CREATE PROCEDURE read_transactions()
BEGIN
	SELECT * FROM transactions;
END //
DELIMITER ;

-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS create_transaction;
DELIMITER //
CREATE PROCEDURE create_transaction(
    IN t_type ENUM('S', 'E'),
    IN t_unit_price FLOAT(7,2),
    IN t_code_artrf VARCHAR(8),
    IN t_status VARCHAR(10),
    IN t_num_units INT  (6)
)
BEGIN
    IF t_type = 'S' THEN

        IF t_num_units > (SELECT curr_stock FROM articles WHERE code_art = t_code_artrf) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: There are not enough units in stock to make the sale.';
        END IF;
        
        UPDATE articles 
        SET curr_stock = curr_stock - t_num_units, output = output+1
        WHERE code_art = t_code_artrf;
    END IF;
    
    IF t_type = 'E' THEN
		UPDATE articles 
        SET curr_stock = curr_stock + t_num_units, input = input +1
        WHERE code_art = t_code_artrf;
    END IF;
    
    INSERT INTO transactions (type, unit_price, code_artrf, status, num_units)
    VALUES (t_type, t_unit_price, t_code_artrf, t_status, t_num_units);
END //
DELIMITER ;

-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS update_transaction;
DELIMITER //
CREATE PROCEDURE update_transaction(
    IN t_id INT,
    IN t_type ENUM('S', 'E'),
    IN t_unit_price FLOAT(7.2),
    IN t_code_artrf VARCHAR(8),
    IN t_status VARCHAR(10),
    IN t_num_units INT
)
BEGIN
    DECLARE old_status VARCHAR(10);
    DECLARE old_num_units INT;
    
    SELECT status, num_units INTO old_status, old_num_units FROM transactions WHERE id = t_id;
    
    IF old_status != t_status THEN
        IF old_status = 'S' THEN
            UPDATE articles 
            SET curr_stock = curr_stock + old_num_units
            WHERE code_art = t_code_artrf;
        ELSE
            UPDATE articles 
            SET curr_stock = curr_stock - old_num_units
            WHERE code_art = t_code_artrf;
        END IF;
        
        IF t_status = 'S' THEN
            UPDATE articles 
            SET curr_stock = curr_stock - t_num_units
            WHERE code_art = t_code_artrf;
        ELSE
            UPDATE articles 
            SET curr_stock = curr_stock + t_num_units
            WHERE code_art = t_code_artrf;
        END IF;
    END IF;
    
    IF t_status = 'cancelled' THEN
        IF t_type = 'S' THEN
            UPDATE articles 
            SET curr_stock = curr_stock + t_num_units
            WHERE code_art = t_code_artrf;
        ELSE
            UPDATE articles 
            SET curr_stock = curr_stock - t_num_units
            WHERE code_art = t_code_artrf;
        END IF;
    END IF;
    
    UPDATE transactions 
    SET type = t_type, unit_price = t_unit_price, code_artrf = t_code_artrf, status = t_status, num_units = t_num_units
    WHERE id = t_id;
END //
DELIMITER ;
