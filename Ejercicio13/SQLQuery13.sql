use ejercicio13

--1. p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas
--de nuestro modelo relacional.

create proc p_CrearEndidades as
begin
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
end

create proc p_EliminarEntidades as
begin
	drop table if exists Medicion
	drop table if exists Nivel
end

--2. f_ultimamedicion(Métrica): Realizar una función que devuelva la fecha y hora
--de la última medición realizada en una métrica específica, la cual será enviada
--por parámetro. La sintaxis de la función deberá respetar lo siguiente:
--Fecha/hora = f_ultimamedicion(@Metrica varchar(5))
--Ejemplificar el uso de la función.

create function f_ultimamedicion(@Metrica varchar(5))
returns datetime as
begin
	declare @fecha date
	set @fecha =(
		select MAX(fecha)
		from Medicion
		where metrica like @Metrica
		)
	declare @hora time
	set @hora =(
		select MAX(hora)
		from Medicion
		where metrica like @Metrica
		and fecha=@fecha
	)
	return convert(datetime,@fecha)+convert(datetime,@hora)
end

declare @metrica varchar(5)
set @metrica='m1'

select [dbo].[f_ultimamedicion](@metrica)


--3. v_Listado: Realizar una vista que permita listar las métricas en las cuales se
--hayan realizado, en la última semana, mediciones para todos los niveles
--existentes. El resultado del listado deberá mostrar, el nombre de la métrica que
--respete la condición enunciada, el máximo nivel de temperatura de la última
--semana y la cantidad de mediciones realizadas también en la última semana.


select metrica,MAX(temperatura)max_temperatura,COUNT(metrica)cant_de_mediciones
from Medicion
where fecha between DATEADD(DAY,-7,GETDATE()) and GETDATE()
group by metrica
having COUNT(distinct nivel)=(
	select COUNT(*)
	from nivel
)

--4. p_ListaAcumulados(finicio,ffin): Realizar un procedimiento que permita
--generar una tabla de acumulados diarios de temperatura por cada métrica y
--por cada día. El procedimiento deberá admitir como parámetro el rango de
--fechas que mostrará el reporte. Además, estas fechas deben ser validadas.
--El informe se deberá visualizar de la siguiente forma: Fecha - Metrica - Ac.DiarioTemp - Ac.Temp

create proc p_ListaAcumulados
@finicio date,@ffin date
as
begin
declare @Metrica varchar(5)
set @Metrica=(
select metrica
from Medicion
where fecha between @finicio and @ffin
group by metrica
having COUNT(distinct fecha)=DATEDIFF(DAY,@finicio,@ffin)+1)

select fecha,metrica,SUM(temperatura)AcDiarioTemp,SUM(SUM(temperatura))over(partition by metrica order by fecha)AcTemp
from Medicion
where metrica=@Metrica
and fecha between @finicio and @ffin
group by metrica,fecha
end

exec p_ListaAcumulados '2022-1-1','2022-1-5'

--5. p_InsertMedicion(fecha,hora, metrica,temp,presion,hum,niv):
--Realizar un procedimiento que permita agregar una nueva medición en su respectiva
--entidad. Los parámetros deberán ser validados según:
--a. Para una nueva fecha hora, no puede haber más de una medida por
--métrica
--b. El valor de humedad sólo podrá efectuarse entre 0 y 100.
--c. El campo nivel deberá ser válido, según su correspondiente entidad.

create proc p_InsertMedicion
@fecha date, @hora time, @metrica varchar(5),@temp int,@presion int,@hum int, @niv int
as
begin
	if @hum>=0 and @hum<=100 and exists(select 1 from Nivel where codigo =@niv) 
	and not exists(select 1 from Medicion where fecha=@fecha and hora=@hora and metrica=@metrica)
	begin
		insert into Medicion values(@fecha,@hora,@metrica,@temp,@presion,@hum,@niv)
	end
	else
	begin
	select 'Parametros no válidos' Mensaje
	end
end

--ejemplos de parametros no válidos
exec p_InsertMedicion '2022-01-01','3:00:00','M3',5,6,9,2
exec p_InsertMedicion '2022-01-01','3:00:00','M4',5,6,9,10
exec p_InsertMedicion '2022-01-01','3:00:00','M4',5,6,200,1

--7. tg_descNivel: Realizar un trigger que coloque la descripción en mayúscula
--cada vez que se inserte un nuevo nivel.

create trigger tr_descNivel on Nivel
instead of insert as
begin
	set nocount on	
	declare @cod int
	set @cod = (
		select codigo
		from inserted
	)

	declare @desc varchar(50)
	set @desc = (
		select upper(descripcion)
		from inserted
	)
	insert into Nivel values(@cod,@desc)
end

