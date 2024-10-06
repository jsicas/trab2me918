#' @title Predição para Novos Dados
#'
#' @description É uma função que faz predições em um modelo linear para um conjunto de dados.
#'
#' @usage predicao(model, new_data)
#'
#' @param model um objeto da classe "modelo_linear" cuja predição é desejada.
#'
#' @param new_data conjunto de valores dos novos preditoras, podendo ser um
#' data frame ou uma matriz. Deve conter as suas colunas (preditores) nomeadas
#' com os mesmos nomes das do modelo ajustado. Caso este parâmetro seja mal
#' especificado, isto é, falta de algum preditor utilizado no ajuste, será
#' retornado um erro.
#'
#' @examples
#' modelo <- ajusta_beta(Y ~ X1 + X2 + X3, data = banco_exemplo)
#' predicao(modelo, data.frame(X1 = c(12,15), X2 = c(24,32), X3 = c(8,12)))
#
#' @export

predicao <- function(model, new_data) {
  # exraindo nome dos preditores
  preditores <- strsplit(as.character(model$call)[3], ' \\+ ')[[1]]

  # verificando existência dos preditores
  if (sum(preditores %in% colnames(new_data)) != length(preditores)) stop('Falta preditores em new_data')

  # matriz de delineamento
  X <- cbind(rep(1, nrow(new_data)), as.matrix(new_data[,preditores]))

  # predicao
  pred <- data.frame(X %*% model$betas)
  colnames(pred) <- "valores_preditos"
  return(pred)
}
