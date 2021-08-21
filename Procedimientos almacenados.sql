create procedure buscarClientes(@fecha date)
	as
	begin

	declare @cliente int
	declare @fechaIng date
	declare @estado int
	declare @nombre varchar(40)
       declare @cantClientes int
	set @cliente = 1
       set @cantClientes = (select max(idCliente) from clientes)
	
	while @cliente < @cantClientes
	
		begin

		select @nombre = nombre, @fechaIng = fechaIng , @estado = estado 
		from clientes 
		where idCliente = @cliente
			
		if (@fechaIng = @fecha and @estado = 1)
		-- Verificamos si la fecha de ingreso corresponde a la fecha recibida 
		-- y si el estado es igual a 1

		begin 

		if @cliente not in (select id from cliente_hist)
	      --Verificamos que el cliente no esta en la tabla cliente_hist
		-- Si el cliente ya se encuentra, no se va insertar el regitro en la tabla

		  begin

		   insert into cliente_hist values(@cliente, @nombre, @fecha, GETDATE())
		   print concat('Usuario con id ', @cliente, ' ingresado')
	
		   end

        	 end

		set @cliente = @cliente + 1

		end
     end
go
			

exec buscarClientes '2021-08-12'

select * from cliente_hist 
