# Proyecto Integrador M2: Modelado de Datos para E-Commerce

Este repositorio contiene el desarrollo del Proyecto Integrador del Módulo 2, enfocado en la optimización de una plataforma de e-commerce mediante la implementación de un modelo de datos dimensional y la utilización de herramientas de ingeniería de datos.

## Avance 1: Carga y Entendimiento de los Datos

En esta primera fase del proyecto, se establecieron las bases para el modelado de datos. Los objetivos principales fueron configurar el entorno, realizar una carga inicial de los datos fuente y llevar a cabo un análisis exploratorio exhaustivo para evaluar la calidad y la estructura de la información.

### 📜 Estructura del Repositorio

* **/docs**: Contiene los informes detallados de cada avance del proyecto.
    * `INFORME_AVANCE_1.md`: El reporte completo con los hallazgos y decisiones de esta fase.
* **/notebooks**: Almacena los Jupyter Notebooks utilizados para el análisis exploratorio de datos (EDA).
* **/scripts**: Contiene los scripts de Python desarrollados para la automatización de tareas, como la carga de datos.
* **/sql_scripts**: Almacena todos los archivos `.sql` originales que sirvieron como fuente de datos.
* `README.md`: Este archivo, la guía principal del repositorio.

### ⚙️ Cómo Replicar el Entorno

Para configurar y ejecutar este avance, sigue los siguientes pasos:

1.  **Prerrequisitos:**
    * Tener instalado **Microsoft SQL Server** (cualquier edición).
    * Tener instalado **Python 3**.
    * Tener instalada la librería `pyodbc` y `sqlalchemy` (`pip install pyodbc sqlalchemy`).

2.  **Clonar el Repositorio:**
    ```bash
    git clone https://github.com/AleHerreraSoria/proy_int__m2_dept01.git
    ```

3.  **Configurar el Script de Carga:**
    * Abre el archivo `scripts/conexion_sql_server.py`.
    * Modifica la variable `SERVER_NAME` con el nombre de tu instancia local de SQL Server.

4.  **Ejecutar la Carga:**
    * Abre una terminal en la raíz del proyecto.
    * Ejecuta el script:
        ```bash
        python scripts/conexion_sql_server.py
        ```
    * El script creará la base de datos `EcommerceDB`, las tablas, y cargará todos los datos válidos, reportando cualquier inconsistencia encontrada.

### 🚀 Hallazgos Clave del Avance 1

El análisis de calidad de datos reveló varios problemas críticos en los datos fuente:

1.  **Integridad Referencial Masiva (Datos Huérfanos):** El problema más grave detectado. La mayoría de los registros en tablas transaccionales (`Ordenes`, `DetalleOrdenes`, `HistorialPagos`, etc.) no pudieron ser cargados porque hacen referencia a `UsuarioID` u `OrdenID` que no existen.
2.  **Corrupción de Datos Geográficos:** Las relaciones entre ciudades y provincias son sistémicamente incorrectas, haciendo estos datos inutilizables para el análisis sin una limpieza profunda.
3.  **Duplicados en Datos Fuente:** Se detectaron intentos de inserción de usuarios con DNI o Email duplicados, los cuales fueron prevenidos por las restricciones de la base de datos.
4.  **Inconsistencia Financiera:** Discrepancias significativas entre los totales de las órdenes y los montos de pago registrados.

Para un desglose completo de los hallazgos y las decisiones tomadas, consulta el [Informe Detallado del Avance 1](./docs/INFORME_AVANCE_1.md).

### 🔜 Próximos Pasos

El siguiente paso en el proyecto es el **Avance 2: Modelado de Datos**, donde se diseñará el modelo dimensional en estrella que servirá como base para el futuro Data Warehouse.
