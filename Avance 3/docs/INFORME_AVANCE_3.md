# Informe Técnico: Avance 3 del Proyecto Integrador

*Confeccionado por: Alejandro N. Herrera Soria*
*La Rioja (AR), 23 de Julio de 2025*

**Proyecto:** Optimización de una plataforma para un comercio electrónico con modelado dimensional y DBT.
**Fase:** Avance 3 - Transformación de Datos con Python y DBT.

Este documento detalla la implementación del pipeline de transformación de datos utilizando DBT, desde los datos fuente hasta el modelo dimensional final.

### PI 1: Implementación del Modelo Físico

El modelo de datos físico, que consiste en las tablas de hechos y dimensiones (`FactSales`, `DimCustomer`, etc.), fue implementado en la fase final del Avance 2. Se utilizó un script SQL para ejecutar las sentencias `CREATE TABLE`, definiendo las columnas, tipos de datos, llaves primarias y foráneas de acuerdo al diseño lógico propuesto. Esto preparó el esquema de destino en la base de datos `EcommerceDB` para recibir los datos transformados.

### PI 2: Creación de Scripts de Transformación en DBT

Se implementó un pipeline de transformación siguiendo la arquitectura medallón (Bronce -> Plata -> Oro), utilizando modelos de DBT.

**a. Limpieza y Normalización (Capa Staging - Bronce):**
El primer paso fue crear una representación limpia y consistente de las tablas fuente.
* **Estrategia:** Se creó un modelo de staging (`stg_*.sql`) para cada tabla fuente relevante (`Usuarios`, `Ordenes`, `Productos`, etc.).
* **Transformaciones Aplicadas:**
    * **Renombrado de Columnas:** Se estandarizaron los nombres de las columnas a un formato consistente (ej. `UsuarioID` -> `user_id`).
    * **Casting de Tipos de Datos:** Se ajustaron tipos de datos para asegurar consistencia (ej. `CAST(FechaRegistro AS DATE)`).
* **Resultado:** Se generaron 6 vistas (`views`) en la base de datos, una por cada tabla fuente, sirviendo como una base limpia para las transformaciones posteriores.

**b. Creación de Tablas de Hechos y Dimensiones (Capa Marts - Oro):**
Esta capa contiene los modelos finales que serán consumidos por los analistas.
* **Estrategia:** Se crearon modelos (`dim_*.sql`, `fct_*.sql`) que unen las vistas de la capa de staging para construir el modelo en estrella. Estos modelos fueron materializados como `tables` para optimizar el rendimiento de las consultas.
* **Modelos Creados:**
    * `dim_clientes`: Une `stg_usuarios` y `stg_direcciones_envio` para crear una vista 360 del cliente.
    * `dim_productos`: Une `stg_productos` y `stg_categorias` para enriquecer la información del producto.
    * `fct_ventas`: Une `stg_ordenes` y `stg_detalle_ordenes` para construir la tabla de hechos con las métricas de negocio.

**c. Implementación de Slowly Changing Dimensions (SCDs):**
Aunque el diseño del Avance 2 contemplaba estrategias de SCD Tipo 2 para productos y geografía, la implementación inicial se centró en construir un pipeline funcional de punta a punta. La lógica para manejar SCDs con `snapshots` de DBT se considera un paso avanzado y se implementará en una fase posterior de optimización del proyecto.

### PI 3: Manejo de Relaciones en DBT

La integridad y las relaciones entre los modelos se garantizaron mediante el uso de las funcionalidades nativas de DBT:
* **Función `source()`:** Se utilizó en los modelos de staging para declarar la dependencia de las tablas fuente originales, permitiendo a DBT entender el origen de los datos.
* **Función `ref()`:** Se utilizó en los modelos de marts para referenciar otros modelos (ej. `fct_ventas` referencia a `stg_ordenes`). Esto permite a DBT construir automáticamente el grafo de dependencias (DAG), asegurando que los modelos se ejecuten en el orden correcto.

### PI 4: Presentación de Insights (Storytelling)

Gracias al pre-procesamiento de los datos fuente con el script `limpiar_datos.py` y la posterior transformación con DBT, la tabla `fct_ventas` ahora contiene datos consistentes. Esto nos permite ejecutar consultas simples sobre el modelo dimensional para responder preguntas de negocio clave.

**Consulta 1: Top 5 Productos por Ingresos**
```sql
SELECT TOP 5
    p.product_name,
    SUM(v.total_amount) AS total_revenue
FROM dbo.fct_ventas v
JOIN dbo.dim_productos p ON v.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;
```
* **Insight:** Esta consulta revela qué productos son los más rentables, permitiendo al negocio enfocar sus estrategias de marketing e inventario.

**Consulta 2: Ingresos Mensuales**
```sql
SELECT
    YEAR(order_date) AS anio,
    MONTH(order_date) AS mes,
    SUM(total_amount) AS ingresos_mensuales
FROM dbo.fct_ventas
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY anio, mes;
```
* **Insight:** Permite visualizar la tendencia de ventas a lo largo del tiempo, identificar estacionalidad y medir el crecimiento del negocio mes a mes.
