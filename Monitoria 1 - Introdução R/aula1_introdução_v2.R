#==========================================================================================================
# Aula 1 - R básico
#==========================================================================================================
# Lucas M F Fernandes
# email: Lucasmffernandes@gmail.com 

#Para reproduzir o script passe na função setwd() o caminho da pasta onde o script e o arquivo wage.csv estão localizados. 
#A barra deve ser do tipo: / ou \\
setwd("C:/Users/Lucas/Google Drive/Aulas R/Aula1_introdução")

#==========================================================================================================
# Criando objetos
#==========================================================================================================

#Criando e visualizando o objeto a:
a <- 3

#Criando e visualizando um objeto b:
b <- "ABC"
b

#Descobrindo a classe dos objetos a e b:
class(a)
str(a)

class(b)
str(b)


#==========================================================================================================
# Tipos de dados
#==========================================================================================================

#integer 
2L
class(2L)

#Double  
2.5
typeof(2.5)

#character
"h"
class("h")

#Logical
TRUE
FALSE
class(TRUE)

#Missing Value: (Indica que valor não se aplica)
NA


#==========================================================================================================
# Operadores lógicos/aritméticos
#==========================================================================================================
#Permitem realizar operações matemáticas e lógicas entre os dados


# Operadores lógicos ------------------------------------------------------

# Igualdade:
1 == 2
2 == 2

# Negação: (Inverte o resultado)
!(1 == 2)

# Desigualdade:
1 != 2

# Operadores maior/menor
1 > 2
1 < 2

1 >= 2
1 <= 2

# Operadores "e"/"ou":

#Operador "e":  

# Verifica se as duas condições foram satisfeitas. Se ambas são verdadeiras, retorna um valor verdadeiro:
(1 < 2) & (1 > 0)
# Se pelo menos uma das condições é falsa, retorna falso:
(1 < 2) & (1 < 0)

#Operador "ou"

# Verifica se pelo menos uma das condições foi satisfeita:
(1 < 2) | (1 < 0)

# Operador "contém":
2 %in% c(1,2,3)
2 %in% c(3,4,5)

# Operadores aritméticos --------------------------------------------------

1 + 2
1 - 2
2 * 5
10 / 5

#Potência:
5**2 
#ou 
5^2

#Raiz:
sqrt(9)
#ou
9^(1/2)

# Log (Por padrão calcula o log na base "e". Argumento base, permite mudar a base do log)
log(1)
log(10,base = 10)

# Exponencial:
exp(1)


#==========================================================================================================
# Criando e manipulando vetores
#==========================================================================================================

# Vetores são conjuntos de dados de uma dimensão e do mesmo tipo/classe. Uma das formas de criar um vetor é utilizando a função c():

#Criando e visualizando um vetor numérico, que consiste nas vendas do 1 semestre de uma loja
venda.1sem <- c(2000,3000,4000,2300,2200,4200,3200,1900,2200,1000,3000,2100,1200,900)
venda.1sem

# Verificando se objeto é um vetor:
is.vector(venda.1sem)


#Criando e visualizando um vetor com vendas do 2 semestre
venda.2sem <- c(1000,3500,2000,1300,1200,2900,1200,4000,3200,1900,2200,1000,3000,2100)
venda.2sem


#Criando um vetor com as localidades das lojas
cidade <- c("Rio de Janeiro","Santos","Fortaleza","Santos","Fortaleza","Santos","Santos","Rio de Janeiro","Rio de Janeiro","Santos","Fortaleza","Santos","Fortaleza","Santos")
cidade

#Calculando uma estimativa da venda por mês no 1 semestre
venda.1sem / 6


#Calculando a venda no ano inteiro
venda.1sem + venda.2sem

# Calculando medidas de tendencia central:
mean(venda.1sem)  # Média 
median(venda.1sem) # Mediana
table(venda.1sem) # Moda
quantile(venda.1sem) # Quartil

# Calculando medidas de dispersão:
var(venda.1sem) # Variância
sd(venda.1sem)  # Desvio Padrão

# Para entender uma função e ser argumentos, podemos utilizar a função help():
help(mean)

#Para acessar os valores utilizamos o []. Acessando o valor da loja que se encontra na 2a posição do vetor venda.1sem:
venda.1sem[2]

