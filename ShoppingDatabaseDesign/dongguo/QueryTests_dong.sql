#Test Query to:
USE Shopping_Project;

#
#01 Add a new item as a seller
#
INSERT INTO
	sellers(name) value('first seller');

SELECT
	seller_id INTO @seller_id_01
FROM
	sellers
WHERE
	name = 'first seller';

INSERT INTO
	categories(name) value('book');

SELECT
	category_id INTO @category_id_01
FROM
	categories
WHERE
	name = 'book';

INSERT INTO
	products(name, category_id) value('the first book', @category_id_01);

SELECT
	product_id INTO @product_id_01
FROM
	products
WHERE
	name = 'the first book'
LIMIT
	1;

INSERT INTO
	items(product_id, seller_id, price, quantity) value(@product_id_01, @seller_id_01, 23.45, 3000);

INSERT INTO
	items(product_id, seller_id, price, quantity) value(@product_id_01, @seller_id_01, 123.45, 3000);

SELECT
	item_id INTO @item_id_01
FROM
	items
LIMIT
	1;

SELECT
	item_id INTO @item_id_02
FROM
	items
LIMIT
	1 OFFSET 1;

SELECT
	*
FROM
	Shopping_Project.item_view;

#
#04 Add number of item to shopping cart
#
INSERT INTO
	shopping_cart_lines(item_id, quantity) value(@item_id_01, 21);

INSERT INTO
	shopping_cart_lines(item_id, quantity) value(@item_id_02, 121);

SELECT
	*
FROM
	shopping_cart_lines;

SELECT
	shopping_cart_line_id INTO @shopping_cart_line_id_01
FROM
	shopping_cart_lines
LIMIT
	1;

SELECT
	shopping_cart_line_id INTO @shopping_cart_line_id_02
FROM
	shopping_cart_lines
LIMIT
	1 OFFSET 1;

INSERT INTO
	orders(order_date) value('2022-12-12');

SELECT
	order_id INTO @order_id_01
FROM
	orders;

INSERT INTO
	shopping_carts(order_id, shopping_cart_line_id) value(@order_id_01, @shopping_cart_line_id_01);

INSERT INTO
	shopping_carts(order_id, shopping_cart_line_id) value(@order_id_01, @shopping_cart_line_id_02);

SELECT
	*
FROM
	shopping_cart_view;

#
#05 Set the shipping address
#
INSERT INTO
	address(street, city, province, postal_code) value(
		'21 275 Rue Lakeshore Road',
		'Sainte-Anne-de-Bellevue',
		'QC',
		'H9X 3L9'
	);

DELETE FROM
	address
WHERE
	city = 'Sainte-Anne-de-Bellevue';

SELECT
	address_id INTO @address_id_01
FROM
	address
LIMIT
	1;

UPDATE
	orders
SET
	shipping_address_id = @address_id_01
WHERE
	order_id = @order_id_01;

SELECT
	*
FROM
	order_view;

SELECT
	*
FROM
	order_total_view;

#
#06 Set the payment method
#
INSERT INTO
	payment_method_categories(payment_method_category_name) value('MasterCard');

INSERT INTO
	payment_method_categories(payment_method_category_name) value('Visa');

SELECT
	payment_method_category_id INTO @masterCard_category_id
FROM
	payment_method_categories
LIMIT
	1;

SELECT
	payment_method_category_id INTO @visa_category_id
FROM
	payment_method_categories
LIMIT
	1 OFFSET 1;

DESCRIBE payment_methods;

INSERT INTO
	payment_methods(
		payment_method_category_id,
		name_on_card,
		card_number
	) value(
		@masterCard_category_id,
		'Beta',
		'5105105105105100'
	);

INSERT INTO
	payment_methods(
		payment_method_category_id,
		name_on_card,
		card_number
	) value(@visa_category_id, 'Beta', '4111111111111111');

SELECT
	payment_method_id INTO @masterCard_id
FROM
	payment_methods
LIMIT
	1;

SELECT
	payment_method_id INTO @visa_id
FROM
	payment_methods
LIMIT
	1 OFFSET 1;

UPDATE
	orders
SET
	payment_method_id = @masterCard_id
WHERE
	order_id = @order_id_01;

SELECT
	*
FROM
	order_view;

#
#02 Query for total number of sold item in past month
#
UPDATE
	orders
SET
	order_date = '2022-12-12'
WHERE
	order_id = @order_id_01;

SELECT
	*
FROM
	order_seller_view;

SELECT
	sum(quantity)
FROM
	order_seller_view
WHERE
	MONTH(order_date) = '12'
	AND seller_id = @seller_id_01;

#
#03 Query for total income in CAD
#
SELECT
	*
FROM
	order_seller_view;

SELECT
	sum(price * quantity) AS 'total income in CAD'
FROM
	order_seller_view
WHERE
	seller_id = @seller_id_01;
