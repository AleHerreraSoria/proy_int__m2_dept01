-- models/staging/stg_productos.sql

SELECT
    ProductoID AS product_id,
    Nombre AS product_name,
    Descripcion AS product_description,
    Precio AS price,
    Stock AS stock_quantity,
    CategoriaID AS category_id
FROM
    {{ source('sql_server_dbo', 'Productos') }}