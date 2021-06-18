
BEGIN TRANSACTION;
INSERT INTO compra(cliente_id, fecha)
VALUES(1, now());
INSERT INTO detalle_compra(producto_id, compra_id, cantidad)
VALUES(9, (SELECT MAX(id) FROM compra), 5);
UPDATE producto SET stock = stock-5 WHERE id= 9;
COMMIT;


BEGIN TRANSACTION;
INSERT INTO compra(cliente_id, fecha)
VALUES(2, now());
INSERT INTO detalle_compra(producto_id, compra_id, cantidad)
VALUES(1, (SELECT MAX(id) FROM compra), 3);
VALUES(2, (SELECT MAX(id) FROM compra), 3);
VALUES(8, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock-3 WHERE id= 1;
UPDATE producto SET stock = stock-3 WHERE id= 2;
UPDATE producto SET stock = stock-3 WHERE id= 8;
COMMIT;

-- a. Deshabilitar el AUTOCOMMIT
-- b. Insertar un nuevo cliente
-- c. Confirmar que fue agregado en la tabla cliente
-- d. Realizar un ROLLBACK
-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b
-- f. Habilitar de nuevo el AUTOCOMMIT

\set AUTOCOMMIT off
SAVEPOINT nuevo_cliente;
INSERT INTO cliente(nombre, email)
VALUES ('Fabian Salas','sfabian.orozco@gmail.com');
ROLLBACK TO nuevo_cliente;
COMMIT;
\set AUTOCOMMIT off