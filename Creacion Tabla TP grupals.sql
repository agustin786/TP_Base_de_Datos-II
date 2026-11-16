-- =========================================================
-- CREACION BASE DE DATOS LA_POPULAR Y TABLAS + RELACIONES
-- =========================================================

CREATE DATABASE La_Popular;
GO
USE La_Popular;
GO
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100),

    CONSTRAINT PK_Cliente
        PRIMARY KEY (IdCliente)
);
GO
CREATE TABLE Mesa (
    IdMesa INT IDENTITY(1,1) NOT NULL,
    Numero INT NOT NULL,
    Activa BIT NOT NULL,

    CONSTRAINT PK_Mesa
        PRIMARY KEY (IdMesa)
);
GO
CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(250),
    Precio DECIMAL(10,2) NOT NULL,
    Activo BIT NOT NULL,

    CONSTRAINT PK_Producto
        PRIMARY KEY (IdProducto)
);
GO
CREATE TABLE MetodoPago (
    IdMetodoPago INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_MetodoPago
        PRIMARY KEY (IdMetodoPago)
);
GO
CREATE TABLE TipoPedido (
    IdTipoPedido INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(30) NOT NULL,

    CONSTRAINT PK_TipoPedido
        PRIMARY KEY (IdTipoPedido),

    CONSTRAINT UQ_TipoPedido_Nombre
        UNIQUE (Nombre)
);
GO
CREATE TABLE CategoriaEmpleado (
    IdCategoria INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    SueldoBase DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_CategoriaEmpleado
        PRIMARY KEY (IdCategoria)
);
GO
CREATE TABLE Pedido (
    IdPedido INT IDENTITY(1,1) NOT NULL,
    IdCliente INT NOT NULL,
    FechaHora DATETIME NOT NULL,
    Estado NVARCHAR(20) NOT NULL,
    EstadoPreparacion VARCHAR(20) NOT NULL
        CONSTRAINT DF_Pedido_EstadoPreparacion
        DEFAULT 'Pendiente',
    IdTipoPedido INT NOT NULL
        CONSTRAINT DF_Pedido_IdTipoPedido
        DEFAULT 1,

    CONSTRAINT PK_Pedido
        PRIMARY KEY (IdPedido),

    CONSTRAINT FK_Pedido_Cliente
        FOREIGN KEY (IdCliente)
        REFERENCES Cliente(IdCliente),

    CONSTRAINT FK_Pedido_TipoPedido
        FOREIGN KEY (IdTipoPedido)
        REFERENCES TipoPedido(IdTipoPedido)
);
GO
CREATE TABLE Pedido_Mesa (
    IdPedido INT NOT NULL,
    IdMesa INT NOT NULL,

    CONSTRAINT PK_Pedido_Mesa
        PRIMARY KEY (IdPedido, IdMesa),

    CONSTRAINT FK_PedidoMesa_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido),

    CONSTRAINT FK_PedidoMesa_Mesa
        FOREIGN KEY (IdMesa)
        REFERENCES Mesa(IdMesa)
);
GO
CREATE TABLE DetallePedido (
    IdPedido INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_DetallePedido
        PRIMARY KEY (IdPedido, IdProducto),

    CONSTRAINT FK_DetallePedido_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido),

    CONSTRAINT FK_DetallePedido_Producto
        FOREIGN KEY (IdProducto)
        REFERENCES Producto(IdProducto)
);
GO
CREATE TABLE Pago (
    IdPago INT IDENTITY(1,1) NOT NULL,
    IdPedido INT NOT NULL,
    IdMetodoPago INT NOT NULL,
    FechaHora DATETIME NOT NULL,
    Importe DECIMAL(10,2) NOT NULL,
    Propina DECIMAL(10,2) NOT NULL
        CONSTRAINT DF_Pago_Propina DEFAULT 0,

    CONSTRAINT PK_Pago
        PRIMARY KEY (IdPago),

    CONSTRAINT FK_Pago_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido),

    CONSTRAINT FK_Pago_MetodoPago
        FOREIGN KEY (IdMetodoPago)
        REFERENCES MetodoPago(IdMetodoPago),

    CONSTRAINT CK_Pago_Propina
        CHECK (Propina >= 0)
);
GO
CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) NOT NULL,
    IdCategoria INT NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    FechaIngreso DATE NOT NULL,
    Activo BIT NOT NULL,

    CONSTRAINT PK_Empleado
        PRIMARY KEY (IdEmpleado),

    CONSTRAINT FK_Empleado_Categoria
        FOREIGN KEY (IdCategoria)
        REFERENCES CategoriaEmpleado(IdCategoria)
);
GO
CREATE TABLE Asistencia (
    IdEmpleado INT NOT NULL,
    Fecha DATE NOT NULL,
    Presente BIT NOT NULL,

    CONSTRAINT PK_Asistencia
        PRIMARY KEY (IdEmpleado, Fecha),

    CONSTRAINT FK_Asistencia_Empleado
        FOREIGN KEY (IdEmpleado)
        REFERENCES Empleado(IdEmpleado)
);
GO
CREATE TABLE PagoEmpleado (
    IdPagoEmpleado INT IDENTITY(1,1) NOT NULL,
    IdEmpleado INT NOT NULL,
    Fecha DATE NOT NULL,
    Importe DECIMAL(10,2) NOT NULL,
    Bono DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_PagoEmpleado
        PRIMARY KEY (IdPagoEmpleado),

    CONSTRAINT FK_PagoEmpleado_Empleado
        FOREIGN KEY (IdEmpleado)
        REFERENCES Empleado(IdEmpleado)
);
GO
-- =========================================================
-- DATOS 
-- =========================================================
INSERT INTO Cliente (Nombre, Apellido)
VALUES
('Juan', 'Perez'),
('Maria', 'Gomez'),
('Lucas', 'Fernandez'),
('Sofia', 'Martinez'),
('Pedro', 'Rodriguez'),
('Lucia', 'Lopez'),
('Mateo', 'Garcia'),
('Valentina', 'Torres'),
('Tomas', 'Ramirez'),
('Camila', 'Diaz'),
('Nicolas', 'Castro'),
('Martina', 'Romero'),
('Federico', 'Alvarez'),
('Agustina', 'Morales'),
('Joaquin', 'Herrera'),
('Florencia', 'Medina'),
('Franco', 'Vega'),
('Milagros', 'Suarez'),
('Bruno', 'Acosta'),
('Julieta', 'Molina');
GO
INSERT INTO Mesa (Numero, Activa)
VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0),
(12, 0),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1);
GO
INSERT INTO Producto (Nombre, Descripcion, Precio, Activo)
VALUES
('Pizza Muzzarella', 'Pizza con muzzarella', 12000, 1),
('Pizza Napolitana', 'Pizza con tomate y ajo', 14000, 1),
('Pizza Especial', 'Pizza con jamon y morrones', 16000, 1),
('Pizza Fugazzeta', 'Pizza con cebolla y queso', 15000, 1),
('Pizza Calabresa', 'Pizza con longaniza', 17000, 1),
('Pizza Cuatro Quesos', 'Pizza con cuatro quesos', 18000, 1),
('Pizza Margarita', 'Pizza con tomate y albahaca', 13500, 1),
('Pizza de Jamon', 'Pizza con jamon', 14500, 1),
('Pizza de Rucula', 'Pizza con rucula y parmesano', 17500, 1),
('Pizza Provolone', 'Pizza con queso provolone', 16500, 1),
('Empanada de Carne', 'Empanada de carne', 2500, 1),
('Empanada de Pollo', 'Empanada de pollo', 2500, 1),
('Empanada de Jamon y Queso', 'Empanada de jamon y queso', 2500, 1),
('Empanada Caprese', 'Empanada de tomate y queso', 2700, 1),
('Faina', 'Porcion de faina', 2000, 1),
('Papas Fritas', 'Porcion de papas fritas', 6500, 1),
('Gaseosa Cola', 'Botella de 500 ml', 3000, 1),
('Agua Mineral', 'Botella de 500 ml', 2000, 1),
('Limonada', 'Vaso de limonada', 3500, 1),
('Pizza Hawaiana', 'Pizza con anana y jamon', 17000, 0);
GO
INSERT INTO TipoPedido (Nombre)
VALUES
('Salon'),
('Delivery'),
('Para llevar');

