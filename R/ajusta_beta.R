#' @title Ajuste do Modelo de Regressão Linear
#'
#' @importFrom Matrix rankMatrix
#'
#' @description
#' Calcula os valores dos coeficientes (betas) de uma regressão linear com variáveis preditoras numéricas.
#'
#' @usage ajusta_beta(formula, data)
#'
#' @param formula Recebe a fórmula que será utilizada no ajuste do modelo.
#' Deve ser escrita da seguinte maneira:
#' `Variável Resposta ~ Variáveis Preditoras`.
#' Exemplo: se `Y` é a variável resposta e `X1`, `X2` e `X3` são as variáveis
#' preditoras, então `formula = Y ~ X1 + X2 + X3`.
#'
#' @param data Um objeto contendo o banco de dados que será utilizado no ajuste.
#'
#' @examples
#' ajusta_beta(Y ~ X1 + X2 + X3, data = banco_exemplo)
#
#' @export

ajusta_beta <- function(formula, data) {
  # matriz de delineamento e manipulacao do objeto formula
  Y <- as.matrix(data[as.character(formula)[2]])
  preditores <- strsplit(as.character(formula)[3], ' \\+ ')[[1]]
  X <- cbind(rep(1, nrow(data)), as.matrix(data[preditores]))
  xtx <- t(X) %*% X

  # verificacoes
  if (ncol(X) > nrow(X)) stop('Falta dados para ajustar o modelo, p + 1 > n.')
  if (rankMatrix(xtx)[1] != ncol(X)) stop('Posto de X incompleto.')

  # calculo do beta
  betas <- solve(xtx) %*% t(X) %*% Y  # beta = (X'X)^{-1}X'Y
  rownames(betas) <- c('(intercepto)', rownames(betas)[2:nrow(betas)])
  colnames(betas) <- 'betas'

  preditos <- unname(X %*% betas)  # valores preditos

  residuo <- unname(Y - preditos)  # calculando residuo ( MY = Y - X \beta )

  return(structure(list('call'=formula, 'betas'=betas,
              'preditos'=preditos, 'residuo'=residuo,
              'Y'=Y), class = 'modelo_linear'))
}
