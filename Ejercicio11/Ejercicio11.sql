use Ejercicio11

--1. Realice las sentencias DDL necesarias para crear en SQL una base de datos
--correspondiente al modelo relacional del enunciado.

create table Genero(
	Id int,
	NombGenero varchar(50),
	constraint pk_genero primary key(id)
)

create table Director(
	Id int,
	NyA varchar(50),
	constraint pk_id primary key(id)
)

create table Pelicula(
	CodPel int,
	Titulo varchar(50),
	Duracion time,
	CodGenero int,
	IdDirector int,
	constraint pk_pelicula primary key(codpel),
	constraint fk_pelicula_genero foreign key(codgenero) references Genero(Id),
	constraint fk_pelicula_director foreign key(IdDirector) references Director(Id),

)


create table Ejemplar(
	nroEj int,
	CodPel int,
	Estado bit,
	constraint pk_ejemplar primary key(nroEj,codpel),
	constraint fk_ejemplar_pelicula foreign key(codpel) references Pelicula(codpel)
)

create table Cliente(
	CodCli int,
	NyA varchar(50),
	Direccion varchar(50),
	Tel varchar(50),
	Email varchar(50),
	Borrado smallint default 2,
	constraint pk_cliente primary key(codcli)
)

create table Alquiler(
	id int,
	NroEj int,
	CodPel int,
	CodCli int,
	FechaAlq date,
	FechaDev date,
	constraint pk_alquiler primary key(id),
	constraint fk_alquiler_ejemplar foreign key(nroej,codpel) references Ejemplar(nroej,codpel),
	constraint fk_alquiler_cliente foreign key(codcli) references Cliente(codcli),
)

--2. Realice los INSERTs necesarios para cargar en las tablas creadas en el punto
--anterior los datos de clientes, peliculas (y tablas relacionadas a estas) y alquileres.

insert into genero values(	1	,	'Accion'	)
insert into genero values(	2	,	'Terror'	)
insert into genero values(	3	,	'Comedia'	)

insert into Director values(	1	,	'Quentin Tarantino'	)
insert into Director values(	2	,	'Tod Browning'	)

insert into Pelicula values(	1	,	'Kill Bill'	,	'1:51:00'	,	1	,	1	)
insert into Pelicula values(	2	,	'Django sin cadenas'	,	'2:45:00'	,	1	,	1	)
insert into Pelicula values(	3	,	'Bastardos sin gloria'	,	'2:33:00'	,	1	,	1	)
insert into Pelicula values(	4	,	'Dracula'	,	'1:15:00'	,	2	,	2	)


insert into Ejemplar values(	1	,	1	,	0	)
insert into Ejemplar values(	2	,	1	,	0	)
insert into Ejemplar values(	3	,	1	,	0	)
insert into Ejemplar values(	4	,	1	,	0	)
insert into Ejemplar values(	1	,	2	,	0	)
insert into Ejemplar values(	2	,	2	,	0	)
insert into Ejemplar values(	3	,	2	,	0	)
insert into Ejemplar values(	4	,	2	,	0	)
insert into Ejemplar values(	1	,	3	,	0	)
insert into Ejemplar values(	2	,	3	,	0	)
insert into Ejemplar values(	3	,	3	,	0	)
insert into Ejemplar values(	4	,	3	,	0	)
insert into Ejemplar values(	1	,	4	,	0	)
insert into Ejemplar values(	2	,	4	,	0	)
insert into Ejemplar values(	3	,	4	,	0	)
insert into Ejemplar values(	4	,	4	,	0	)

insert into Cliente values(	1	,	'Concepcion Rebollo'	,	'dir 123'	,	'11-4598-1354'	,	'Concepcion_Rebollo@gmail.com'	,	2	)
insert into Cliente values(	2	,	'Micaela Sandoval'	,	'dir 322'	,	'11-3322-1354'	,	'Micaela_Sandoval@gmail.com'	,	2	)
insert into Cliente values(	3	,	'Luciana de Diego'	,	'dir 334'	,	'11-4598-4432'	,	'Luciana_de_Diego@gmail.com'	,	2	)
insert into Cliente values(	4	,	'Federico Gonzalez'	,	'dir 100'	,	'11-4598-0011'	,	'Federico_Gonzalez@gmail.com'	,	2	)
insert into Cliente values(	5	,	'Ana Prats'	,	'dir 123'	,	'11-3312-4431'	,	'Ana_Prats@gmail.com'	,	2	)

insert into Alquiler values(	1	,	3	,	2	,	2	,	'2022-1-1'	,	'2022-1-6'	)
insert into Alquiler values(	2	,	2	,	3	,	2	,	'2022-1-7'	,	'2022-1-13'	)
insert into Alquiler values(	3	,	1	,	2	,	1	,	'2022-1-14'	,	'2022-1-20'	)
insert into Alquiler values(	4	,	3	,	1	,	1	,	'2022-1-21'	,	'2022-1-27'	)
insert into Alquiler values(	5	,	3	,	2	,	1	,	'2022-1-28'	,	'2022-2-7'	)
insert into Alquiler values(	6	,	1	,	1	,	4	,	'2022-2-7'	,	'2022-2-14'	)
insert into Alquiler values(	7	,	3	,	2	,	2	,	'2022-2-14'	,	'2022-2-21'	)

--3. Agregue el atributo “año” en la tabla Película.

alter table Pelicula
add año int

--4. Actualice la tabla película para que incluya el año de lanzamiento de las películas
	--en stock.
update Pelicula
set año = 1931
where CodPel=4

update Pelicula
set año = 2003
where CodPel=1

update Pelicula
set año = 2012
where CodPel=2

update Pelicula
set año = 2009
where CodPel=3

--5. Queremos que al momento de eliminar una película se eliminen todos los
--ejemplares de la misma. Realice una CONSTRAINT para esta tarea.

alter table ejemplar
drop constraint fk_ejemplar_pelicula

alter table ejemplar 
add constraint fk_ejemplar_pelicula foreign key(codpel) references Pelicula(codpel) on delete cascade

--6. Queremos que exista un borrado de lógico y no físico de clientes, realice un
--TRIGGER que usando el atributo “Borrado” haga esta tarea.


create trigger tr_borrado_logico_cliente
on cliente instead of delete
as
set nocount on
update cliente
set Borrado=1
where CodCli in(
	select CodCli
	from deleted
)

--7. Elimine las películas de las que no se hayan alquilado ninguna copia.

delete from Pelicula
where CodPel not in(
	select CodPel
	from Alquiler
)


--8. Elimine los clientes sin alquileres.

delete from Cliente
where CodCli not in(
	select CodCli
	from Alquiler
)

