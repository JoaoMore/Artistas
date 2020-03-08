library(tidyverse)

load('data/musicas.RData')

# Aplicando a função summary em cada variável numérica de interesse -------

## Por álbuns 
albuns_summarized <- musicas %>% 
  group_by(artist_name, album_name) %>% 
  .[,c(1,19,4:14)] %>% 
  drop_na() %>% 
  group_modify(~ { # aqui, em cada variavel de cada grupo será aplicada a função summary,
                   # depois, cada linha recebe o nome correspondente ao seu output, 
                   # (min, max, etc)
    .x %>%
      purrr::map_dfc(summary, na.rm = T) %>% 
      .[1:6] %>% 
      mutate(result = c('min','1qt','median','mean','3qt','max'))
  })

albuns_summarized %>% 
  pivot_wider(values_from = names(albuns_summarized)[3:8],
              names_from = result)

## Por artistas
artistas_summarized <- musicas %>% 
  group_by(artist_name) %>% 
  .[,c(1,4:14)] %>% 
  drop_na() %>% 
  group_modify(~ { # aqui, em cada variavel de cada grupo será aplicada a função summary,
    # depois, cada linha recebe o nome correspondente ao seu output, 
    # (min, max, etc)
    .x %>%
      purrr::map_dfc(summary, na.rm = T) %>% 
      .[1:6] %>% 
      mutate(result = c('min','1qt','median','mean','3qt','max'))
  }) %>% 
  ungroup()

artistas_summarized %>% 
  pivot_wider(values_from = names(artistas_summarized)[2:7],
              names_from = result)
