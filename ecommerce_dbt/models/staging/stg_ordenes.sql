-- models/staging/stg_ordenes.sql

SELECT
    OrdenID AS order_id,
    UsuarioID AS user_id,
    CAST(FechaOrden AS DATE) AS order_date,
    Estado AS status
FROM
    {{ source('sql_server_dbo', 'Ordenes') }}