library(tidyverse)

# Definindo funções -------------------------------------------------------

`%notin%` <- Negate(`%in%`)

# Carregando o arquivo com as musicas -------------------------------------

load(file = 'data/musicas.RData')

# Pré-processamento -------------------------------------------------------

# selecionando as variaveis de interesse e removendo um artista aleatório que apareceu (Claude Debussy) (?!?!?!)
musicas_novo <- musicas %>% 
  select(-c(artist_id,album_id,album_images,album_release_date_precision,
           track_id, analysis_url, artists, available_markets, disc_number, 
           duration_ms, track_href, is_local, track_preview_url, type, track_uri, 
           external_urls.spotify)) %>% 
  filter(artist_name %notin% c("Y'man Dog",'Claude Debussy'))

# capitalizando os nomes das musicas para poder remover as duplicatas por album
musicas_novo <- musicas_novo %>% 
  mutate(track_name = tools::toTitleCase(track_name)) 

musicas_novo <- musicas_novo %>% 
  distinct_at(.vars = vars(artist_name, track_name, album_name),
              .keep_all = TRUE)#, .keep_all = TRUE)

save(musicas_novo, file = 'data/musicas_novo.RData')



