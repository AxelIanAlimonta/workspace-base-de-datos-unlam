use Ejercicio9

create table Persona(
	TipoDoc varchar(50),
	NroDoc int,
	Nombre varchar(50),
	Direccion varchar(50),
	FechaNac date,
	Sexo char(1),
	constraint pk_persona primary key(tipodoc,nrodoc)
	)

create table Progenitor(
	TipoDoc varchar(50),
	NroDoc int,
	TipoDocHijo varchar(50),
	NroDocHijo int,
	constraint pk_progenitor primary key(tipodoc,nrodoc,tipodochijo,nrodochijo),
	constraint fk_progenitor_persona foreign key(tipodoc,nrodoc) references Persona(TipoDoc,NroDoc),
	constraint fk_progenitor_hijo_persona foreign key(tipodochijo,nrodochijo) references Persona(TipoDoc,NroDoc)
)