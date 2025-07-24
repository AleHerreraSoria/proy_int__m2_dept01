-- models/staging/stg_detalle_ordenes.sql

SELECT
    DetalleID AS order_detail_id,
    OrdenID AS order_id,
    ProductoID AS product_id,
    Cantidad AS quantity,
    PrecioUnitario AS unit_price
FROM
    {{ source('sql_server_dbo', 'DetalleOrdenes') }}