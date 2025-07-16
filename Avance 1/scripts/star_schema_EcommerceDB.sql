-- =================================================================
-- Script para la Creación del Modelo Dimensional (Esquema en Estrella)
-- Proyecto Integrador M2 - Data Engineering
-- =================================================================
USE EcommerceDB;
GO

-- -----------------------------------------------------
-- Tabla: DimDate
-- Propósito: Contiene todos los atributos de fecha para el análisis.
-- Se poblará con un script para generar un rango de fechas.
-- -----------------------------------------------------
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    MonthName NVARCHAR(20) NOT NULL,
    Day INT NOT NULL,
    DayOfWeekName NVARCHAR(20) NOT NULL
);
GO

-- -----------------------------------------------------
-- Tabla: DimCustomer
-- Propósito: Almacena la información de los clientes.
-- Estrategia: SCD Tipo 1 (Sobrescribir).
-- -----------------------------------------------------
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    OriginalUserID INT NOT NULL,
    FullName NVARCHAR(201) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    DNI NVARCHAR(20) NOT NULL,
    RegistrationDate DATE
);
GO

-- -----------------------------------------------------
-- Tabla: DimProduct
-- Propósito: Almacena la información de los productos.
-- Estrategia: SCD Tipo 2 (Añadir Fila Nueva).
-- -----------------------------------------------------
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    OriginalProductID INT NOT NULL,
    ProductName NVARCHAR(255) NOT NULL,
    ProductDescription NVARCHAR(MAX),
    CategoryName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    IsCurrent BIT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE
);
GO

-- -----------------------------------------------------
-- Tabla: DimGeography
-- Propósito: Almacena la información geográfica limpia.
-- Estrategia: SCD Tipo 2 (Añadir Fila Nueva).
-- -----------------------------------------------------
CREATE TABLE DimGeography (
    GeographyKey INT IDENTITY(1,1) PRIMARY KEY,
    OriginalAddressID INT NOT NULL,
    FullAddress NVARCHAR(255) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Province NVARCHAR(100) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    IsCurrent BIT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE
);
GO

-- -----------------------------------------------------
-- Tabla: FactSales
-- Propósito: Tabla de hechos central que contiene las métricas de ventas.
-- Granularidad: Una fila por cada línea de producto en una orden.
-- -----------------------------------------------------
CREATE TABLE FactSales (
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    GeographyKey INT NOT NULL,
    OrderID INT,
    QuantitySold INT NOT NULL,
    PricePerUnit DECIMAL(10, 2) NOT NULL,
    TotalAmount DECIMAL(18, 2) NOT NULL,
    -- Definimos la Llave Primaria Compuesta
    CONSTRAINT PK_FactSales PRIMARY KEY (DateKey, CustomerKey, ProductKey, GeographyKey, OrderID),
    -- Definimos las Llaves Foráneas
    CONSTRAINT FK_FactSales_DimDate FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactSales_DimCustomer FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_FactSales_DimProduct FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    CONSTRAINT FK_FactSales_DimGeography FOREIGN KEY (GeographyKey) REFERENCES DimGeography(GeographyKey)
);
GO

PRINT 'Modelo dimensional creado exitosamente.';
GO
