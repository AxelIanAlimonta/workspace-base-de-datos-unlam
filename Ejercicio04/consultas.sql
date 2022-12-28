use Ejercicio4

--a. Encontrar el nombre de todas las personas que trabajan en la empresa “Nestlé”.

select *
from Trabaja
where nomEmpresa like 'Nestl_' 
and feEgreso is null

--b. Localizar el nombre y la ciudad de todas las personas que trabajan para la empresa “Nestlé”.

select p.nomPersona,v.ciudad
from Trabaja t
join Persona p on(t.dni=p.dni)
join Vive v on(p.dni=v.dni)
where t.nomEmpresa like 'Nestl_' 
and t.feEgreso is null

--c. Buscar el nombre, calle y ciudad de todas las personas que trabajan para la empresa “Pepsico” y ganan más de $150000.

select *
from Persona p
join Trabaja t on(p.dni=t.dni)
where t.salario>150000
and nomEmpresa like 'pepsico'

--d. Encontrar las personas que viven en la misma ciudad en la que se halla la empresa en donde trabajan.

select t.dni
from Trabaja t
join Situada_en s on(s.nomEmpresa=t.nomEmpresa)
join Vive v on(v.dni=t.dni)
where s.ciudad=v.ciudad

--e. Hallar todas las personas que viven en la misma ciudad y en la misma calle que su supervisor.

select *
from Supervisa s
join Vive vSup on(s.dniSup=vSup.dni)
join Vive vPer on(s.dniPer=vPer.dni)
where vSup.ciudad=vPer.ciudad
and vSup.calle=vPer.calle


--f. Encontrar todas las personas que ganan más que cualquier empleado de la empresa “Unilever”.

declare @maxSal money
set @maxSal= (
	select MAX(salario)
	from Trabaja
	where nomEmpresa like 'Unilever'
)

select *
from Trabaja 
where salario>@maxSal


--g. Localizar las ciudades en las que todos los trabajadores que viven en ellas ganan más de $100000.

select ciudad
from Vive v
join Trabaja t on(t.dni=v.dni)
where t.salario>100000
except
select ciudad
from Vive v
join Trabaja t on(t.dni=v.dni)
where t.salario<=100000

--h. Listar los primeros empleados que la compañía “Pepsico” contrató.

declare @fechPrimEmpl date
set @fechPrimEmpl = (
	select min(feIngreso)
	from Trabaja	
)

select dni
from Trabaja
where feIngreso=@fechPrimEmpl


--i. Listar los empleados que hayan ingresado en mas de 4 Empresas en el periodo 01-01-2000 y 31-03-2004 y que no hayan tenido menos de 5 supervisores
select dni
from Trabaja
where feIngreso between '01-01-2000' and '31-03-2004'
group by dni
having COUNT(nomEmpresa)>4
except
select dniPer
from Supervisa
group by dniPer
having COUNT(dniSup)>=5