# Proyecto Final — Manejo de Datos (EDA)
### Análisis de Ventas - Tienda de Tecnología

**Módulo:** Manejo de Datos – EDA
**Grupo:** 04
**Estudiante:** Katherine Susana Rojas Saborío

---

## 1. Descripción General
Este programa en Python está diseñado para realizar un **Análisis Exploratorio de Datos (EDA)** completo sobre un conjunto de datos de ventas. El sistema implementa un menú interactivo robusto, control de errores, validaciones de estado y visualizaciones gráficas profesionales.

## 2. Arquitectura

* **Paso de argumentos explícitos:** Las funciones reciben los DataFrames (`df` o `df_limpio`) como parámetros para garantizar un código modular, predecible y limpio.
* **Validación de carga previa:** El programa verifica de forma estricta que exista un archivo CSV cargado antes de permitir ejecutar cualquier análisis u operación.
* **Control de errores defensivo:** Manejo de excepciones ante archivos corruptos, textos mal formateados o ingresos numéricos incorrectos por parte del usuario.

## 3. Módulos y Opciones del Menú Principal
1. **Cargar archivo CSV:** Permite subir y cargar la base de datos de manera interactiva mediante `google.colab.files`.
2. **Información general y estructura:** Despliega primeras/últimas filas, dimensiones y tipos de datos de las columnas.
3. **Análisis de nulos y duplicados:** Cuantifica valores faltantes y detecta filas completamente duplicadas.
4. **Estadísticas descriptivas y Outliers:** Calcula media, mediana, cuartiles y utiliza el Rango Intercuartílico (IQR) para detectar registros atípicos.
5. **Limpieza de datos (Análisis adicional):** Ejecuta un pipeline de estandarización profunda (elimina ventas sin precio, corrige mayúsculas/minúsculas, normaliza tildes en productos, unifica formato de fechas, maneja regiones nulas y limpia duplicados) mostrando un informe de cambios detallado.
6. **Consultas y filtrados dinámicos:** Permite aislar subconjuntos de información por categoría o región.
7. **Agrupaciones de negocio:** Calcula totales vendidos por vendedor, región y categoría, además del promedio por método de pago.
8. **Análisis de relaciones:** Evalúa la matriz de correlación entre variables numéricas clave.
9. **Visualización gráfica:** Genera 5 gráficos (categorías, región, evolución mensual, métodos de pago y boxplot de outliers).
10. **Documentación (README):** Genera y descarga automáticamente este archivo Markdown.
11. **Submenú de ingreso manual:** Permite registrar nuevas transacciones guiando al usuario mediante menús numéricos automatizados y exportando los datos a un nuevo CSV.