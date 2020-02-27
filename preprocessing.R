library(tidyverse)

# Carregando o arquivo com as musicas -------------------------------------

load(file = 'data/musicas.RData')


# Pré-processamento -------------------------------------------------------

names(musicas)

musicas %>% 
  select(-c(artist_id,album_id,album_type,album_images,album_release_date_precision,
           track_id, analysis_url, artists, available_markets, disc_number, 
           duration_ms, track_href, is_local, track_preview_url, type, track_uri, 
           external_urls.spotify))