INSERT INTO MetodoPago (Nombre)
VALUES
('Efectivo'),
('Tarjeta'),
('Transferencia');
GO
INSERT INTO Pedido
(IdCliente, FechaHora, Estado, EstadoPreparacion, IdTipoPedido)
VALUES
(1, '2026-11-10T12:00:00', 'Cerrado', 'Entregado', 1),
(2, '2026-11-10T12:30:00', 'Cerrado', 'Entregado', 1),
(3, '2026-11-10T13:00:00', 'Cerrado', 'Entregado', 1),
(4, '2026-11-10T13:30:00', 'Cerrado', 'Entregado', 1),
(5, '2026-11-11T12:00:00', 'Cerrado', 'Entregado', 1),
(6, '2026-11-11T12:30:00', 'Cerrado', 'Entregado', 1),
(7, '2026-11-11T13:00:00', 'Cerrado', 'Entregado', 1),
(8, '2026-11-11T13:30:00', 'Cerrado', 'Entregado', 1),
(9, '2026-11-12T20:00:00', 'Cerrado', 'Entregado', 1),
(10, '2026-11-12T20:30:00', 'Cerrado', 'Entregado', 1),
(11, '2026-11-13T21:00:00', 'Cerrado', 'Entregado', 1),
(12, '2026-11-13T21:30:00', 'Cerrado', 'Entregado', 1),
(13, '2026-11-15T19:00:00', 'Abierto', 'Pendiente', 1),
(14, '2026-11-15T19:05:00', 'Abierto', 'Pendiente', 1),
(15, '2026-11-15T19:10:00', 'Abierto', 'EnCocina', 1),
(16, '2026-11-15T19:15:00', 'Abierto', 'EnCocina', 1),
(17, '2026-11-15T19:20:00', 'Abierto', 'EnCocina', 1),
(18, '2026-11-15T19:25:00', 'Abierto', 'Listo', 1),
(19, '2026-11-15T19:30:00', 'Abierto', 'Listo', 1),
(20, '2026-11-15T19:35:00', 'Abierto', 'Pendiente', 1);
GO
INSERT INTO Pedido_Mesa (IdPedido, IdMesa)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);
GO
INSERT INTO DetallePedido
(IdPedido, IdProducto, Cantidad, PrecioUnitario)
VALUES
(1, 1, 2, 12000),
(2, 2, 1, 14000),
(3, 3, 1, 16000),
(4, 4, 2, 15000),
(5, 5, 1, 17000),
(6, 6, 2, 18000),
(7, 7, 1, 13500),
(8, 8, 2, 14500),
(9, 9, 1, 17500),
(10, 10, 1, 16500),
(11, 11, 6, 2500),
(12, 12, 6, 2500),
(13, 1, 1, 12000),
(14, 2, 2, 14000),
(15, 3, 1, 16000),
(16, 4, 1, 15000),
(17, 5, 2, 17000),
(18, 6, 1, 18000),
(19, 7, 1, 13500),
(20, 8, 2, 14500);
GO
INSERT INTO Pago
(IdPedido, IdMetodoPago, FechaHora, Importe, Propina)
VALUES
(1, 1, '2026-11-10T12:45:00', 24000, 1000),
(2, 2, '2026-11-10T13:10:00', 14000, 0),
(3, 3, '2026-11-10T13:45:00', 16000, 500),
(4, 1, '2026-11-10T14:15:00', 30000, 2000),
(5, 2, '2026-11-11T12:50:00', 17000, 0),
(6, 3, '2026-11-11T13:20:00', 36000, 3000),
(7, 1, '2026-11-11T13:50:00', 13500, 500),
(8, 2, '2026-11-11T14:15:00', 29000, 0),
(9, 3, '2026-11-12T20:40:00', 17500, 1000),
(10, 1, '2026-11-12T21:10:00', 16500, 500),
(11, 2, '2026-11-13T21:40:00', 15000, 0),
(12, 3, '2026-11-13T22:15:00', 15000, 1000);
GO
INSERT INTO CategoriaEmpleado (Nombre, SueldoBase)
VALUES
('Mozo', 650000),
('Cocinero', 850000),
('Cajero', 700000),
('Encargado', 1100000),
('Repartidor', 600000),
('Ayudante de cocina', 620000);
GO
INSERT INTO Empleado
(IdCategoria, Nombre, Apellido, FechaIngreso, Activo)
VALUES
(1, 'Carlos', 'Lopez', '2025-03-10', 1),
(1, 'Martin', 'Gomez', '2025-05-15', 1),
(1, 'Lucia', 'Fernandez', '2025-07-20', 1),
(1, 'Sofia', 'Ramirez', '2025-08-12', 1),
(2, 'Pedro', 'Martinez', '2024-01-10', 1),
(2, 'Diego', 'Rodriguez', '2024-04-18', 1),
(2, 'Nicolas', 'Torres', '2025-02-20', 1),
(3, 'Ana', 'Garcia', '2024-06-15', 1),
(3, 'Florencia', 'Diaz', '2025-03-22', 1),
(3, 'Camila', 'Morales', '2025-09-10', 1),
(4, 'Roberto', 'Perez', '2023-11-05', 1),
(4, 'Mariana', 'Castro', '2024-02-12', 1),
(5, 'Joaquin', 'Herrera', '2025-01-15', 1),
(5, 'Franco', 'Vega', '2025-04-20', 1),
(5, 'Bruno', 'Acosta', '2025-06-18', 1),
(6, 'Valentina', 'Romero', '2025-05-10', 1),
(6, 'Julieta', 'Molina', '2025-08-15', 1),
(6, 'Mateo', 'Alvarez', '2025-09-20', 1),
(1, 'Agustina', 'Medina', '2025-10-01', 0),
(2, 'Federico', 'Suarez', '2025-11-10', 0);
INSERT INTO Asistencia
(IdEmpleado, Fecha, Presente)
VALUES
(1, '2026-11-14', 1),
(2, '2026-11-14', 1),
(3, '2026-11-14', 1),
(4, '2026-11-14', 0),
(5, '2026-11-14', 1),
(6, '2026-11-14', 1),
(7, '2026-11-14', 1),
(8, '2026-11-14', 1),
(9, '2026-11-14', 0),
(10, '2026-11-14', 1),
(11, '2026-11-14', 1),
(12, '2026-11-14', 1),
(13, '2026-11-14', 1),
(14, '2026-11-14', 0),
(15, '2026-11-14', 1),
(16, '2026-11-14', 1),
(17, '2026-11-14', 1),
(18, '2026-11-14', 1),
(19, '2026-11-14', 0),
(20, '2026-11-14', 0);
GO
-- =========================================================
-- VISTAS
-- =========================================================
-- Vista 1 :Simulacion Mesas
CREATE VIEW VW_SimulacionMesas AS
SELECT
    M.IdMesa,
    M.Numero,
    COALESCE(SUM(DP.Cantidad), 0) AS Cantidad,
    M.Activa,
    CASE
        WHEN M.Activa = 1 THEN 'Ocupada'
        WHEN M.Activa = 0 THEN 'Libre'
        ELSE 'Sin estado'
    END AS EstadoMesa,

    COALESCE(
        SUM(DP.PrecioUnitario * DP.Cantidad), 0
    ) AS TotalConsumido

