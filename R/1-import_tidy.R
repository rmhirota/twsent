
#' Arruma base de tweets
#'
#' @param arquivo_csv Arquivo csv com metadados do Twitter
#' @param path_tidy Pasta em que será salvo o objeto rds com a base arrumada
#'
#' @return cria base tidy em data/
#'
#' @export
tidy_tweets <- function(arquivo_csv, path_tidy = "data") {
  tweets <- data.table::fread(arquivo_csv, colClasses = "character") %>%
    janitor::clean_names() %>%
    dplyr::select(ends_with("id"), created_at, screen_name, starts_with("is"),
           text, hashtags, urls_url, media_url, media_type, status_url,
           account_created_at, verified) %>%
    dplyr::mutate(created_at = lubridate::with_tz(lubridate::as_datetime(created_at), "America/Sao_Paulo"))

  # checa se id é única
  n_idunico <- tweets %>% dplyr::count(status_id) %>% dplyr::filter(n > 1) %>% nrow()
  if (n_idunico > 0) {
    tweets <- tweets %>%
      dplyr::mutate(id = paste(user_id, status_id, sep = "_")) %>%
      dplyr::distinct()
  } else {
    tweets <- tweets %>%
      dplyr::mutate(id = status_id)
  }
  erro <- tweets %>% dplyr::count(id) %>% dplyr::filter(n > 1)
  if (nrow(erro) > 0) {
    cat("Algumas ids estão repetidas e foram filtradas da base.\nAs seguintes ids foram retiradas: \n")
    erro$id %>% paste(sep = "\n") %>% cat()
    tweets <- tweets %>% dplyr::filter(!id %in% erro$id)
  }
  readr::write_rds(tweets, paste0(
    path_tidy,
    stringr::str_remove(
      stringr::str_extract(arquivo_csv, stringr::regex("/.*\\.csv$")), ".csv"), "_tidy.rds"))
}

