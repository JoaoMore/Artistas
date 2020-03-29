library(tidyverse)

load('data/musicas_novo.RData')

# Aplicando a função summary em cada variável numérica de interesse -------

## Por álbuns 
albuns_summarized <- musicas_novo %>%
  filter(album_type == 'album') %>% 
  group_by(artist_name, album_name, nacionalidade) %>% 
  drop_na() %>% 
  .[,c(1,20,24,5:16)] %>% 
  group_modify(~ { # aqui, em cada variavel de cada grupo será aplicada a função summary,
                   # depois, cada linha recebe o nome correspondente ao seu output, 
                   # (min, max, etc)
    .x %>%
      purrr::map_dfc(summary, na.rm = T) %>% 
      mutate(result = c('min','1qt','median','mean','3qt','max'))
  }) %>% 
  ungroup()

albuns_summarized <-  albuns_summarized %>% 
  pivot_wider(values_from = names(albuns_summarized)[4:15],
              names_from = result)

## Por artistas
artistas_summarized <- musicas_novo %>% 
  filter(album_type == 'album') %>% 
  group_by(artist_name, nacionalidade) %>% 
  drop_na() %>% 
  .[,c(1,24,5:16)] %>% 
  group_modify(~ { # aqui, em cada variavel de cada grupo será aplicada a função summary,
    # depois, cada linha recebe o nome correspondente ao seu output, 
    # (min, max, etc)
    .x %>%
      purrr::map_dfc(summary, na.rm = T) %>% 
      mutate(result = c('min','1qt','median','mean','3qt','max'))
  }) %>% 
  ungroup()

artistas_summarized <- artistas_summarized %>% 
  pivot_wider(values_from = names(artistas_summarized)[3:14],
              names_from = result)


save(albuns_summarized, file = 'data/albuns_summarized.RData')
save(artistas_summarized, file = 'data/artistas_summarized.RData')


# Mudando o nome das linhas para usar o dist() ----------------------------

rownames(artistas_summarized) <- artistas_summarized$artist_name

rownames(albuns_summarized) <-  paste(albuns_summarized$artist_name,
                                      albuns_summarized$album_name,
                                      sep = ' - ')