#Acesando valores das lojas que se encontram nas posições 2,6 e 8:
venda.1sem[c(2,6,8)]

#Acessando valores entre as posiÇões 2 e 6:
venda.1sem[2:6]


#==========================================================================================================
# Criando e manipulando DataFrames/tibbles
#==========================================================================================================

# Data frames são conjuntos de vetores que formam uma tabela. 

#Ativando o pacote tibble
#install.packages("tibble")
library(tibble)
help(tibble)

#Criando um tibble e visualizando o objeto
base <- tibble(
  venda1 = venda.1sem,
  venda2 = venda.2sem,
  município = cidade,
  anos = c(10,5,3,2,1,8,9,6,5,4,4,3,4,10) 
)


#Acrescentando uma variável: 0 - Nao e 1 - Sim
base["capital"] <- c(1,0,1,0,1,0,0,1,1,0,1,0,1,0)

#Acrescentando a variável porte
base["porte"] <- c("Grande", "Pequeno", "Medio", "Pequeno", "Grande", "Grande", "Pequeno","Grande", "Pequeno", "Medio","Pequeno", "Medio","Pequeno", "Medio")

#Criando a variável venda
base["venda"] <- base$venda1 + base$venda2

#Usando a função summary e str:
summary(base)
str(base)

#Transformando a variável capital em um fator
base["capital"] <- factor(base$capital,labels=c("Nao","Sim"))

summary(base)

# Para acessar valores em um tibble utilizamos o [], assim como vimos nos vetores. 
# A diferença é que um dataframe possui duas dimensões: linhas e colunas.
# O operador agora recebe: [ Identificador da linha , Identificador da coluna ]

base[,1] # retorna um tibble que só possui uma coluna (venda)
base[,"venda1"] # retorna um tibble que só possui uma coluna (venda)


#Acessando somente os dados da loja 5
base[5,]


#Acessando a venda no segundo semestre da loja 5
base[5,2]


# Operador $:
base$venda1 # retorna o vetor venda que se encontra no tibble base
base$venda2[5]

#Filtrando base, selecionando apenas lojas de grande porte:
condicao <- base["porte"] == "Grande" 
condicao
base[condicao,]

# Selecionando lojas que venderam mais que 2000 no primeiro semestre:
condicao <- base["venda1"] > 2000
condicao
base[condicao,]



#==========================================================================================================
# Criando e manipulando listas
#==========================================================================================================

lista <- list(
  c(1,2,3),
  base,
  1L
)

#Visualizando a lista criada
lista

#Acessando os elementos da lista
lista[[1]]

#Acessando o 3 coluna da base
lista[[2]][3]


#==========================================================================================================
# Estruturas de condição 
#==========================================================================================================


# if(...) -----------------------------------------------------------------

x <- 3600

if (x > 5000){
  print("X é maior que 5000")
} else {
  print("X é menor que 5000")
}


#É possível encadear vários else e diferentes condições:

if(x < 3000){
  print("X é menor que 3000")
} else if(x >=3000 & x<5000){
  print("X esta entre 3000 e 5000")
} else{
  print("X é maior que 5000")
}



# ifelse(...) -------------------------------------------------------------

ifelse(x > 5000, print("X é maior que 5000"), print("X é menor que 5000"))

#==========================================================================================================
# Estruturas de repetição (LOOPS)
#==========================================================================================================


# for(...) loops ----------------------------------------------------------

#Voltando ao nosso tibble, suponha que queremos criar um vetor que indique se o total de vendas foi maior que 3000:
maior_5000 = NULL

for(i in 1:length(venda.1sem)){
  maior_5000[i] <- venda.1sem[i] > 3000
  print(i)
}

maior_5000


# while(...) loops --------------------------------------------------------

# While loops executam até que uma condição seja satisfeita. No loop abaixo, a condição é (x < 5), ou seja,
# enquanto x for menor que 5 continue rodando. Ao atingir 5, o loop irá cessar.
x <- 1

while(x < 100){
  x <- x + 1
  print(x)
}


#==========================================================================================================
# Criando funções
#==========================================================================================================

#Suponha que desejamos criar uma função que soma dois números
minha_soma <- function(x,y){
  valor <- x + y
  return(valor)
}

#Executando a função criada
minha_soma(2,4)






