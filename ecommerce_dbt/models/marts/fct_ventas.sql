-- models/marts/fct_ventas.sql

{{
  config(
    materialized='table'
  )
}}

WITH stg_ordenes AS (
    SELECT *
    FROM {{ ref('stg_ordenes') }}
),
stg_detalle_ordenes AS (
    SELECT *
    FROM {{ ref('stg_detalle_ordenes') }}
)
SELECT
    -- Llaves a dimensiones
    o.order_date,
    o.user_id,
    od.product_id,
    
    -- Métricas
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS total_amount,

    -- Atributos descriptivos
    o.status,
    o.order_id -- Mantenemos el ID de la orden para análisis a nivel de orden
FROM
    stg_ordenes o
JOIN stg_detalle_ordenes od ON o.order_id = od.order_id