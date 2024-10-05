#' @export

print.modelo_linear <- function(model) {
  cat('Modelo de Regressão Linear Ajustado:\n')
  cat('Fórmula:', deparse(model$call), '\n\n')
  cat('Coeficientes:\n')
  print(model$betas)
  cat('\nValores Preditos:\n')
  print(head(model$preditos, 5))
  cat('\nResíduos:\n')
  print(head(model$residuo, 5))
}
