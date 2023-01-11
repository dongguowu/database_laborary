USE Shopping_Project;

# List all items
CREATE
OR REPLACE VIEW item_view AS
SELECT
	item_id,
	p.name AS 'product_name',
	s.name AS 'seller_name',
	s.seller_id AS 'seller_id',
	price,
	quantity
FROM
	items i
	RIGHT JOIN products p ON i.product_id = p.product_id
	RIGHT JOIN sellers s ON i.seller_id = s.seller_id;

CREATE
OR REPLACE VIEW shopping_cart_view AS
SELECT
	order_id,
	l.item_id AS 'item_id',
	i.product_name AS 'product_name',
	i.seller_name AS 'seller_name',
	i.seller_id AS 'seller_id',
	i.price AS 'price',
	l.quantity AS 'quantity'
FROM
	shopping_carts s
	RIGHT JOIN shopping_cart_lines l ON s.shopping_cart_line_id = l.shopping_cart_line_id
	RIGHT JOIN item_view i ON l.item_id = i.item_id;

DESCRIBE shopping_cart_view;

CREATE
OR REPLACE order_subtotal_view AS
SELECT
	o.order_id,
	v.price AS 'priceOfUnit',
	v.quantity AS 'quantity',
	v.price * v.quantity AS 'subtotal'
FROM
	orders o
	LEFT JOIN shopping_cart_view v ON o.order_id = v.order_id;

DESCRIBE order_subtotal_view;

CREATE
OR REPLACE order_total_view AS
SELECT
	order_id,
	sum(subtotal) AS 'order_total',
	sum(quantity) AS 'quantity_total'
FROM
	order_subtotal_view
GROUP BY
	order_id;

CREATE
OR REPLACE order_view AS
SELECT
	v.order_id,
	o.order_date,
	v.order_total,
	v.quantity_total,
	concat(
		a.street,
		' ',
		a.city,
		' ',
		a.province,
		' ',
		a.postal_code
	) AS 'shipping_address',
	concat(
		c.payment_method_category_name,
		': ',
		p.name_on_card,
		' ',
		p.card_number
	) AS 'payment_method'
FROM
	order_total_view v
	LEFT JOIN orders o ON v.order_id = o.order_id
	LEFT JOIN address a ON o.shipping_address_id = a.address_id
	LEFT JOIN payment_methods p ON o.payment_method_id = p.payment_method_id
	LEFT JOIN payment_method_categories c ON p.payment_method_category_id = c.payment_method_category_id;

CREATE
OR REPLACE order_seller_view AS
SELECT
	o.order_date AS 'order_date',
	s.order_id AS 'order_id',
	s.item_id AS 'item_id',
	s.seller_id,
	s.price,
	s.quantity
FROM
	shopping_cart_view s
	LEFT JOIN orders o ON s.order_id = o.order_id;