FROM Mesa M
LEFT JOIN Pedido_Mesa PM
    ON M.IdMesa = PM.IdMesa

LEFT JOIN Pedido P
    ON PM.IdPedido = P.IdPedido
    AND P.Estado = 'Abierto'

LEFT JOIN DetallePedido DP
    ON P.IdPedido = DP.IdPedido

GROUP BY
    M.IdMesa,
    M.Numero,
    M.Activa;
GO
-- Vista 2 : Menu Del Local
CREATE VIEW vw_MenuActivo AS
SELECT 
    IdProducto,
    Nombre,
    Precio
FROM Producto
WHERE Activo = 1;
GO
--- Vista 3: MostrarPedidos
CREATE VIEW VW_PedidosEnProceso
AS
SELECT
    P.IdPedido,
    P.IdCliente,
    P.FechaHora,
    P.Estado,
    P.EstadoPreparacion
FROM Pedido AS P
WHERE P.Estado = 'Abierto'
  AND P.EstadoPreparacion IN ('Pendiente', 'EnCocina', 'Listo');
GO
CREATE VIEW VW_EmpleadosGeneral
AS
SELECT
    E.IdEmpleado,
    E.Nombre,
    E.Apellido,
    E.FechaIngreso,
    CE.IdCategoria,
    CE.Nombre AS Categoria,
    CE.SueldoBase,
    E.Activo,
    CASE
        WHEN E.Activo = 1 THEN 'Activo'
        WHEN E.Activo = 0 THEN 'Inactivo'
        ELSE 'Sin estado'
    END AS EstadoEmpleado
