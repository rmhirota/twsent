% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/3-sent.R
\name{pos_neg_hora}
\alias{pos_neg_hora}
\title{Cria gráfico com total de tweets positivos e negativos por hora}
\usage{
pos_neg_hora(tweets_fim, tema)
}
\arguments{
\item{tweets_fim}{base agrupada de tweets criada usando agrupa_tw_sent}

\item{tema}{string indicando palavrs(s)-chave utilizada(s) na coleta dos tweets}
}
\value{
gráfico ggplot com a quantidade de tweets positivos e tweets negativos por hora
}
\description{
Cria gráfico com total de tweets positivos e negativos por hora
}
