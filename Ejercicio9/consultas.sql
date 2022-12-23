use Ejercicio9

--1. Hallar para una persona dada, por ejemplo José Pérez, los tipos y números de documentos, nombres, dirección y fecha de nacimiento de todos sus hijos.

declare @nombre varchar(50)
set @nombre = 'Jose Perez'

select ph.TipoDoc,ph.NroDoc,ph.Nombre,ph.Direccion,ph.FechaNac
from Progenitor pr
join Persona pe on(pe.TipoDoc=pr.TipoDoc and pe.NroDoc=pr.NroDoc)
join Persona ph on(ph.TipoDoc=pr.TipoDocHijo and ph.NroDoc=pr.NroDocHijo)
where pe.Nombre like @nombre

--2. Hallar para cada persona los tipos y números de documento, nombre, domicilio y
--fecha de nacimiento de:
--a. Todos sus hermanos, incluyendo medios hermanos.

declare @dniPersona int
set @dniPersona = 45864945

select per.TipoDoc,per.NroDoc,per.Nombre,per.Direccion,per.FechaNac,per.Sexo
from Progenitor p
join Persona per on(per.TipoDoc=p.TipoDocHijo and per.NroDoc=p.NroDocHijo)
where p.NroDoc in (
	select NroDoc
	from Progenitor
	where NroDocHijo = @dniPersona
)
and p.NroDocHijo <> @dniPersona


--b. Su madre
declare @dniPersona int
set @dniPersona = 45864945

select m.TipoDoc,m.NroDoc,m.Nombre,m.Direccion,m.FechaNac,m.Sexo
from Progenitor pr
join Persona m on(m.NroDoc=pr.NroDoc)
where pr.NroDocHijo = @dniPersona
and m.Sexo like 'f'

--c. Su abuelo materno

declare @dniPersona int
set @dniPersona = 45864945

declare @dniMadre int
set @dniMadre = (
select m.NroDoc
from Progenitor pr
join Persona m on(m.NroDoc=pr.NroDoc)
where pr.NroDocHijo = @dniPersona
and m.Sexo like 'f')

select a.TipoDoc,a.NroDoc,a.Nombre,a.Direccion,a.FechaNac,a.Sexo
from Progenitor pr
join Persona a on(a.NroDoc=pr.NroDoc)
where pr.NroDocHijo = @dniMadre
and a.Sexo like 'm'

--d. Todos sus nietos

declare @dniPersona int
set @dniPersona = 30864948

declare @tipoDniPersona varchar(50)
set @tipoDniPersona = 'dni'

select n.TipoDoc,n.NroDoc,n.Nombre,n.Direccion,n.FechaNac,n.Sexo
from Persona n
join Progenitor p on(n.TipoDoc=p.TipoDocHijo and n.NroDoc=p.NroDocHijo)
join(
	select h.TipoDoc,h.NroDoc
	from Persona h
	join Progenitor p on(p.TipoDocHijo=h.TipoDoc and h.NroDoc=p.NroDocHijo)
	where p.TipoDoc=@tipoDniPersona and p.NroDoc=@dniPersona
)hi on(p.TipoDoc=hi.TipoDoc and hi.NroDoc=p.NroDoc)