# =========================================================
# ANÁLISIS: Adquisiciones de Disney y su impacto en el valor de la empresa
# =========================================================

# Librerías
library(quantmod)
library(openxlsx)
library(tidyverse)

# 1. Descargar datos históricos de Disney y del S&P500 desde Yahoo Finance
getSymbols("DIS", src = "yahoo", from = "2000-01-01", to = "2025-12-31")
getSymbols("^GSPC", src = "yahoo", from = "2000-01-01", to = "2025-12-31")

# 2. Convertir los datos diarios a frecuencia mensual (último día del mes)
disney_monthly <- to.monthly(DIS, indexAt = "lastof", OHLC = TRUE)
sp500_monthly  <- to.monthly(GSPC, indexAt = "lastof", OHLC = TRUE)


# 3. Crear dataframes base
disney_data <- data.frame(
  date = index(disney_monthly),
  DIS.Adjusted = as.numeric(Cl(disney_monthly)),
  DIS.Volume = as.numeric(to.monthly(Vo(DIS), indexAt = "lastof", OHLC = FALSE))
)

sp500_data <- data.frame(
  date = index(sp500_monthly),
  SP500.Adjusted = as.numeric(Cl(sp500_monthly))
)

# 4. Calcular rendimientos mensuales
disney_data$rendimiento <- Delt(disney_data$DIS.Adjusted)
sp500_data$rend_SP500 <- Delt(sp500_data$SP500.Adjusted)

# 5. Unir ambas bases por fecha (para tener el S&P500 junto a Disney)
merged_data <- merge(disney_data, sp500_data, by = "date", all.x = TRUE)

# 6. Fechas de adquisiciones importantes
adq_dates <- as.Date(c("2006-01-24", "2009-08-31", "2012-10-30", "2019-03-20", "2025-07-01"))

# 7. Crear dummy general para meses con adquisiciones
merged_data$adquisicion <- ifelse(format(merged_data$date, "%Y-%m") %in% format(adq_dates, "%Y-%m"), 1, 0)

# 8. Limpiar filas sin datos
merged_data <- na.omit(merged_data)

# 9. Exportar a Excel para revisión visual
write.xlsx(merged_data, file = "datos_disney_mensual.xlsx")

# 10. Mostrar la ruta del archivo
getwd()

