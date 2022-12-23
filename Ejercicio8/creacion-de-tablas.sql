use Ejercicio8


create table Persona(
	cod int,
	nombre_persona varchar(50),
	constraint pk_persona primary key(cod)
)

create table Bar(
	cod int,
	nombre_bar varchar(50),
	constraint pk_bar primary key(cod)
)

create table Cerveza(
	cod int,
	nombre_cerveza varchar(50),
	constraint pk_cerveza primary key(cod)
)

create table Frecuenta(
	persona int,
	bar int,
	constraint pk_frecuenta primary key(persona,bar),
	constraint fk_frecuenta_persona foreign key(persona) references Persona(cod),
	constraint fk_frecuenta_sirve foreign key(bar) references Bar(cod)
)

create table Sirve(
	cod_bar int,
	cod_cerveza int,
	constraint pk_Sirve primary key(cod_bar,cod_cerveza),
	constraint fk_sirve_bar foreign key(cod_bar) references bar(cod),
	constraint fk_sirve_cerveza foreign key(cod_cerveza) references cerveza(cod)
)

create table Gusta(
	cod_persona int,
	cod_cerveza int,
	constraint pk_gusta primary key(cod_persona,cod_cerveza),
	constraint fk_Gusta_persona foreign key(cod_persona) references persona(cod),
	constraint fk_Gusta_cerveza foreign key(cod_cerveza) references cerveza(cod)
)



 