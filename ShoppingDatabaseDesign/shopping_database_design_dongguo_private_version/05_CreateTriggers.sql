use shopping;


#
# Reduce the items quantity after the item added to the shopping cart
#
DROP TRIGGER IF EXISTS update_items_quantity;
DELIMITER $$
CREATE TRIGGER update_items_quantity
AFTER INSERT ON shopping_cart_lines
FOR EACH ROW
BEGIN
    UPDATE items SET quantity = quantity - NEW.quantity WHERE item_id = NEW.item_id;
END$$
DELIMITER ;