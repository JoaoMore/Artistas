library(tidyverse)
library(ggdendro)

load('data/musicas_novo.RData')

nacionais <- musicas_novo %>% filter(nacionalidade == 'brasileira') %>% .[,5:14]
estrangeiras <- musicas_novo %>% filter(nacionalidade == 'estrangeira') %>% .[,4:14]





d <- artistas_summarized[,c(1,3:74)] %>% dist() %>% as.matrix(labels = TRUE)
colnames(d) <- rownames(d) <- artistas_summarized[['artist_name']]

reshape::melt(d)
