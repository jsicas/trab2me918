#' @title Gráfico de Valores Observados e Preditos
#'
#' @description
#' Plota gráfico de valores preditos vs. valores obervados.
#'
#' @usage grafico_pred(model, new_data = NULL, file=NULL, width=7, height=7, device = 'pdf')
#'
#' @param model um objeto de modelo da classe "modelo_linear" cuja predição é desejada.
#' @param new_data argumento opcional com conjunto de preditoras para usar no gráfico.
#' @param file argumento opcional com o caminho de onde se quer salvar o gráfico.
#' @param width argumento opcional com a largura do gráfico em polegadas.
#' @param height argumento opcional com a altura do gráfico em polegadas.
#' @param device argumento opcional com o formato em que o gráfico deve ser salvo.
#'
#' @examples
#' modelo <- ajusta_beta(Y ~ X1 + X2 + X3, data = banco_exemplo)
#' grafico_pred(modelo)
#'
#' new_data <- data.frame(
#'               X1 = c(-8.5, 10),
#'               X2 = c(-4.0, -3.5),
#'               X3 = c(3.2, 4))
#' grafico_pred(modelo, new_data)
#
#' @import ggplot2
#'
#' @export

grafico_pred <- function(model, new_data=NULL, file=NULL,
                         width=7, height=7, device='pdf') {
  grafico <- ggplot(aes(x = preditos, y = Y),
                    data = data.frame(model[c('Y', 'preditos')])) +
    geom_point(size = 2, col = 'blue') +
    labs(x = 'Valores Preditos', y = 'Valores Observados') +
    theme_bw()

  if (!is.null(new_data)) {
    predicao_val <- predicao(model, new_data)
    grafico <- grafico +
    geom_vline(xintercept = predicao_val[[1]], linetype = 'dashed',
               linewidth = 0.8, color = '#7f7f7f')
  }

  # salva se configurado
  if (!(is.null(file))) ggsave(file, grafico, device = device, width = width,
                               height = height)

  # printa gráfico
  return(grafico)
}
