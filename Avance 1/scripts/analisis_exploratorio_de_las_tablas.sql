SELECT TOP (1000) [UsuarioID]
      ,[Nombre]
      ,[Apellido]
      ,[DNI]
      ,[Email]
      ,[Contraseña]
      ,[FechaRegistro]
  FROM [EcommerceDB].[dbo].[Usuarios]

  SELECT DISTINCT Estado FROM Ordenes;

  SELECT DISTINCT Ciudad, Provincia, Pais FROM DireccionesEnvio ORDER BY Pais, Provincia, Ciudad;

  SELECT *
FROM ReseñasProductos
WHERE Calificacion < 1 OR Calificacion > 5;
-- Si no devuelve filas, la integridad de las calificaciones es buena.

SELECT
    COUNT(*) AS TotalReseñas,
    SUM(CASE WHEN Comentario IS NULL OR LTRIM(RTRIM(Comentario)) = '' THEN 1 ELSE 0 END) AS ReseñasSinComentario
FROM ReseñasProductos;

WITH PagosPorOrden AS (
    SELECT
        OrdenID,
        SUM(Monto) AS TotalPagado
    FROM HistorialPagos
    GROUP BY OrdenID
)
SELECT
    o.OrdenID,
    o.Total AS TotalDeclaradoEnOrden,
    p.TotalPagado
FROM Ordenes o
JOIN PagosPorOrden p ON o.OrdenID = p.OrdenID
WHERE o.Total <> p.TotalPagado;
-- Filas devueltas aquí indican discrepancias en los pagos.

SELECT
    EstadoPago,
    COUNT(*) AS Cantidad
FROM HistorialPagos
GROUP BY EstadoPago;

SELECT *
FROM Productos
WHERE Precio < 0 OR Stock < 0;
-- No debería devolver ninguna fila.

-- Top 5 productos más caros
SELECT TOP 5 Nombre, Precio
FROM Productos
ORDER BY Precio DESC;

-- Top 5 productos con más stock
SELECT TOP 5 Nombre, Stock
FROM Productos
ORDER BY Stock DESC;

-- Buscar DNI duplicados
SELECT DNI, COUNT(*)
FROM Usuarios
GROUP BY DNI
HAVING COUNT(*) > 1;

-- Buscar Emails duplicados
SELECT Email, COUNT(*)
FROM Usuarios
GROUP BY Email
HAVING COUNT(*) > 1;
-- Ambas consultas deberían devolver cero filas.

SELECT * FROM DetalleOrdenes;