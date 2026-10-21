
CREATE TABLE [Cliente] (
	[IdCliente] INT NOT NULL,
	[Nombre] NVARCHAR(100) NOT NULL,
	[Apellido] NVARCHAR(100),
	PRIMARY KEY([IdCliente])
);
GO

CREATE TABLE [Mesa] (
	[IdMesa] INT NOT NULL,
	[Numero] INT NOT NULL,
	[Activa] BIT NOT NULL,
	PRIMARY KEY([IdMesa])
);
GO

CREATE TABLE [Producto] (
	[IdProducto] INT NOT NULL,
	[Nombre] NVARCHAR(100) NOT NULL,
	[Descripcion] NVARCHAR(250),
	[Precio] DECIMAL NOT NULL,
	[Activo] BIT NOT NULL,
	PRIMARY KEY([IdProducto])
);
GO

CREATE TABLE [MetodoPago] (
	[IdMetodoPago] INT NOT NULL,
	[Nombre] NVARCHAR(50) NOT NULL,
	PRIMARY KEY([IdMetodoPago])
);
GO

CREATE TABLE [Pedido] (
	[IdPedido] INT NOT NULL,
	[IdMesa] INT NOT NULL,
	[IdCliente] INT NOT NULL,
	[FechaHora] DATETIME NOT NULL,
	[Estado] NVARCHAR(20) NOT NULL,
	PRIMARY KEY([IdPedido])
);
GO

CREATE TABLE [DetallePedido] (
	[IdPedido] INT NOT NULL,
	[IdProducto] INT NOT NULL,
	[Cantidad] INT NOT NULL,
	[PrecioUnitario] DECIMAL NOT NULL,
	PRIMARY KEY([IdPedido], [IdProducto])
);
GO

CREATE TABLE [Pago] (
	[IdPago] INT NOT NULL,
	[IdPedido] INT NOT NULL,
	[IdMetodoPago] INT NOT NULL,
	[FechaHora] DATETIME NOT NULL,
	[Importe] DECIMAL NOT NULL,
	PRIMARY KEY([IdPago])
);
GO

CREATE TABLE [CategoriaEmpleado] (
	[IdCategoria] INT NOT NULL,
	[Nombre] NVARCHAR(100) NOT NULL,
	[SueldoBase] DECIMAL NOT NULL,
	PRIMARY KEY([IdCategoria])
);
GO

CREATE TABLE [Empleado] (
	[IdEmpleado] INT NOT NULL,
	[IdCategoria] INT NOT NULL,
	[Nombre] NVARCHAR(100) NOT NULL,
	[Apellido] NVARCHAR(100) NOT NULL,
	[FechaIngreso] DATE NOT NULL,
	[Activo] BIT NOT NULL,
	PRIMARY KEY([IdEmpleado])
);
GO

CREATE TABLE [Asistencia] (
	[IdEmpleado] INT NOT NULL,
	[Fecha] DATE NOT NULL,
	[Presente] BIT NOT NULL,
	PRIMARY KEY([IdEmpleado], [Fecha])
);
GO

CREATE TABLE [PagoEmpleado] (
	[IdPagoEmpleado] INT NOT NULL,
	[IdEmpleado] INT NOT NULL,
	[Fecha] DATE NOT NULL,
	[Importe] DECIMAL NOT NULL,
	[Bono] DECIMAL NOT NULL,
	PRIMARY KEY([IdPagoEmpleado])
);
GO

ALTER TABLE [Pedido]
ADD FOREIGN KEY([IdCliente]) REFERENCES [Cliente]([IdCliente])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [Pedido]
ADD FOREIGN KEY([IdMesa]) REFERENCES [Mesa]([IdMesa])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [DetallePedido]
ADD FOREIGN KEY([IdProducto]) REFERENCES [Producto]([IdProducto])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [Pago]
ADD FOREIGN KEY([IdMetodoPago]) REFERENCES [MetodoPago]([IdMetodoPago])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [DetallePedido]
ADD FOREIGN KEY([IdPedido]) REFERENCES [Pedido]([IdPedido])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [Pago]
ADD FOREIGN KEY([IdPedido]) REFERENCES [Pedido]([IdPedido])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [Empleado]
ADD FOREIGN KEY([IdCategoria]) REFERENCES [CategoriaEmpleado]([IdCategoria])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [Asistencia]
ADD FOREIGN KEY([IdEmpleado]) REFERENCES [Empleado]([IdEmpleado])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [PagoEmpleado]
ADD FOREIGN KEY([IdEmpleado]) REFERENCES [Empleado]([IdEmpleado])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
