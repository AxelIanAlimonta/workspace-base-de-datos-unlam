use Ejercicio8

--1. Frecuentan solamente bares que sirven alguna cerveza que les guste.
select distinct persona
from
(
	select persona,bar
	from Frecuenta
	except
	(
	select  persona,bar
	from Frecuenta
	except
	select  g.cod_persona,s.cod_cerveza
	from Gusta g
	join Sirve s on(g.cod_cerveza=s.cod_cerveza)
	)
)x

--2. No frecuentan ningún bar que sirva alguna cerveza que les guste.

select persona
from Frecuenta
except
select persona
from(
select persona,bar
from Frecuenta
intersect
select g.cod_persona,s.cod_bar
from Gusta g
join Sirve s on(g.cod_cerveza=s.cod_cerveza)
)x

--3. Frecuentan solamente los bares que sirven todas las cervezas que les gustan.

