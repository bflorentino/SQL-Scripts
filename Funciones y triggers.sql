

create database pruebas_procedimientos

use pruebas_procedimientos

create table Cliente(
id int primary key,
nombre varchar(40) not null,
fechaIng date not null,
estado int not null
)

create table Cliente_hist(
id int primary key,
nombre varchar(40) not null,
fechaIng date not null,
fechaMovido date not null
)


create function dbo.CalcularEdad(@cliente int) returns int
-- Funcion que calcula la edad de una persona
	
	as
	begin
		
		declare @edad int
		declare @mesActual int
		declare @mesNacimientoCliente int
		declare @fechaNacCliente date;
		
		set @fechaNacCliente = (select FechaIng from cliente where id = @cliente)


	-- La siguiente condicion es para verificar el mes y el dia de nacimiento de la persona comparandola
	-- con la fecha actual. Si el mes de nacimiento de la persona es mayor al mes de la fecha actual es porque 
    -- la persona todavia no cumple años, por lo que a la edad calculada hay que restarle 1.

		if MONTH(@fechaNacCliente) <= MONTH(getDate()) and Day(@fechaNacCliente) <= Day(getDate())
			begin
				set @edad = DATEDIFF(year, @fechaNacCliente, GETDATE()) 
			end

		else
			begin
				set @edad = DATEDIFF(year, @fechaNacCliente, GETDATE()) - 1
			end
	   return @edad
	end
go


insert into Cliente values (1, 'Jose', '2010-08-10', 1)
insert into cliente values (2, 'Juan', '2005-10-10', 1)
insert into Cliente values (3, 'Jose', '2020-12-12', 1)
insert into Cliente values (4, 'Juana', '2010-08-20', 1)
insert into Cliente values (5, 'Julia', '2020-08-21', 1)
insert into Cliente values (6, 'Julia', '2010-08-21', 1)
insert into Cliente values (7, 'Julia', '2010-08-21', 1)


select * from Cliente
select dbo.CalcularEdad(6) as 'Edad'


create Trigger TRG_INS_CLIENTE on Cliente after insert
as 
	begin

    declare @id int
	declare @nombre varchar(40)
	declare @fechaIng date

	select @id = id, @nombre = nombre, @fechaIng = fechaIng from inserted

    insert into Cliente_hist values ( @id, @nombre, @fechaIng, getDate())

    print 'Se inserto el cliente en la tabla Cliente_hist'

	end
go

insert into Cliente values (8, 'Julia', '2010-08-21', 1)
insert into Cliente values (9, 'Julia', '2010-08-21', 1)
insert into Cliente values (10, 'Julia', '2010-08-21', 1)

select * from Cliente_hist;