FROM Empleado E
INNER JOIN CategoriaEmpleado CE
    ON E.IdCategoria = CE.IdCategoria;
GO
-- =========================================================
-- PROCEDIMIENTOS ALMACENADOS
-- =========================================================
-- PROCEDIMIENTO ALMACENADO 1: Ventas por rango de fechas
CREATE PROCEDURE sp_ReporteVentasPorFecha
    @FechaInicio DATETIME,
    @FechaFin DATETIME
AS
BEGIN
    SELECT 
        mp.Nombre AS MetodoDePago,
        COUNT(p.IdPago) AS CantidadOperaciones,
        SUM(p.Importe) AS TotalRecaudado
    FROM Pago p
    INNER JOIN MetodoPago mp ON p.IdMetodoPago = mp.IdMetodoPago
    WHERE p.FechaHora >= @FechaInicio
      AND p.FechaHora < DATEADD(DAY, 1, @FechaFin)
    GROUP BY mp.Nombre;
END;
GO
-- PROCEDIMIENTO ALMACENADO 2: Agrega un producto a un pedido
CREATE PROCEDURE sp_AgregarProductoAPedido
    @IdPedido INT,
    @IdProducto INT,
    @Cantidad INT
AS
BEGIN
    IF @Cantidad <= 0 OR @Cantidad IS NULL
    BEGIN
        RAISERROR(
            'La cantidad debe ser mayor a cero.',
            16,
            1
        );
        RETURN;
    END

    DECLARE @Precio DECIMAL(10,2);

    SELECT @Precio = Precio
    FROM Producto
    WHERE IdProducto = @IdProducto AND Activo = 1;

    IF @Precio IS NULL
    BEGIN
        RAISERROR('El producto no existe o está inactivo.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM DetallePedido
        WHERE IdPedido = @IdPedido
          AND IdProducto = @IdProducto
    )
    BEGIN
        UPDATE DetallePedido
        SET Cantidad = Cantidad + @Cantidad
        WHERE IdPedido = @IdPedido
          AND IdProducto = @IdProducto;
    END
    ELSE
    BEGIN
        INSERT INTO DetallePedido
        (IdPedido, IdProducto, Cantidad, PrecioUnitario)
        VALUES
        (@IdPedido, @IdProducto, @Cantidad, @Precio);
    END
