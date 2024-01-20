-- crear una vista
-- mostrar id articulo, nombre proveedor, contacto de proveedor, nombre producto, stock

alter view Vista_ControlStock
as
select
	p.ProductID,
	c.CategoryName categoria,
	s.CompanyName nombreProveedor,
	s.ContactName contactoProveedor,
	s.Phone telefonoProveedor,
	p.ProductName nombreProducto,
	p.UnitsInStock stockProducto
from Products p
join Suppliers s on p.SupplierID = s.SupplierID
join Categories c on p.CategoryID = c.CategoryID
go
select * from Vista_ControlStock

create procedure Proc_Stock
(@idCategoria int= 0)
as
if @idCategoria <> 0
	begin
		select
			p.ProductID,
			c.CategoryName categoria,
			s.CompanyName nombreProveedor,
			s.ContactName contactoProveedor,
			s.Phone telefonoProveedor,
			p.ProductName nombreProducto,
			p.UnitsInStock stockProducto
		from Products p
		join Suppliers s on p.SupplierID = s.SupplierID
		join Categories c on p.CategoryID = c.CategoryID
		where c.CategoryID =@idCategoria
	end
else
begin
	select
		p.ProductID,
		c.CategoryName categoria,
		s.CompanyName nombreProveedor,
		s.ContactName contactoProveedor,
		s.Phone telefonoProveedor,
		p.ProductName nombreProducto,
		p.UnitsInStock stockProducto
	from Products p
	join Suppliers s on p.SupplierID = s.SupplierID
	join Categories c on p.CategoryID = c.CategoryID
end

-- uso del proc
Proc_Stock

Proc_stock 2 --con la categoria

-- procedimiento almacenado 2
create procedure proc_ventas
	@FechaInicio DateTime,
	@FechaFin DateTime
as
if @FechaInicio is null or @FechaFin is null
begin
	raiserror('No se admiten valores nulos',14,1)
	return
end
select
	o.ShippedDate,
	o.OrderID,
	sum(od.Quantity*od.UnitPrice) as subtotal
from Orders o inner join [Order Details] od
	on o.OrderID = od.OrderID
where o.ShippedDate between @FechaInicio and @FechaFin
group by o.ShippedDate, o.OrderID
order by o.ShippedDate

proc_ventas '1996.01.01','1997.01.01'

-- procedimiento 3

create procedure proc_actualiza_precios
(
	@idCategoria int,
	@idProveedor int,
	@nuevoValor money
)
as
begin try
	begin transaction
		update Products
		set UnitPrice = UnitPrice+@nuevoValor
		where CategoryID = @idCategoria
		and SupplierID = @idProveedor
		--confirmo el update
	commit transaction
	return 0
end try
begin catch
	rollback transaction
	return 1
end catch

--pasaje de parametros de procedimiento 3
select
	*
from Products
where CategoryID=1
and SupplierID = 1

-- el 1 deberia valer 20.54 y el 2 21.00 sin tener en cuenta el orden de los parámetros
execute proc_actualiza_precios
@nuevoValor = 2,
@idCategoria = 1,
@idProveedor = 1

-- pasaje de parámetros por posición
proc_actualiza_precios 1,1,2


-- procedimiento 4

create procedure proc_param_salida
	@n1 int,
	@n2 int,
	@operacion int, -- 1=suma 2=resta 3=multiplica
	@resultado int OUTPUT -- parametro de salida
as
if @operacion = 1
	begin
		select @resultado = @n1 + @n2
		return 0
	end
if @operacion = 2
	begin
		select @resultado = @n1 - @n2
		return 0
	end
set @resultado = @n1 * @n2

-- ejecuto el proc
declare @respuesta int
exec proc_param_salida 8,2,3, @respuesta output
select @respuesta as ResultadoOperacion

declare @respuesta2 int
exec proc_param_salida 8,2,3, @respuesta2 output
select 'Valor de la operacion:', @respuesta2
