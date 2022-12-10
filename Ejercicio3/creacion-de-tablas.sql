CREATE DATABASE Ejercicio3;
GO
USE Ejercicio3;

CREATE TABLE Proveedor(
	Id_proveedor INT,
	Nombre VARCHAR(50),
	Responsabilidad_civil VARCHAR(50),
	Cuit BIGINT,
	PRIMARY KEY(id_proveedor)
);

CREATE TABLE Producto(
	Id_producto INT,
	Nombre VARCHAR(50),
	Descripcion VARCHAR(50),
	Estado VARCHAR(50),
Id_proveedor INT,
	PRIMARY KEY(id_producto),
FOREIGN KEY(id_proveedor)
REFERENCES proveedor(id_proveedor) 
);

CREATE TABLE Cliente(
	Id_cliente INT,
	Nombre VARCHAR(50),
	Resp_iva VARCHAR(50),
	Cuit BIGINT,
	PRIMARY KEY(id_cliente)
);

CREATE TABLE Direccion(
	Id_dir INT,
	Id_pers INT,
	Calle VARCHAR(100),
	nro INT,
	piso INT,
	dpto CHAR,
	PRIMARY KEY(id_dir),
	FOREIGN KEY(id_pers)
REFERENCES cliente(id_cliente)
);

CREATE TABLE Vendedor(
	Id_vendedor INT,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Dni BIGINT,
	PRIMARY KEY(id_vendedor)
);

CREATE TABLE Venta(
	Nro_factura BIGINT,
	Id_cliente INT,
	Id_vendedor INT,
	Fecha DATE ,
	PRIMARY KEY(nro_factura),
	FOREIGN KEY(id_cliente)REFERENCES cliente(id_cliente),
	FOREIGN KEY(id_vendedor)REFERENCES vendedor(id_vendedor)
);

CREATE TABLE Detalle_venta(
	Nro_factura BIGINT,
	Nro_detalle BIGINT,
	Id_producto INT,
	Cantidad INT,
	Precio_unitario INT,
	PRIMARY KEY(nro_factura, nro_detalle),
	FOREIGN KEY(nro_factura)REFERENCES venta(nro_factura) ON DELETE CASCADE,
	FOREIGN KEY(id_producto)REFERENCES producto(id_producto)
);