END;
GO
-- PROCEDIMIENTO ALMACENADO 3: CrearPedidoMesa
CREATE PROCEDURE sp_CrearPedidoMesa
    @IdCliente INT,
    @IdMesa INT,
    @IdTipoPedido INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (
            SELECT 1
            FROM Pedido_Mesa pm
            INNER JOIN Pedido p
                ON pm.IdPedido = p.IdPedido
            WHERE pm.IdMesa = @IdMesa
              AND p.Estado = 'Abierto'
        )
        BEGIN
            THROW 50001, 'La mesa ya tiene un pedido abierto.', 1;
        END;

        IF NOT EXISTS (
            SELECT 1
            FROM Mesa
            WHERE IdMesa = @IdMesa
              AND Activa = 0
        )
        BEGIN
            THROW 50002, 'La mesa no existe o esta ocupada.', 1;
        END;

        INSERT INTO Pedido
        (
            IdCliente,
            FechaHora,
            Estado,
            EstadoPreparacion,
            IdTipoPedido
        )
        VALUES
        (
            @IdCliente,
            GETDATE(),
            'Abierto',
            'Pendiente',
            @IdTipoPedido
        );

        DECLARE @IdPedido INT;
        SET @IdPedido = SCOPE_IDENTITY();

        INSERT INTO Pedido_Mesa (IdPedido, IdMesa)
        VALUES (@IdPedido, @IdMesa);

        UPDATE Mesa
        SET Activa = 1
        WHERE IdMesa = @IdMesa;

        COMMIT TRANSACTION;

        SELECT @IdPedido AS IdPedido;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 4: Agregar una Mesa a un Pedido
