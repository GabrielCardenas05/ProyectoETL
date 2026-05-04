# Proyecto ETL y Data Warehouse de Ventas (DWH_Ventas)

## 📌 Descripción General
Este proyecto consiste en el diseño e implementación integral de un proceso ETL (Extract, Transform, Load) para integrar información proveniente de diferentes bases de datos operacionales hacia un Data Warehouse centralizado. El objetivo principal es consolidar información de ventas y productos de fuentes dispares para facilitar consultas analíticas, toma de decisiones y generación de reportes empresariales.

---

## 🏗️ Arquitectura y Tecnologías
El ecosistema del proyecto se divide en tres capas principales que interactúan mediante procesos de integración de datos:

* **Base de Datos Operacional 1 (Librería):** Implementada en **MariaDB**. Contiene catálogos de libros, categorías, clientes, autores y transacciones de órdenes de compra.
* **Base de Datos Operacional 2 (Tienda/Supermercado):** Implementada en **Oracle Database**. Contiene catálogos de productos, marcas, clientes, empleados, métodos de pago y órdenes de venta.
* **Data Warehouse (Destino):** Implementado en **Microsoft SQL Server (SSMS)** bajo un modelo estrella (Star Schema) optimizado para consultas OLAP.
* **Herramienta de Integración ETL:** Visual Studio con **SQL Server Integration Services (SSIS)**.

---

## 📊 Modelo del Data Warehouse (Star Schema)
El Data Warehouse está diseñado con una tabla de hechos central rodeada de dimensiones estandarizadas, relacionadas mediante claves foráneas.

### Tablas de Dimensión
* **Dim_Products:** Almacena la información unificada de productos, libros y sus respectivas categorías.
* **Dim_Customer:** Centraliza la información de los clientes de ambas sucursales.
* **Dim_Location:** Estandariza la información geográfica (código postal, región, territorio).
* **Dim_Time:** Dimensión temporal granular que desglosa las fechas de operación por día, mes, trimestre y año.

### Tabla de Hechos
* **Fact_Sales:** Almacena las métricas transaccionales (cantidades, precios unitarios, descuentos) enlazando el ID de producto, ID de cliente, código postal y fecha.

---

## ⚙️ Proceso ETL e Implementación en SSIS
El paquete de SSIS está diseñado para ejecutarse de manera secuencial, garantizando la integridad referencial al cargar primero los catálogos y finalmente las transacciones.

### 1. Extracción (Extract)
Se configuraron conexiones OLE DB para extraer información desde MariaDB y Oracle. Se utilizaron comandos SQL nativos en los orígenes para filtrar datos nulos y preparar las columnas antes de que entraran al flujo de memoria de SSIS.

### 2. Transformación (Transform)
Durante el flujo de datos (Data Flow), se aplicaron soluciones de ingeniería para resolver conflictos estructurales entre los motores de bases de datos:
* **Prevención de Colisiones de PK:** Se implementó una lógica de *offset* matemático (sumando 100,000 a los IDs de la librería) para evitar registros duplicados en las llaves primarias unificadas.
* **Fusión de Datos:** Uso del componente `Union All` para homologar columnas dispares (ej. concatenación de nombre/apellido frente a nombre de compañía).
* **Limpieza de Duplicados Geográficos:** Implementación del componente `Sort` (Ordenar) configurado para eliminar valores duplicados basándose en el código postal, garantizando la unicidad requerida por la tabla `Dim_Location`.
* **Casteo Estricto de Metadatos:** Creación de una Columna Derivada (Derived Column) con la expresión `(DT_NUMERIC,5,2)0` para inyectar campos de descuento faltantes y resolver excepciones nativas de metadatos corruptos (HRESULT: 0xC0204006).
* **Generación de IDs al vuelo:** Uso de funciones ventana (`ROW_NUMBER() OVER()`) para asignar identificadores de detalle a transacciones que carecían de ellos en su esquema original.

### 3. Carga (Load)
La información transformada fue inyectada hacia las tablas de SQL Server utilizando destinos OLE DB con la opción de carga rápida (`Table Lock`) activada para optimizar el rendimiento. 

**Nota sobre Dim_Time:** Para optimizar recursos en SSIS, la carga del calendario se maneja de forma asíncrona mediante un script T-SQL con un ciclo `WHILE` ejecutado directamente en SSMS, cubriendo más de una década de operaciones.

---

## 🧪 Datos de Prueba y Resultados
Para validar el funcionamiento del flujo, se generaron y procesaron más de 100 registros transaccionales y de catálogos para cada motor de base de datos (tienda y librería).

**Logros del proyecto:**
* Migración correcta y unificación de datos desde sistemas completamente distintos (Oracle y MariaDB).
* Integridad referencial absoluta (cero registros huérfanos en la tabla de hechos).
* Resolución exitosa de conflictos de tipos de datos entre proveedores OLE DB.

---

## 🔍 Consultas de Validación SQL
Una vez poblado el Data Warehouse, se pueden ejecutar consultas analíticas de alto rendimiento:

**Consultar los registros recientes de ventas consolidadas:**
```sql
SELECT TOP 10 *
FROM Fact_Sales;
