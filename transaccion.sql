\c unidad2
\set AUTOCOMMIT off

BEGIN TRANSACTION;
INSERT INTO compra(cliente_id, fecha)
VALUES(1, now());
INSERT INTO detalle_compra(producto_id, compra_id, cantidad)
VALUES(9, (SELECT MAX(id) FROM compra), 5);
UPDATE producto SET stock = stock-5 WHERE id= 9;
COMMIT;

SELECT id, stock FROM producto WHERE id =9;


BEGIN TRANSACTION;
INSERT INTO compra(cliente_id, fecha)
VALUES(2, now());
INSERT INTO detalle_compra(producto_id, compra_id, cantidad)

VALUES(1, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock-3 WHERE id= 1;

VALUES(2, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock-3 WHERE id= 2;

SAVEPOINT error;
VALUES(8, (SELECT MAX(id) FROM compra), 3);
UPDATE producto SET stock = stock-3 WHERE id= 8;
ROLLBACK TO error;
COMMIT;

SELECT id, stock FROM producto WHERE id =1;
SELECT id, stock FROM producto WHERE id =2;
SELECT id, stock FROM producto WHERE id =8;


-- a. Deshabilitar el AUTOCOMMIT
-- b. Insertar un nuevo cliente
-- c. Confirmar que fue agregado en la tabla cliente
-- d. Realizar un ROLLBACK
-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b
-- f. Habilitar de nuevo el AUTOCOMMIT

\set AUTOCOMMIT off
BEGIN TRANSACTION;
SAVEPOINT nuevo_cliente;
INSERT INTO cliente(nombre, email)
VALUES ('Fabian Salas','sfabian.orozco@gmail.com');
SELECT * FROM cliente;
ROLLBACK TO nuevo_cliente;
SELECT * FROM cliente;
COMMIT;
\set AUTOCOMMIT ON