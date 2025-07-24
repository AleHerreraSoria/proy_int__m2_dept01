-- models/staging/stg_usuarios.sql

SELECT
    UsuarioID AS user_id,
    Nombre AS first_name,
    Apellido AS last_name,
    Email AS email,
    DNI AS dni,
    CAST(FechaRegistro AS DATE) AS registration_date
FROM
    {{ source('sql_server_dbo', 'Usuarios') }}

