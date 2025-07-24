USE EcommerceDB;
GO

-- Insertar métodos de pago comunes
INSERT INTO MetodosPago (Nombre, Descripcion) VALUES
('Tarjeta de Crédito', 'Pago con tarjeta de crédito VISA, MasterCard o American Express'),
('Tarjeta de Débito', 'Pago con tarjeta de débito emitida por cualquier banco'),
('Transferencia Bancaria', 'Transferencia directa a nuestra cuenta bancaria'),
('Pago Contra Entrega', 'Paga en efectivo cuando recibes tu pedido'),
('Mercado Pago', 'Pago a través de la pasarela Mercado Pago'),
('PayPal', 'Pago seguro a través de PayPal'),
('Crédito en Tienda', 'Pago usando crédito otorgado por la tienda o cuotas sin interés');
GO
