# =========================================================
# ANÁLISIS: Adquisiciones de Disney y su impacto en el valor de la empresa
# =========================================================

# Librerías
library(readxl)
library(tidyverse)
library(broom)
library(gt)

# =========================================================
# 1. Cargar base de datos
# =========================================================
df <- read_excel("datos_disney_mensual.xlsx")

# Convertir las variables de rendimiento a numéricas (están como texto)
df <- df %>%
  mutate(
    Rendimiento = as.numeric(Rendimiento),
    Rend_SP500 = as.numeric(Rend_SP500)
  )

# =========================================================
# 2. MODELO DE REGRESIÓN MÚLTIPLE
# =========================================================
modelo <- lm(Rendimiento ~ Pixar + Marvel + Lucasfilm + `21st Century Fox` + Hulu + 
               Rend_SP500 + Tiempo, data = df)

summary (modelo)
# =========================================================
# 3. TABLA DE RESULTADOS
# =========================================================
resultados <- tidy(modelo) %>%
  mutate(
    term = recode(term,
                  "(Intercept)" = "Intercepto (β₀)",
                  "Pixar" = "Dummy Pixar (β₁)",
                  "Marvel" = "Dummy Marvel (β₂)",
                  "Lucasfilm" = "Dummy Lucasfilm (β₃)",
                  "`21st Century Fox`" = "Dummy 21st Century Fox (β₄)",
                  "Hulu" = "Dummy Hulu (β₅)",
                  "Rend_SP500" = "Rendimiento S&P 500 (β₆)",
                  "Tiempo" = "Tendencia Temporal (β₇)")
  )

tabla_resultados <- resultados %>%
  select(term, estimate, std.error, statistic, p.value) %>%
  gt() %>%
  tab_header(
    title = "Resultados de la Regresión Múltiple",
    subtitle = "Efecto de las adquisiciones sobre el rendimiento de Disney"
  ) %>%
  fmt_number(
    columns = c(estimate, std.error, statistic, p.value),
    decimals = 4
  ) %>%
  cols_label(
    term = "Variable",
    estimate = "Coeficiente",
    std.error = "Error Estándar",
    statistic = "Estadístico t",
    p.value = "Valor p"
  )

# Agregar estadísticas del modelo
resumen_modelo <- glance(modelo)
tabla_final <- tabla_resultados %>%
  tab_source_note(
    source_note = md(
      paste0(
        "**R²:** ", round(resumen_modelo$r.squared, 4), " ",
        "**R² ajustado:** ", round(resumen_modelo$adj.r.squared, 4), " ",
        "**Estadístico F:** ", round(resumen_modelo$statistic, 2), " ",
        "**p-valor (F):** ", format.pval(resumen_modelo$p.value, digits = 4)
      )
    )
  )

# Mostrar y guardar la tabla
tabla_final
gtsave(tabla_final, "Tabla_regresion_multiple.png")

# =========================================================
# 4. GRÁFICO: RENDIMIENTO REAL VS PREDICHO
# =========================================================
df$predicciones <- predict(modelo)

grafico_regresion <- ggplot(df, aes(x = Rendimiento, y = predicciones)) +
  geom_point(color = "#1f77b4", alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "#d62728", linewidth = 1) +
  labs(
    title = "Rendimiento Real vs Predicho de Disney",
    subtitle = "Modelo multivariable con efecto de adquisiciones y control de mercado",
    x = "Rendimiento Real",
    y = "Rendimiento Predicho"
  ) +
  theme_minimal(base_size = 13)

print(grafico_regresion)
ggsave("grafico_regresion_multiple.png", grafico_regresion, width = 8, height = 5, dpi = 300)

# =========================================================
# 5. GRÁFICO DE RESIDUOS
# =========================================================
grafico_residuos <- ggplot(data.frame(
  fitted = fitted(modelo),
  residuales = resid(modelo)
), aes(x = fitted, y = residuales)) +
  geom_point(color = "orange") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(
    title = "Gráfico de Residuos del Modelo de Regresión",
    x = "Valores ajustados",
    y = "Residuos"
  ) +
  theme_minimal()

print(grafico_residuos)
ggsave("grafico_residuos_multiple.png", grafico_residuos, width = 8, height = 5, dpi = 300)
