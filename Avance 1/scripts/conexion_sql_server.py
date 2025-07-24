import os
import pyodbc
from sqlalchemy import create_engine, text
import time

# --- CONFIGURACIÓN DE LA CONEXIÓN A SQL SERVER ---

SERVER_NAME = "DESKTOP-4M217QU"  
DATABASE_NAME = "EcommerceDB"
USERNAME = "tu_usuario"  # Opcional, si usamos autenticación SQL
PASSWORD = "tu_contraseña" # Opcional, si usamos autenticación SQL
DRIVER = "{ODBC Driver 17 for SQL Server}"

# Directorio donde se encuentran los scripts SQL
SQL_SCRIPTS_DIR = "Avance 1/sql_scripts_clean"

# --- ORDEN DE EJECUCIÓN DE SCRIPTS ---
# (crucial para respetar las Foreign Keys
SCRIPTS_ORDER = [
    # Creación de la DB y Tablas
    '1.Create_ddl.sql',
    # Tablas maestras sin dependencias
    '3.categorias.sql',
    '9.metodos_pago.sql',
    '2.usuarios.sql',
    # Tablas con dependencias
    '4.Productos.sql',
    '7.direcciones_envio.sql',
    '5.ordenes.sql',
    # Tablas con dependencias múltiples
    '8.carrito.sql',
    '11.resenas_productos.sql',
    '6.detalle_ordenes.sql',
    '10.ordenes_metodospago.sql',
    '12.historial_pagos.sql'
]

def execute_sql_script(file_path, connection):
    """
    Lee un archivo .sql y ejecuta su contenido. Si encuentra un error de integridad
    (ej. FK no válida), lo reporta y continúa con los demás comandos.
    """
    print(f"  -> Ejecutando script: {os.path.basename(file_path)}...")
    error_count = 0
    
    with open(file_path, 'r', encoding='utf-8') as f:
        # El delimitador 'GO' es específico de T-SQL y no es un comando SQL estándar.
        # Debemos dividir el script en lotes y ejecutarlos uno por uno.
        sql_batches = f.read().split('GO\n')
        cursor = connection.cursor()
        
        for i, batch in enumerate(sql_batches):
            batch = batch.strip()
            if not batch:
                continue

            # Si el lote es una inserción de datos, establecemos el formato de fecha
            # a AÑO-MES-DÍA para evitar errores por configuraciones regionales.
            if batch.upper().startswith('INSERT'):
                batch_to_execute = "SET DATEFORMAT ymd;\n" + batch
            else:
                batch_to_execute = batch
            
            try:
                cursor.execute(batch_to_execute)
            except pyodbc.IntegrityError as e:
                # *** INICIO DE LA MODIFICACIÓN ***
                # Captura errores de FK, claves duplicadas, etc. SIN detener el script.
                error_count += 1
                print(f"    -> ADVERTENCIA: Se omitió un lote en '{os.path.basename(file_path)}' por error de integridad. Lote #{i+1}. Error: {e}")
                # *** FIN DE LA MODIFICACIÓN ***
            except Exception as e:
                # Captura cualquier otro error inesperado y detiene la ejecución.
                print(f"  -> ERROR CRÍTICO al ejecutar {os.path.basename(file_path)}: {e}")
                raise

    connection.commit() # Confirma todos los lotes que SÍ tuvieron éxito.
    
    if error_count > 0:
        print(f"  -> Script {os.path.basename(file_path)} ejecutado con {error_count} advertencia(s) (lotes omitidos).")
    else:
        print(f"  -> Script {os.path.basename(file_path)} ejecutado con éxito.")


def setup_database():
    """
    Orquesta la creación y población de la base de datos.
    """
    print("--- INICIANDO CONFIGURACIÓN DE LA BASE DE DATOS ---")

    master_conn_str = (
        f"DRIVER={DRIVER};"
        f"SERVER={SERVER_NAME};"
        f"DATABASE=master;"
        f"Trusted_Connection=yes;"
    )
    
    try:
        print("\n[Paso 1/4] Conectando a la instancia de SQL Server (master)...")
        master_conn = pyodbc.connect(master_conn_str, autocommit=True)
        print("Conexión a 'master' exitosa.")
        
        print("\n[Paso 2/4] Asegurando un entorno limpio...")
        cursor = master_conn.cursor()
        cursor.execute("IF DB_ID('EcommerceDB') IS NOT NULL DROP DATABASE EcommerceDB;")
        print("Base de datos preexistente eliminada (si la había). Entorno listo.")
        cursor.close()

        print("\n[Paso 3/4] Creando la base de datos y las tablas...")
        ddl_script_path = os.path.join(SQL_SCRIPTS_DIR, SCRIPTS_ORDER[0])
        # Usamos un 'with' para asegurar que la conexión se cierre incluso si hay un error
        with master_conn.cursor() as cursor:
             execute_sql_script(ddl_script_path, master_conn)
        master_conn.close()
        print("Base de datos 'EcommerceDB' y tablas creadas.")
        
        time.sleep(2)

        print("\n[Paso 4/4] Poblando las tablas con los datos...")
        db_conn_str = (
            f"DRIVER={DRIVER};"
            f"SERVER={SERVER_NAME};"
            f"DATABASE={DATABASE_NAME};"
            f"Trusted_Connection=yes;"
        )
        db_conn = pyodbc.connect(db_conn_str)
        
        for script_name in SCRIPTS_ORDER[1:]:
            script_path = os.path.join(SQL_SCRIPTS_DIR, script_name)
            execute_sql_script(script_path, db_conn)
            
        db_conn.close()
        print("\n¡Proceso de carga de datos finalizado!")

    except pyodbc.Error as ex:
        sqlstate = ex.args[0]
        print(f"ERROR de conexión o ejecución: {sqlstate}")
        print(ex)
        return False
    except FileNotFoundError as e:
        print(f"ERROR: No se encontró el archivo de script. Asegúrate de que la carpeta '{SQL_SCRIPTS_DIR}' exista y contenga todos los archivos .sql.")
        print(e)
        return False
    except Exception as e:
        print(f"Ocurrió un error inesperado: {e}")
        return False
        
    return True

def verify_orm_connection():
    """
    Verifica la conexión a la base de datos final usando SQLAlchemy (ORM).
    """
    print("\n--- VERIFICANDO CONEXIÓN CON ORM (SQLAlchemy) ---")
    try:
        engine_conn_str = (
            f"mssql+pyodbc://@{SERVER_NAME}/{DATABASE_NAME}?"
            f"driver=ODBC+Driver+17+for+SQL+Server&"
            f"trusted_connection=yes"
        )
        
        engine = create_engine(engine_conn_str)
        
        with engine.connect() as connection:
            print("Conexión con SQLAlchemy exitosa.")
            query = text("SELECT COUNT(*) FROM Usuarios;")
            result = connection.execute(query).scalar()
            print(f"Verificación: Se encontraron {result} registros en la tabla 'Usuarios'.")
            print("¡El entorno parece estar configurado correctamente!")
            
    except Exception as e:
        print(f"ERROR al verificar la conexión con SQLAlchemy: {e}")


if __name__ == "__main__":
    if setup_database():
        verify_orm_connection()
    else:
        print("\nLa configuración de la base de datos falló. Por favor, revisa los errores.")

