SELECT 	get_or_create_seller_id('Momox_Shop') INTO @seller_id_21;
SELECT 	get_or_create_seller_id('topshoesUS') INTO @seller_id_22;
SELECT 	get_or_create_seller_id('Rarewaves-CA') INTO @seller_id_23;
SELECT 	get_or_create_seller_id('Chalkys CA') INTO @seller_id_24;
SELECT 	get_or_create_seller_id('EPFamily Direct') INTO @seller_id_25;

SELECT 	get_or_create_product_id('Friends, Lovers, and the Big Terrible Thing', 'Book') INTO @product_id_21;
SELECT 	get_or_create_product_id('Verity', 'Book') INTO @product_id_22;
SELECT 	get_or_create_product_id('Stop Overthinking', 'Book') INTO @product_id_23;
SELECT 	get_or_create_product_id('Scattered Minds', 'Book') INTO @product_id_24;
SELECT 	get_or_create_product_id('How to Draw 101 Animals', 'Book') INTO @product_id_25;
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_21, @seller_id_21, 32.38, 500);
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_22, @seller_id_21, 17.75, 500);
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_23, @seller_id_21, 18.39, 500);
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_24, @seller_id_21, 23.90, 500);
INSERT INTO items(product_id, seller_id, price, quantity) value(@product_id_25, @seller_id_21, 3.75, 500);

SELECT 	get_or_create_seller_id('Apple') INTO @seller_id_01;
SELECT 	get_or_create_product_id('Apple MacBook', 'Computer') INTO @product_id_01;