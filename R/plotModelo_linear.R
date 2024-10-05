#' @import ggplot2
#'
#' @export

plot.modelo_linear <- function(model) {
  ggplot(data.frame(preditos = model$preditos, residuos = model$residuo),
         aes(x = preditos, y = residuos))+
    geom_point() +
    geom_smooth(formula = y ~ x, method = 'loess', se = FALSE)
}
