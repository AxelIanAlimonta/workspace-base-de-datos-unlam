USE Ejercicio3;

INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (1, 'Juan','123qw',3095513451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (2, 'Hernan','143qw',3325513451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (3, 'Sergio','163qw',30953243451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (4, 'Jesica','183qw',3095223451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (5, 'Fernando','1893qw',30946783451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (6, 'Esteban','1673qw',3095456451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (7, 'Gustavo','1793qw',3326423451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (8, 'Ruben','1676w',309234243451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) VALUES (9, 'Ariel','18378',3097788451);


INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (1, 1, 'Villegas','1780',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (2, 1, 'Aquino','1790','3','B');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (3, 1, 'Morlaco','1250','7','A');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (4, 1, 'Fornuloco','8980',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (5, 1, 'Galmarini','280','3','C');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (6, 1, 'Leandro Alem','80',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (7, 1, 'Santa Rosa','180','8','D');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (8, 1, 'Budaguest','10',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (9, 1, 'Rivadavia','3520',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto) VALUES (10, 1, 'Rolchart','2580',null,null);

INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (1, 'Ricardo','223qw',3094413451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (2, 'Daniel','223qw',3094413451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (3, 'Ines','243qw',3324413451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (4, 'Nancy','263qw',30943243451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (5, 'Jesica','283qw',3094223451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (6, 'Fernando','2893qw',30944583451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (7, 'Esteban','2673qw',3095546451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (8, 'Gustavo','2793qw',3426423451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (9, 'Ruben','2676w',329234243451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit) VALUES (10,'Ariel','28378',3297788451);

INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (1, 1, 'goma','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (2, 2, 'libro','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (3, 3, 'hojas','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (4, 2, 'birome','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (5, 3, 'lapicera','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (6, 3, 'cuaderno','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (7, 4, 'clip','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (8, 5, 'cartuchera','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (9, 6, 'carpeta','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor, nombre,descripcion,estado) VALUES (10,7, 'secante','libreria','stock');


INSERT INTO Vendedor VALUES (1, 'Sergio', 'Adamoli', 35204761);
INSERT INTO Vendedor VALUES (2, 'hernan', 'Bruno', 32204761);
INSERT INTO Vendedor VALUES (5, 'jesica', 'Sieiro', 31204761);
INSERT INTO Vendedor VALUES (6, 'Roberto', 'Granja', 34204761);
INSERT INTO Vendedor VALUES (7, 'Gustavo', 'Fornica', 45204761);
INSERT INTO Vendedor VALUES (8, 'Ariel', 'Zerpa', 25204761);
INSERT INTO Vendedor VALUES (9, 'Rafael', 'Miceli', 55204761);
INSERT INTO Vendedor VALUES (10, 'Daniel', 'Bustamante', 35204661);
INSERT INTO Vendedor VALUES (11, 'Ingrid', 'Vadala', 35204561);
INSERT INTO Vendedor VALUES (12, 'Alberto', 'Fernandez', 35204731);


INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (1, 4,2,'2011-06-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (2, 2,2,'2011-05-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (3, 3,5,'2011-04-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (4, 1,6,'2011-03-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (5, 5,7,'2011-02-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (6, 1,8,'2011-01-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (7, 3,9,'2011-07-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (8, 4,10,'2011-08-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (9, 5,11,'2011-09-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (10, 5,15,'2019-09-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (11, 1,1,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (12, 1,2,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (13, 1,3,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (14, 1,4,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (15, 1,5,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (16, 1,6,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (17, 1,7,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (18, 1,8,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (19, 1,9,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (20, 1,10,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (21, 1,11,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (22, 1,12,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (23, 1,13,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (24, 1,14,'2020-06-02');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha) VALUES (25, 1,15,'2020-06-02');



INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (1, 1, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (1, 2, 2, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (1, 3, 3, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (2, 1, 4, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (2, 2, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (3, 1, 5, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (4, 1, 6, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (5, 1, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (6, 1, 4, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (7, 1, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (7, 2, 2, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (8, 1, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (9, 1, 3, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (9, 2, 1, 10, 30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario ) VALUES (10, 2, 1, 10, 30);

