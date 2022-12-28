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

--2. f_ultimamedicion(M�trica): Realizar una funci�n que devuelva la fecha y hora
--de la �ltima medici�n realizada en una m�trica espec�fica, la cual ser� enviada
--por par�metro. La sintaxis de la funci�n deber� respetar lo siguiente:
--Fecha/hora = f_ultimamedicion(@Metrica varchar(5))
--Ejemplificar el uso de la funci�n.

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


--3. v_Listado: Realizar una vista que permita listar las m�tricas en las cuales se
--hayan realizado, en la �ltima semana, mediciones para todos los niveles
--existentes. El resultado del listado deber� mostrar, el nombre de la m�trica que
--respete la condici�n enunciada, el m�ximo nivel de temperatura de la �ltima
--semana y la cantidad de mediciones realizadas tambi�n en la �ltima semana.


select metrica,MAX(temperatura)max_temperatura,COUNT(metrica)cant_de_mediciones
from Medicion
where fecha between DATEADD(DAY,-7,GETDATE()) and GETDATE()
group by metrica
having COUNT(distinct nivel)=(
	select COUNT(*)
	from nivel
)

--4. p_ListaAcumulados(finicio,ffin): Realizar un procedimiento que permita
--generar una tabla de acumulados diarios de temperatura por cada m�trica y
--por cada d�a. El procedimiento deber� admitir como par�metro el rango de
--fechas que mostrar� el reporte. Adem�s, estas fechas deben ser validadas.
--El informe se deber� visualizar de la siguiente forma: Fecha - Metrica - Ac.DiarioTemp - Ac.Temp

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
--Realizar un procedimiento que permita agregar una nueva medici�n en su respectiva
--entidad. Los par�metros deber�n ser validados seg�n:
--a. Para una nueva fecha hora, no puede haber m�s de una medida por
--m�trica
--b. El valor de humedad s�lo podr� efectuarse entre 0 y 100.
--c. El campo nivel deber� ser v�lido, seg�n su correspondiente entidad.

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
	select 'Parametros no v�lidos' Mensaje
	end
end

--ejemplos de parametros no v�lidos
exec p_InsertMedicion '2022-01-01','3:00:00','M3',5,6,9,2
exec p_InsertMedicion '2022-01-01','3:00:00','M4',5,6,9,10
exec p_InsertMedicion '2022-01-01','3:00:00','M4',5,6,200,1

--7. tg_descNivel: Realizar un trigger que coloque la descripci�n en may�scula
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

