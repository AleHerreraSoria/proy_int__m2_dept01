-- models/marts/dim_clientes.sql

-- Configuramos la materialización como 'table'
{{
  config(
    materialized='table'
  )
}}

WITH stg_usuarios AS (
    SELECT *
    FROM {{ ref('stg_usuarios') }} -- ref() es la forma de DBT de referenciar otros modelos
),
stg_direcciones AS (
    SELECT *
    FROM {{ ref('stg_direcciones_envio') }}
)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.dni,
    u.registration_date,
    d.street_address,
    d.city,
    d.province,
    d.country,
    d.postal_code
FROM
    stg_usuarios u
LEFT JOIN stg_direcciones d ON u.user_id = d.user_id