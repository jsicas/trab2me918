# objetos para validacao
banco_teste <- data.frame(
  X1 = (X1 <- 0:3),
  X2 = (X2 <- c(4,5,2,1)),
  X3 = (X3 <- X2),
  Y = 1 + 2*X1 + 2*X2 + X3
)

model_teste <- ajusta_beta(Y ~ X1 + X2, data=banco_teste)

# testes
test_that('Ajuste de Regressao', {
  # verificacao numerica dos betas
  expect_equal(as.numeric(round(model_teste$betas, 10)),
                   c(1,2,3))

  # verificando falta de dados para ajuste do modelo: p+1 > n
  expect_error(ajusta_beta(Y ~ X1 + X2, data=banco_teste[1:2,]))

  # verificando problemas de posto de X'X
  expect_error(ajusta_beta(Y ~ X1 + X2 + X3, data=banco_teste))
})

test_that('Predicao', {
  # verificando predicao via data.frame
  model <- ajusta_beta(Y ~ X1 + X2, banco_teste)
  new_data <- data.frame(Y = c(10, 2), X1 = c(0, 1), X2 = c(4,6))
  expect_identical(as.numeric(round(predicao(model, new_data)$valores_preditos, 10)), c(13,21))

  # verificando predicao via matrix
  new_data <- as.matrix(new_data)
  expect_identical(as.numeric(round(predicao(model, new_data)$valores_preditos, 10)), c(13,21))
})

test_that('Os gráficos gerados são identicos', {
  # packages necessarios
  # devtools::install_github("MangoTheCat/visualTest")
  library(visualTest)

  grafico_pred(model_teste, file = 'grafico1.png', device = 'png')
  fingerprint1 <- getFingerprint(file = 'grafico1.png')

  grafico_pred(model_teste, file = 'grafico2.png', device = 'png')
  fingerprint2 <- getFingerprint(file = 'grafico2.png')

  expect_equal(fingerprint1, fingerprint2)
})
