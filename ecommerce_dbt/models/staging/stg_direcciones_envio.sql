-- models/staging/stg_direcciones_envio.sql

SELECT
    DireccionID AS address_id,
    UsuarioID AS user_id,
    Calle AS street_address,
    Ciudad AS city,
    Provincia AS province,
    Pais AS country,
    CodigoPostal AS postal_code
FROM
    {{ source('sql_server_dbo', 'DireccionesEnvio') }}