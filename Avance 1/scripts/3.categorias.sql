-- Asegúrate de estar usando la base de datos correcta
USE EcommerceDB;
GO

-- Insertar categorías base para comercio electrónico
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Electrónica', 'Teléfonos, computadoras, accesorios y dispositivos inteligentes'),
('Moda', 'Ropa, calzado, bolsos y accesorios para hombres, mujeres y niños'),
('Hogar y Cocina', 'Muebles, electrodomésticos, utensilios y decoración'),
('Deportes y Aire Libre', 'Equipamiento, ropa deportiva y artículos para actividades al aire libre'),
('Belleza y Cuidado Personal', 'Cosméticos, productos para el cabello, piel y aseo personal'),
('Juguetes y Juegos', 'Juguetes para todas las edades, juegos de mesa, didácticos y electrónicos'),
('Automotriz', 'Accesorios y repuestos para vehículos'),
('Libros y Papelería', 'Libros, cuadernos, útiles escolares y de oficina'),
('Salud', 'Vitaminas, suplementos y productos médicos'),
('Mascotas', 'Alimentos, juguetes y productos para el cuidado de mascotas'),
('Tecnología y Gadgets', 'Innovaciones tecnológicas y productos novedosos'),
('Videojuegos', 'Consolas, juegos físicos y digitales, accesorios gamer');
GO
