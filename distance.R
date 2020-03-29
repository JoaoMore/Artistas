library(tidyverse)

load('data/musicas_novo.RData')
load('data/artistas_summarized.RData')
load('data/albuns_summarized.RData')

estrangeiras <- musicas_novo %>% 
  filter(nacionalidade == 'estrangeira') %>% 
  .$artist_name %>% 
  unique()

brasileiras <- musicas_novo %>% 
  filter(nacionalidade == 'brasileira') %>% 
  .$artist_name %>% 
  unique()

# Função que verifica a nacionalidade 
compare <- function(x,y){
  map2(x, y, ~ 1 - (.x %in% estrangeiras & .y %in% estrangeiras)) %>% unlist()
}



artistas_summarized %>% 
  select_if(is.numeric) %>% 
  dist() %>% 
  as.matrix(labels = TRUE) %>% 
  reshape2::melt(varnames = c('artist_1', 'artist_2'), value.name = 'distance') %>% 
  filter(distance != 0) %>% 
  mutate(diff = compare(artist_1, artist_2))
