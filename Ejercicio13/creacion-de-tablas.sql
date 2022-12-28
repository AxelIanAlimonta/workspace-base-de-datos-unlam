use ejercicio13

create table Nivel(
	codigo int,
	descripcion varchar(50),
	constraint pk_nivel primary key(codigo)
)

create table Medicion(
	fecha date,
	hora time,
	metrica varchar(50),
	temperatura int,
	presion int,
	humedad int,
	nivel int,
	constraint pk_medicion primary key(fecha,hora,metrica),
	constraint fk_medicion_nivel foreign key(nivel)references Nivel(codigo)
)