CREATE PROCEDURE sp_AgregarMesaAPedido
    @IdPedido INT,
    @IdMesa INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (
            SELECT 1
            FROM Pedido
            WHERE IdPedido = @IdPedido
              AND Estado = 'Abierto'
        )
        BEGIN
            THROW 50002, 'El pedido no existe o no esta abierto.', 1;
        END;

        IF EXISTS (
            SELECT 1
            FROM Pedido_Mesa
            WHERE IdPedido = @IdPedido
              AND IdMesa = @IdMesa
        )
        BEGIN
            THROW 50003, 'La mesa ya pertenece a este pedido.', 1;
        END;

        IF EXISTS (
            SELECT 1
            FROM Pedido_Mesa pm
            INNER JOIN Pedido p
                ON pm.IdPedido = p.IdPedido
            WHERE pm.IdMesa = @IdMesa
              AND p.Estado = 'Abierto'
        )
        BEGIN
            THROW 50004, 'La mesa ya tiene otro pedido abierto.', 1;
        END;

        IF NOT EXISTS (
            SELECT 1
            FROM Mesa
            WHERE IdMesa = @IdMesa
              AND Activa = 0
        )
        BEGIN
            THROW 50005, 'La mesa no existe o esta ocupada.', 1;
        END;

        INSERT INTO Pedido_Mesa (IdPedido, IdMesa)
        VALUES (@IdPedido, @IdMesa);

        UPDATE Mesa
        SET Activa = 1
        WHERE IdMesa = @IdMesa;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 5: Liberar Mesas y Cerra Pedidos
CREATE PROCEDURE sp_PagarYCerrarPedido
    @IdPedido INT,
    @IdMetodoPago INT,
    @Importe DECIMAL(10,2),
    @Propina DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @TotalPedido DECIMAL(10,2);

        IF NOT EXISTS (
            SELECT 1
            FROM Pedido
            WHERE IdPedido = @IdPedido
              AND Estado = 'Abierto'
        )
        BEGIN
            THROW 50001, 'El pedido no existe o ya esta cerrado.', 1;
        END;

        SELECT @TotalPedido = ISNULL(
            SUM(Cantidad * PrecioUnitario), 0
        )
        FROM DetallePedido
        WHERE IdPedido = @IdPedido;

        IF @Importe <> @TotalPedido
        BEGIN
            THROW 50002, 'El importe ingresado no coincide con el total del pedido.', 1;
        END;

        INSERT INTO Pago
        (
            IdPedido,
            IdMetodoPago,
            FechaHora,
            Importe,
            Propina
        )
        VALUES
        (
            @IdPedido,
            @IdMetodoPago,
            GETDATE(),
            @Importe,
            @Propina
        );

        UPDATE Mesa
        SET Activa = 0
        WHERE IdMesa IN (
            SELECT IdMesa
            FROM Pedido_Mesa
            WHERE IdPedido = @IdPedido
        );

        UPDATE Pedido
        SET Estado = 'Cerrado'
        WHERE IdPedido = @IdPedido;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 6: Crear Usuario
CREATE PROCEDURE sp_CrearCliente
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Cliente (Nombre, Apellido)
        VALUES (@Nombre, @Apellido);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 7: CrearEmpleado
