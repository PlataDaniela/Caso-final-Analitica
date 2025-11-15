# =========================================================
# ANÁLISIS EXPLORATORIO DE DATOS
# =========================================================

# Cargar librerías
library(tidyverse)
library(readxl)
library(sandwich)
library(lmtest)
library(broom)
library(gt)


# Cargar la base de datos (ajusta el nombre del archivo si es distinto)
df <- read_excel("datos_disney_mensual.xlsx")

# Asegurar que las variables estén en formato numérico
df <- df %>%
  mutate(
    Rendimiento = as.numeric(Rendimiento),
    Rend_SP500 = as.numeric(Rend_SP500),
    DIS.Volume = as.numeric(DIS.Volume),
    SP500.Adjusted = as.numeric(SP500.Adjusted)
  )

# =========================================================
# 1. HISTOGRAMAS - para ver la forma (simetría o sesgo)
# =========================================================

# Rendimiento Disney
histograma_Disney <- ggplot(df, aes(x = Rendimiento)) +
    geom_histogram(fill = "#1f77b4", color = "white", bins = 30) +
    labs(title = "Histograma del Rendimiento de Disney",
        x = "Rendimiento mensual", y = "Frecuencia") +
    theme_minimal(base_size = 13)

print(histograma_Disney)
ggsave("histograma_Disney.png", histograma_Disney, width = 8, height = 5, dpi = 300)


# Rendimiento SP500
histograma_SP500 <- ggplot(df, aes(x = Rend_SP500)) +
    geom_histogram(fill = "#ff7f0e", color = "white", bins = 30) +
    labs(title = "Histograma del Rendimiento del S&P 500",
        x = "Rendimiento mensual", y = "Frecuencia") +
    theme_minimal(base_size = 13)

print(histograma_SP500)
ggsave("histograma_SP500.png", histograma_SP500, width = 8, height = 5, dpi = 300)



