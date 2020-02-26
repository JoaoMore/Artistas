# Bibliotecas -------------------------------------------------------------

library(spotifyr)
library(tidyr)
library(dplyr)
library(readr)

# Importação dos dados ----------------------------------------------------

artistas <- read_csv('data/artistas.csv')

artistas <-  artistas %>% 
  pivot_longer(everything(), names_to = 'nacionalidade', values_to = 'nome')

# As credenciais do spotify nao foram definidas aqui por questões de segurança

songlist <- list()
nao_encontrados <- NULL

start.time <- Sys.time()

for (i in 1:nrow(artistas)){
  
  print(paste(artistas$nome[i], i, sep = ' : '))
  
  temp_data <- tryCatch(get_artist_audio_features(as.character(artistas$nome[i])),
                        error = function(e) e)
  
  if(inherits(temp_data, 'error')) {
    nao_encontrados <- c(nao_encontrados, artistas$nome[i])
    next
  }
  
  songlist[[i]] <- temp_data
  
}

final.time <- Sys.time()

final.time - start.time
