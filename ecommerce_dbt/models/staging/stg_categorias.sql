-- models/staging/stg_categorias.sql

SELECT
    CategoriaID AS category_id,
    Nombre AS category_name,
    Descripcion AS category_description
FROM
    {{ source('sql_server_dbo', 'Categorias') }}