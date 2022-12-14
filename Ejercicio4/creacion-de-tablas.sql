use Ejercicio4
go

create table Persona(
	dni int,
	nomPersona varchar(50),
	telefono varchar(50),
	constraint pk_persona primary key(dni)
)

create table Empresa(
	nomEmpresa varchar(50),
	telefono varchar(50)
	constraint pk_empresa primary key(nomEmpresa)	
)

create table Vive(
	dni int,
	calle varchar (50),
	ciudad varchar(50),
	constraint pk_vive primary key(dni),
	constraint fk_vive_persona foreign key(dni) references Persona(dni)
)

create table Trabaja(
	dni int,
	nomEmpresa varchar(50),
	salario money,
	feIngreso date,
	feEgreso date,
	constraint pk_trabaja primary key(dni),
	constraint fk_trabaja_persona foreign key(dni) references Persona(dni),
	constraint fk_trabaja_empresa foreign key(nomEmpresa) references Empresa(nomEmpresa)
)

create table Situada_en(
	nomEmpresa varchar(50),
	ciudad varchar(50),
	constraint pk_situada_en primary key(nomEmpresa),
	constraint fk_situada_en_empresa foreign key(nomEmpresa) references Empresa(nomEmpresa),
)

create table Supervisa(
	dniPer int,
	dniSup int,
	constraint pk_supervisa primary key(dniPer,dniSup),
	constraint fk_supervisa_persona_supervisado foreign key(dniPer) references Persona(dni),
	constraint fk_supervisa_persona_supervisor foreign key(dniSup) references Persona(dni)
)