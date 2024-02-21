-- ARTICLES--------------------------------------------------------------
CALL read_articles();
CALL create_article('Audifonos marca aplle', 10, 5, 15.99, 10.50, 0, 0);
CALL update_article('5991f19c', 'Audifonos de marca chabela', 20, 15, 19.99, 12.50, 0, 0);
CALL delete_article('4e49a487');

-- Transactions-----------------------------------------------------------
CALL read_transactions();
CALL create_transaction('S', 15.99, '5991f19c', 'done', 5);
CALL update_transaction(2, 'S', 15.99, '5991f19c', 'cancelled', 5);

-- Reports---------------------------------------------------------------
CALL stock_report();
CALL price_report();