Create PROCEDURE sp_CrearEmpleado
    @IdCategoria INT,
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaIngreso DATE
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (
            SELECT 1
            FROM CategoriaEmpleado
            WHERE IdCategoria = @IdCategoria
        )
        BEGIN
            THROW 50020, 'La categoría de empleado especificada no existe.', 1;
        END;

        IF EXISTS (
            SELECT 1
            FROM Empleado
            WHERE Nombre = @Nombre
              AND Apellido = @Apellido
              AND FechaIngreso = @FechaIngreso
        )
        BEGIN
            THROW 50021, 'El empleado ya se encuentra registrado.', 1;
        END;

        INSERT INTO Empleado
            (IdCategoria, Nombre, Apellido, FechaIngreso, Activo)
        VALUES
            (@IdCategoria, @Nombre, @Apellido, @FechaIngreso, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 8: Crear Producto
CREATE PROCEDURE sp_CrearProducto
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(250),
    @Precio DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @Precio < 0
        BEGIN
            THROW 50021, 'El precio del producto no puede ser negativo.', 1;
        END;

        INSERT INTO Producto (Nombre, Descripcion, Precio, Activo)
        VALUES (@Nombre, @Descripcion, @Precio, 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 9: Modificar Precio de un Producto
CREATE PROCEDURE sp_ModificarPrecioProducto
    @IdProducto INT,
    @NuevoPrecio DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Producto WHERE IdProducto = @IdProducto)
        BEGIN
            THROW 50022, 'El producto especificado no existe.', 1;
        END;

        IF @NuevoPrecio < 0
        BEGIN
            THROW 50023, 'El precio no puede ser negativo.', 1;
        END;

        UPDATE Producto
        SET Precio = @NuevoPrecio
        WHERE IdProducto = @IdProducto;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 10: Alta y Baja de Producto (Cambiar Estado Activo / Inactivo)
CREATE PROCEDURE sp_CambiarEstadoProducto
    @IdProducto INT,
    @Activo BIT -- 1 para Alta (Activo), 0 para Baja (Inactivo)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Producto WHERE IdProducto = @IdProducto)
        BEGIN
            THROW 50024, 'El producto especificado no existe.', 1;
        END;

        UPDATE Producto
        SET Activo = @Activo
        WHERE IdProducto = @IdProducto;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 11: Modificar Datos Empleados
CREATE PROCEDURE sp_ModificarEmpleado
    @IdEmpleado INT,
    @IdCategoria INT,
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaIngreso DATE
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Validar que el empleado exista
        IF NOT EXISTS (
            SELECT 1
            FROM Empleado
            WHERE IdEmpleado = @IdEmpleado
        )
        BEGIN
            ;THROW 50023, 'El empleado especificado no existe.', 1;
        END

        -- 2. Validar que la nueva categoría exista
        IF NOT EXISTS (
            SELECT 1
            FROM CategoriaEmpleado
            WHERE IdCategoria = @IdCategoria
        )
        BEGIN
            ;THROW 50024, 'La categoría de empleado especificada no existe.', 1;
        END

        -- 3. Validar que nombre y apellido no queden vacíos
        IF LTRIM(RTRIM(ISNULL(@Nombre, ''))) = '' OR LTRIM(RTRIM(ISNULL(@Apellido, ''))) = ''
        BEGIN
            ;THROW 50025, 'El nombre y el apellido del empleado no pueden estar vacíos.', 1;
        END

        -- 4. Evitar duplicar datos con OTRO empleado existente
        IF EXISTS (
            SELECT 1
            FROM Empleado
            WHERE Nombre = @Nombre
              AND Apellido = @Apellido
              AND FechaIngreso = @FechaIngreso
              AND IdEmpleado <> @IdEmpleado
        )
        BEGIN
            ;THROW 50026, 'Ya existe otro empleado con el mismo nombre, apellido y fecha de ingreso.', 1;
        END

        -- 5. Actualizar los datos del empleado
        UPDATE Empleado
        SET IdCategoria = @IdCategoria,
            Nombre = @Nombre,
            Apellido = @Apellido,
            FechaIngreso = @FechaIngreso
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        ;THROW;
    END CATCH
