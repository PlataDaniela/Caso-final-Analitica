# Análisis de Rendimientos y Adquisiciones de Disney (2005–2025)

POR DANIELA PLATA Y LUCÍA BALLESTEROS

## Afiliación académica

Estudiante, Pontificia Universidad Javeriana
Estudiante, Pontificia Universidad Javeriana

## Agradecimientos

Este trabajo fue desarrollado como parte del curso Analítica de Negocios en la Pontificia Universidad Javeriana.

## Derechos de autor

©2025 Daniela Plata & Lucía Ballesteros.
Este repositorio ha sido creado con fines académicos y no representa un aval ni un juicio sobre el material incluido.

# RESUMEN

Este proyecto analiza los factores que explican el comportamiento del rendimiento mensual de la acción de Disney entre 2005 y 2025. Para ello se construyó un modelo de regresión lineal múltiple que incorpora:

Variables dummy para las adquisiciones de Disney (Pixar, Marvel, Lucasfilm, 21st Century Fox y Hulu).

El rendimiento del S&P 500 como variable de control del mercado.

Una variable de tendencia temporal para capturar cambios estructurales en el tiempo.

El objetivo principal es evaluar si las adquisiciones tuvieron un impacto significativo en el rendimiento de la acción, una vez se controla por movimientos generales del mercado y tendencias de largo plazo.
El proyecto incluye generación de bases de datos, análisis estadístico, gráficos, estimación del modelo, validación de supuestos y conclusiones.

# CONTENIDO 
* Carpeta Datos:
    Contiene datos_disney_mensual.xlsx: Base final con rendimientos mensuales de Disney, S&P500, dummies por adquisiciones y variable de tiempo.

* Carpeta Codigo:
    Incluye scripts en R que permiten reproducir el análisis:
    + Datos.r: Limpieza, construcción de rendimientos, merge con S&P500, creación de dummies y exportación.
    
    + Regresion.r: Estimación del modelo de regresión múltiple y validación de supuestos.
    
    + Explorador.r: Histogramas, inspección visual y análisis preliminar de las variables.

* Carpeta Graficos:
    Incluye imágenes en .png generadas durante el análisis:

    + histograma_Disney.png – Distribución del rendimiento de Disney
    
    + histograma_SP500.png – Distribución del rendimiento del S&P500
    
    + grafico_regresion_multiple.png – Gráfico del modelo estimado
    
    + grafico_residuos_multiple.png – Validación de supuestos mediante residuos
    
    + Tabla_regresion_multiple.png – Tabla final de coeficientes

* Carpeta Resultados:
    Contiene Informe en PDF Caso_final_analitica.pdf.


## Lenguaje

El proyecto está desarrollado en R, un lenguaje orientado al análisis estadístico, manipulación de datos y visualización. Su uso permitió:

+ Calcular rendimientos y transformar series temporales.

+ Generar histogramas y explorar la distribución de variables.

+ Construir y estimar el modelo de regresión múltiple.

+ Validar supuestos mediante análisis de residuos.

+ Exportar tablas y resultados para informes.

## Librerías

### moments
    → Para calcular medidas de forma: asimetría (skewness) y curtosis.
    → Útil en el análisis exploratorio para evaluar si los rendimientos
      siguen una distribución normal o presentan sesgos/extremos.
library(moments)


###  readxl
    → Lectura directa de archivos Excel (.xlsx).
    → Usado para importar la base de datos principal: "datos_disney_mensual.xlsx".
library(readxl)


### tidyverse
    → Conjunto de paquetes esenciales:
        • dplyr   → manipulación de datos (mutate, select, filter, etc.)
        • ggplot2 → gráficos (histogramas, dispersión, líneas)
        • tidyr   → limpieza y reestructuración
        • purrr   → (opcional, pero incluido)
    → Usado en: transformación de datos, gráficos, unión de bases.
library(tidyverse)


### gt
    → Creación de tablas profesionales y exportables (PNG, HTML, PDF).
    → Usado para presentar resultados de regresión con formato claro y listo para informes.
library(gt)


