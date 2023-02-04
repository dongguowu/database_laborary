#Test Queries
USE shopping;

#
#01 Add a new item as a seller
#
SELECT 	get_or_create_seller_id('Apple') INTO @seller_id_01;
SELECT 	get_or_create_product_id('Apple MacBook', 'Computer') INTO @product_id_01;
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_01, @seller_id_01, 1499, 5000);
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_01, @seller_id_01, 1999, 100);
SELECT * FROM items_view;

#
#04 Add number of item to shopping cart
#
# add 2 items
SELECT item_id into @item_id_01 from items_view limit 1;
select item_id into @item_id_02 from items_view limit 1 offset 1;

SELECT 	create_shopping_cart_line_id(@item_id_01, 100) INTO @shopping_cart_line_id_01;
SELECT create_shopping_cart_line_id(@item_id_02, 10) INTO @shopping_cart_line_id_02;


# create an empty order
SELECT 	get_or_create_order_id(0) INTO @order_id_01;
SELECT	add_item_to_shopping_cart(@order_id_01, @shopping_cart_line_id_01);
SELECT	add_item_to_shopping_cart(@order_id_01, @shopping_cart_line_id_02);

SELECT	* FROM	shopping_cart_view;
SELECT	* FROM	order_view;

#
#05 Set the shipping address
#
SELECT
	get_or_create_address_id(
		'21 275 Rue Lakeshore Road',
		'Sainte-Anne-de-Bellevue',
		'QC',
		'H9X 3L9'
	) INTO @address_id_01;

UPDATE 	orders SET 	address_id = @address_id_01
WHERE 	order_id = @order_id_01;

#
#06 Set the payment method
#
SELECT get_or_create_payment_id('Visa', 'Beta', '4111111111111111') INTO @masterCard_id;
SELECT get_or_create_payment_id('MastCard', 'Beta', '5105105105105100') INTO @masterCard_id;

UPDATE 	orders SET	payment_method_id = @masterCard_id WHERE 	order_id = @order_id_01; 
SELECT	* FROM 	order_view;

#
#02 Query for total number of sold item in past month
#
# move time
UPDATE	orders SET	order_date = '2022-12-12' WHERE 	order_id = @order_id_01;
SELECT	* FROM	order_seller_view;

SELECT	sum(quantity) FROM	order_seller_view WHERE 	MONTH(order_date) = '12' AND seller_id = @seller_id_01;

#
#03 Query for total income in CAD
#
SELECT	* FROM	order_seller_view;
SELECT	sum(price * quantity) AS 'total income in CAD' FROM	order_seller_view WHERE seller_id = @seller_id_01;
