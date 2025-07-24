USE EcommerceDB;
GO

-- Insertar productos para Categorías (asumiendo CategoriaID según orden previo)

-- 1. Electrónica (CategoriaID = 1)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Smartphone Galaxy A54', 'Teléfono inteligente con pantalla AMOLED y cámara triple.', 349.99, 50, 1),
('Laptop Dell Inspiron 15', 'Laptop para trabajo y estudio con procesador Intel i5.', 799.00, 30, 1),
('Auriculares Bluetooth Sony', 'Auriculares inalámbricos con cancelación de ruido.', 129.99, 100, 1);

-- 2. Moda (CategoriaID = 2)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Camiseta Básica Hombre', 'Camiseta de algodón 100% disponible en varias tallas.', 14.99, 200, 2),
('Jeans Skinny Mujer', 'Jeans corte skinny de mezclilla azul.', 39.99, 150, 2),
('Zapatillas Deportivas', 'Calzado deportivo para running o uso casual.', 59.99, 80, 2);

-- 3. Hogar y Cocina (CategoriaID = 3)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Sartén Antiadherente 24cm', 'Sartén de aluminio con recubrimiento antiadherente.', 19.99, 120, 3),
('Juego de Sábanas Queen', 'Juego de sábanas de algodón para cama tamaño Queen.', 49.99, 60, 3),
('Lámpara de Escritorio LED', 'Lámpara LED con ajuste de intensidad.', 25.50, 75, 3);

-- 4. Deportes y Aire Libre (CategoriaID = 4)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Bicicleta Montaña Aro 29', 'Bicicleta para adulto con cambios Shimano.', 299.00, 20, 4),
('Pelota de Fútbol Profesional', 'Balón de fútbol tamaño 5 para partidos.', 29.99, 100, 4),
('Mochila Deportiva Nike', 'Mochila para gym o uso diario.', 35.00, 50, 4);

-- 5. Belleza y Cuidado Personal (CategoriaID = 5)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Crema Hidratante Facial', 'Hidratante para todo tipo de piel.', 15.99, 150, 5),
('Perfume Hombre 100ml', 'Fragancia fresca y duradera.', 55.00, 40, 5),
('Plancha para Cabello Remington', 'Alisadora con placas de cerámica.', 45.50, 70, 5);

-- 6. Juguetes y Juegos (CategoriaID = 6)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Lego City Policía', 'Set de construcción Lego temática policía.', 29.99, 80, 6),
('Muñeca Barbie Original', 'Muñeca Barbie con accesorios.', 24.99, 60, 6),
('Juego de Mesa Monopoly', 'Versión clásica del juego Monopoly.', 35.00, 50, 6);

-- Puedes seguir con las demás categorías si quieres poblar más ejemplos.
GO

-- 7. Automotriz (CategoriaID = 7)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Aceite de Motor 5W30', 'Lubricante sintético para autos modernos.', 22.90, 80, 7),
('Limpiaparabrisas Universal', 'Juego de escobillas para múltiples modelos de autos.', 15.50, 60, 7),
('Cámara de Reversa', 'Cámara HD para asistencia de estacionamiento.', 39.99, 40, 7);

-- 8. Libros y Papelería (CategoriaID = 8)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Libro: Cien Años de Soledad', 'Novela de Gabriel García Márquez.', 19.99, 100, 8),
('Cuaderno Universitario 100h', 'Cuaderno rayado, tamaño A4.', 4.50, 300, 8),
('Set de Lápices de Colores', '12 lápices de colores no tóxicos.', 6.75, 150, 8);

-- 9. Salud (CategoriaID = 9)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Multivitamínico Centrum', 'Vitaminas para adultos, frasco de 60 tabletas.', 17.90, 120, 9),
('Termómetro Digital', 'Termómetro clínico de alta precisión.', 9.99, 80, 9),
('Alcohol en Gel 500ml', 'Gel antibacterial con 70% de alcohol.', 5.25, 200, 9);

-- 10. Mascotas (CategoriaID = 10)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Alimento para Perro 10kg', 'Croquetas para perros adultos sabor carne.', 32.00, 90, 10),
('Arenero para Gato', 'Caja sanitaria con tapa y filtro.', 25.99, 40, 10),
('Juguete Mordedor Canino', 'Juguete resistente para perros medianos.', 8.50, 110, 10);

-- 11. Tecnología y Gadgets (CategoriaID = 11)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Smartwatch Xiaomi Mi Band 8', 'Pulsera inteligente con monitor de ritmo cardíaco.', 44.90, 100, 11),
('Mini Proyector LED', 'Proyector portátil para películas o presentaciones.', 75.00, 35, 11),
('Power Bank 20,000mAh', 'Batería externa de carga rápida USB-C.', 29.99, 70, 11);

-- 12. Videojuegos (CategoriaID = 12)
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, CategoriaID) VALUES
('Consola PlayStation 5', 'Consola de videojuegos de última generación.', 549.99, 20, 12),
('Control Xbox Series X', 'Mando inalámbrico con vibración y grip.', 59.99, 50, 12),
('Juego FIFA 24 - PS5', 'Juego de fútbol con licencias oficiales.', 69.99, 30, 12);

GO

