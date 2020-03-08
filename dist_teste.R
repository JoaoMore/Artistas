library(tidyverse)
library(ggdendro)

load('data/musicas.RData')

nacionais <- musicas %>% filter(nacionalidade == 'brasileira') %>% .[,4:14]
estrangeiras <- musicas %>% filter(nacionalidade == 'estrangeira') %>% .[,4:14]

nacionais_dist <- nacionais %>% dist()
estrangeiras_dist <- estrangeiras %>% dist() 

inicial <- Sys.time()

global_dist <- musicas[,4:14] %>% dist()

final <- Sys.time()

(time_elapsed <- final - inicial)

plot(hclust(nacionais[1:100,] %>% dist()))
