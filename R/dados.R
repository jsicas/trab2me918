#' @title Banco de Dados Utilizado Para Exemplos
#'
#' @description Banco de dados simulados contendo 4 variáveis e 100 observações.
#'
#' @usage banco_exemplo
#'
#' @format Objeto \code{data.frame} contendo 3 preditores (\eqn{X1}, \eqn{X2} e \eqn{X3})
#' e uma variável resposta (\eqn{Y}). As variáveis foram geradas da seguinte forma:
#' \tabular{l}{
#' \eqn{X1 \sim \mathcal{N}(6, 18^2)}   \cr
#' \eqn{X2 \sim \mathcal{N}(10, 30^2)}  \cr
#' \eqn{X3 \sim Exp(5)}                 \cr
#' \eqn{Y = \frac{2}{3} X1 + \frac{5}{2} X2 + X3 + \varepsilon}
#' }
#' onde \eqn{\varepsilon \sim \mathcal{N}(0, 7^2)}.
#'
#' @examples
#' # Gerando o banco de dados
#' set.seed(282829)
#' banco_exemplo <- data.frame(
#' X1 = X1 <- rnorm(100, 6, 18),
#' X2 = X2 <- rnorm(100, 10, 30),
#' X3 = X3 <- rexp(100, 1/5),
#' Y = 2*X1/3 + 5*X2/2 + X3 + rnorm(100, 0, 7)
#' )
#'
#' head(banco_exemplo, 4)
#' ##           X1        X2         X3          Y
#' ## 1  -8.525470 -4.017784 3.21337366  -5.284408
#' ## 2 -15.536322 -3.521253 3.15884769 -12.411591
#' ## 3   7.884230 17.638062 0.07129624  58.608833
#' ## 4  25.274326 73.224618 2.26803371 204.456216
#'
#' @source Dados gerados internamente para exemplos.
'banco_exemplo'
