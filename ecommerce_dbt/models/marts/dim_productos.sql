-- models/marts/dim_productos.sql

{{
  config(
    materialized='table'
  )
}}

WITH stg_productos AS (
    SELECT *
    FROM {{ ref('stg_productos') }}
),
stg_categorias AS (
    SELECT *
    FROM {{ ref('stg_categorias') }}
)
SELECT
    p.product_id,
    p.product_name,
    p.product_description,
    c.category_name,
    p.price,
    p.stock_quantity
FROM
    stg_productos p
LEFT JOIN stg_categorias c ON p.category_id = c.category_id