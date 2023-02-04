USE shopping;

# List products
CREATE
OR REPLACE VIEW product_view AS
SELECT
	p.product_id AS 'product_id',
	p.name AS 'name',
	c.name AS 'category'
FROM
	products p
	LEFT JOIN categories c ON p.category_id = c.category_id;

# List items
CREATE
OR REPLACE VIEW items_view AS
SELECT
	i.item_id AS 'item_id',
	p.name AS 'product_name',
    p.category,
    p.product_id AS 'product_id',
	s.name AS 'seller_name',
	s.seller_id AS 'seller_id',
	i.price AS 'price',
	i.quantity AS 'quantity'
FROM
	items i
	LEFT JOIN product_view p ON i.product_id = p.product_id
	LEFT JOIN sellers s ON i.seller_id = s.seller_id;


CREATE
OR REPLACE VIEW shopping_cart_view AS
SELECT
	o.order_id AS 'order_id',
	l.item_id AS 'item_id',
	i.product_name AS 'product_name',
	i.seller_name AS 'seller_name',
	i.seller_id AS 'seller_id',
	i.price AS 'price',
	l.quantity AS 'quantity'
FROM
	orders_shopping_cart_lines o
	LEFT JOIN shopping_cart_lines l ON o.shopping_cart_line_id = l.shopping_cart_line_id
	LEFT JOIN items_view i ON l.item_id = i.item_id;


CREATE
OR REPLACE VIEW order_subtotal_view AS
SELECT
	o.order_id,
	s.price AS 'priceOfUnit',
	s.quantity AS 'quantity',
	s.price * s.quantity AS 'subtotal'
FROM
	orders o
	LEFT JOIN shopping_cart_view s ON o.order_id = s.order_id;

CREATE
OR REPLACE VIEW order_total_view AS
SELECT
	order_id,
	sum(subtotal) AS 'order_total',
	sum(quantity) AS 'quantity_total'
FROM
	order_subtotal_view
GROUP BY
	order_id;
    

CREATE
OR REPLACE VIEW order_view AS
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
	LEFT JOIN addresses a ON o.address_id = a.address_id
	LEFT JOIN payment_methods p ON o.payment_method_id = p.payment_method_id
	LEFT JOIN payment_method_categories c ON p.payment_method_category_id = c.payment_method_category_id;

CREATE
OR REPLACE VIEW order_seller_view AS
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
    
    
CREATE
OR REPLACE VIEW payment_method_view AS
SELECT
	p.payment_method_id,
    c.payment_method_category_name,
    p.name_on_card,
    p.card_number
FROM
	payment_methods p
	LEFT JOIN payment_method_categories c ON p.payment_method_category_id = c.payment_method_category_id;
