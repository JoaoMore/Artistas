library(tidyverse)

load('data/musicas_novo.RData')
load('data/artistas_summarized.RData')
load('data/albuns_summarized.RData')


nac <- musicas_novo %>% 
  select(artist_name, nacionalidade) %>% 
  distinct()

# Função que verifica se o par de artistas tem a mesma nacionalidade ou não
compare <- function(x,y){
  map2(x, y, ~ identical(.x,.y)) %>% unlist()
}


# funcao que retorna a artista mais próxima -------------------------------

artist.distance <- function(name, difference = FALSE, reverse = FALSE) {
  testex %>% 
    filter(artist_1 == name & diff == difference) %>% 
    arrange((-1)^(reverse)*distance) %>% 
    .$artist_2 %>% 
    .[1]
}

artistas_summarized %>% 
  select_if(is.numeric) %>% 
  dist() %>% 
  as.matrix(labels = TRUE) %>% 
  reshape2::melt(varnames = c('artist_1', 'artist_2'), value.name = 'distance') %>% 
  filter(distance != 0) %>% 
  left_join(., nac, by = c('artist_1' = 'artist_name')) %>% 
  left_join(., nac, by = c('artist_2' = 'artist_name')) %>% 
  rename(nac_1 = nacionalidade.x, nac_2 = nacionalidade.y) %>% 
  mutate(diff = compare(nac_1,nac_2))


albuns_summarized %>% 
  select_if(is.numeric) %>% 
  dist() %>% 
  as.matrix(labels = TRUE) %>% 
  reshape2::melt(varnames = c('artist_album_1','artist_album_2'),
                 value.name = 'distance') %>% 
  filter(distance != 0) %>% 
  extract(artist_album_1, c('artist_1','album_1'), "^([^-]+) - (.+)") %>% 
  extract(artist_album_2, c('artist_2','album_2'), "^([^-]+) - (.+)")
