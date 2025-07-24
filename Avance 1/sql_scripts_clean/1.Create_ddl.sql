-- Crear base de datos
CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    DNI NVARCHAR(20) UNIQUE NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Contraseña NVARCHAR(255) NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

-- Tabla: Categorías
CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255)
);
GO

-- Tabla: Productos
CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Descripcion NVARCHAR(MAX),
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    CategoriaID INT FOREIGN KEY REFERENCES Categorias(CategoriaID)
);
GO

-- Tabla: Órdenes
CREATE TABLE Ordenes (
    OrdenID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(UsuarioID),
    FechaOrden DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    Estado NVARCHAR(50) DEFAULT 'Pendiente'
);
GO

-- Tabla: Detalle de Órdenes
CREATE TABLE DetalleOrdenes (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    OrdenID INT FOREIGN KEY REFERENCES Ordenes(OrdenID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL
);
GO

-- Tabla: Direcciones de Envío
CREATE TABLE DireccionesEnvio (
    DireccionID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(UsuarioID),
    Calle NVARCHAR(255) NOT NULL,
    Ciudad NVARCHAR(100) NOT NULL,
    Departamento NVARCHAR(100),
    Provincia NVARCHAR(100),
    Distrito NVARCHAR(100),
    Estado NVARCHAR(100),
    CodigoPostal NVARCHAR(20),
    Pais NVARCHAR(100) NOT NULL
);
GO

-- Tabla: Carrito de Compras
CREATE TABLE Carrito (
    CarritoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(UsuarioID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    FechaAgregado DATETIME DEFAULT GETDATE()
);
GO

-- Tabla: Métodos de Pago
CREATE TABLE MetodosPago (
    MetodoPagoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255)
);
GO

-- Tabla: Ordenes Métodos de Pago
CREATE TABLE OrdenesMetodosPago (
    OrdenMetodoID INT IDENTITY(1,1) PRIMARY KEY,
    OrdenID INT FOREIGN KEY REFERENCES Ordenes(OrdenID),
    MetodoPagoID INT FOREIGN KEY REFERENCES MetodosPago(MetodoPagoID),
    MontoPagado DECIMAL(10,2) NOT NULL
);
GO

-- Tabla: Reseñas de Productos
CREATE TABLE ReseñasProductos (
    ReseñaID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(UsuarioID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    Calificacion INT CHECK (Calificacion >= 1 AND Calificacion <= 5),
    Comentario NVARCHAR(MAX),
    Fecha DATETIME DEFAULT GETDATE()
);
GO

-- Tabla: Historial de Pagos
CREATE TABLE HistorialPagos (
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    OrdenID INT FOREIGN KEY REFERENCES Ordenes(OrdenID),
    MetodoPagoID INT FOREIGN KEY REFERENCES MetodosPago(MetodoPagoID),
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME DEFAULT GETDATE(),
    EstadoPago NVARCHAR(50) DEFAULT 'Procesando'
);
GO