END;
GO
-- PROCEDIMIENTO ALMACENADO 12: Cambiar de estado aun Empleado
CREATE PROCEDURE sp_CambiarEstadoEmpleado
    @IdEmpleado INT,
    @Activo BIT -- 1 para Activar (Alta lógica), 0 para Desactivar (Baja lógica)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Validar que el empleado exista
        IF NOT EXISTS (
            SELECT 1
            FROM Empleado
            WHERE IdEmpleado = @IdEmpleado
        )
        BEGIN
            ;THROW 50027, 'El empleado especificado no existe.', 1;
        END

        -- 2. Actualizar el estado
        UPDATE Empleado
        SET Activo = @Activo
        WHERE IdEmpleado = @IdEmpleado;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        ;THROW;
    END CATCH
END;
GO
-- =========================================================
-- TRIGGERS
-- =========================================================
-- Trigger 1(INSERT): Validar que no se abra un pedido en una mesa ya ocupada
CREATE TRIGGER trg_ValidarMesaOcupada
ON Pedido_Mesa
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        INNER JOIN Pedido pNuevo
            ON i.IdPedido = pNuevo.IdPedido
        INNER JOIN Pedido_Mesa pm
            ON i.IdMesa = pm.IdMesa
        INNER JOIN Pedido pExistente
            ON pm.IdPedido = pExistente.IdPedido
        WHERE pNuevo.Estado = 'Abierto'
          AND pExistente.Estado = 'Abierto'
          AND pExistente.IdPedido <> i.IdPedido
    )
    BEGIN
        RAISERROR(
            'Una o mas mesas ya tienen otro pedido abierto.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO
----Trigger 2: Validar Cambios de Estado
CREATE TRIGGER trg_ValidarCambioEstadoPedido
ON Pedido
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(Estado)
    BEGIN
        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            INNER JOIN Pedido_Mesa pmNuevo
                ON i.IdPedido = pmNuevo.IdPedido
            INNER JOIN Pedido_Mesa pmExistente
                ON pmNuevo.IdMesa = pmExistente.IdMesa
            INNER JOIN Pedido pExistente
                ON pmExistente.IdPedido = pExistente.IdPedido
            WHERE i.Estado = 'Abierto'
              AND pExistente.Estado = 'Abierto'
              AND pExistente.IdPedido <> i.IdPedido
        )
        BEGIN
            RAISERROR(
                'No se puede abrir el pedido porque una mesa ya tiene otro pedido abierto.',
                16,
                1
            );

            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
END;
GO
-- Trigger 3: Validar Cambios de Estado
CREATE TRIGGER trg_ImpedirBorrarEmpleadoActivo
ON Empleado
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificamos en la tabla virtual 'deleted' si alguno de los empleados
    -- que se intentó eliminar tiene el estado Activo = 1
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE d.Activo = 1
    )
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        ;THROW 50035, 'No se puede eliminar físicamente a un empleado que se encuentra activo. Primero debe darle de baja lógica.', 1;
    END
END;
GO
-- =========================================================
-- FUNCIONES
-- =========================================================
CREATE FUNCTION fn_ReporteVentasMensuales
(
    @Anio INT
)
RETURNS TABLE
AS
RETURN
(
    WITH VentasMensuales AS
    (
        SELECT
            MONTH(FechaHora) AS Mes,
            COUNT(IdPago) AS CantidadVentas,
            SUM(Importe) AS TotalVentas
        FROM Pago
        WHERE YEAR(FechaHora) = @Anio
        GROUP BY MONTH(FechaHora)
    ),
    Resumen AS
    (
        SELECT
            Mes,
            CantidadVentas,
            TotalVentas,
            LAG(TotalVentas) OVER (
                ORDER BY Mes
            ) AS VentasMesAnterior
        FROM VentasMensuales
    )
    SELECT
        Mes,
        CantidadVentas,
        TotalVentas,
        CAST(
            (TotalVentas - VentasMesAnterior)
            * 100.0 /
            NULLIF(VentasMesAnterior, 0)
            AS DECIMAL(10,2)
        ) AS PorcentajeCrecimiento
    FROM Resumen
);
GO