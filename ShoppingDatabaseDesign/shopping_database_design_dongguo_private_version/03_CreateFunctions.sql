use shopping;


# return category id 
# if the special name category did not exist, create a new one
#
DROP FUNCTION IF EXISTS get_or_create_category_id;
DELIMITER $$
CREATE FUNCTION get_or_create_category_id(category_name VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT category_id INTO id FROM categories WHERE name = category_name;
    IF id IS NULL THEN
        INSERT INTO categories(name) VALUES (category_name);        
    SELECT LAST_INSERT_ID() into id;
    END IF;
    RETURN id;
END $$
DELIMITER ;


# return product id 
# if the special product did not exist, create a new one
#
DROP FUNCTION IF EXISTS get_or_create_product_id;
DELIMITER $$
CREATE FUNCTION get_or_create_product_id(product_name VARCHAR(255), category_name VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT product_id INTO id FROM product_view WHERE name = product_name and category = category_name;
    IF id IS NULL THEN
        select get_or_create_category_id(category_name) into  @category_id;
        insert into products(name, category_id) values(product_name, @category_id);    
        SELECT LAST_INSERT_ID() into id;    
    END IF;
    RETURN id;
END $$
DELIMITER ;

# return seller id 
# if the special name seller did not exist, create a new one
#
DROP FUNCTION IF EXISTS get_or_create_seller_id;
DELIMITER $$
CREATE FUNCTION get_or_create_seller_id(seller_name VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT seller_id INTO id FROM sellers WHERE name = seller_name;
    IF id IS NULL THEN
        INSERT INTO sellers(name) VALUES (seller_name);              
    SELECT seller_id INTO id FROM sellers WHERE name = seller_name;
    END IF;
    RETURN id;
END $$
DELIMITER ;





# return shopping_cart_line id 
#
DROP FUNCTION IF EXISTS create_shopping_cart_line_id;
DELIMITER $$
CREATE FUNCTION create_shopping_cart_line_id(item_id int, item_quantity int)
RETURNS INT
READS SQL DATA
BEGIN
declare id_found int;
        insert into shopping_cart_lines(item_id, quantity) values(item_id, item_quantity);         
        SELECT LAST_INSERT_ID() into id_found;  
    RETURN id_found;
END $$
DELIMITER ;

# 
DROP FUNCTION IF EXISTS get_or_create_order_id;
DELIMITER $$
CREATE FUNCTION get_or_create_order_id(id int)
RETURNS INT
READS SQL DATA
BEGIN    
    DECLARE id_found INT;
	IF id = 0 THEN
        select create_new_order_id() into id_found;
    END IF;
    SELECT order_id INTO id_found FROM orders where order_id = id;
    if id_found is null then
        select create_new_order_id() into id_found;
    end if;
    RETURN id_found;
END $$
DELIMITER ;

# orders(order_date) value('2022-12-12')
DROP FUNCTION IF EXISTS create_new_order_id;
DELIMITER $$
CREATE FUNCTION create_new_order_id()
RETURNS INT
READS SQL DATA
BEGIN    
    DECLARE id_found INT;
    select now() into @today;    
    insert into orders(order_date) values(@today);    
    select last_insert_id() into id_found;
    RETURN id_found;
END $$
DELIMITER ;

# 
#
DROP FUNCTION IF EXISTS add_item_to_shopping_cart;
DELIMITER $$
CREATE FUNCTION add_item_to_shopping_cart(order_id int, shopping_cart_line_id int)
RETURNS tinyint
READS SQL DATA
BEGIN
	select get_or_create_order_id(order_id) into @order_id;
    insert into orders_shopping_cart_lines(order_id, shopping_cart_line_id) values(@order_id, shopping_cart_line_id); 
    RETURN 1;
END $$
DELIMITER ;

# 
DROP FUNCTION IF EXISTS get_or_create_address_id;
DELIMITER $$
CREATE FUNCTION get_or_create_address_id(street VARCHAR(255), city  VARCHAR(255), province  VARCHAR(255), postal_code  VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT address_id INTO id FROM addresses WHERE street = street and city = city and province = province and postal_code = postal_code limit 1;
    IF id IS NULL THEN
        INSERT INTO addresses(street, city, province, postal_code) VALUES (street, city, province, postal_code);        
    SELECT LAST_INSERT_ID() into id;
    END IF;
    RETURN id;
END $$
DELIMITER ;

# 
#
# return category id 
# if the special name category did not exist, create a new one
#
DROP FUNCTION IF EXISTS get_or_create_payment_category_id;
DELIMITER $$
CREATE FUNCTION get_or_create_payment_category_id(category_name VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT payment_method_category_id INTO id FROM payment_method_categories WHERE payment_method_category_name = category_name;
    IF id IS NULL THEN
        INSERT INTO payment_method_categories(payment_method_category_name) VALUES (category_name);        
		SELECT LAST_INSERT_ID() INTO id;
    END IF;
    RETURN id;
END $$
DELIMITER ;

# 
#
DROP FUNCTION IF EXISTS get_or_create_payment_id;
DELIMITER $$
CREATE FUNCTION get_or_create_payment_id(category_name VARCHAR(255), name_on_card VARCHAR(255), card_number VARCHAR(255))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE id INT;
    SELECT payment_method_id INTO id FROM payment_method_view WHERE category_name = category_name and name_on_card = name_on_card and card_number = card_number limit 1;
    IF id IS NULL THEN
        select get_or_create_payment_category_id(category_name) into  @category_id;
        insert into payment_methods(payment_method_category_id, name_on_card, card_number) values(@category_id, name_on_card, card_number);    
        SELECT LAST_INSERT_ID() into id;    
    END IF;
    RETURN id;
END $$
DELIMITER ;

