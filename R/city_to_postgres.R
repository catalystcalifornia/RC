#' Send city table to Postgres
#'
#' @param city_table
#'
#' @return Postgres table
#' @export
#'
#' @examples
#' to_postgres(city_table)
city_to_postgres <- function(x) {

  # create connection for rda database
  source("W:\\RDA Team\\R\\credentials_source.R")
  con <- connect_to_db("racecounts")

  #CITY TABLE
  city_table <- as.data.frame(city_table)

  # make character vector for field types in postgresql db
  charvect = rep('numeric', dim(city_table)[2])

  # change data type for first two columns
  charvect[1:2] <- "varchar" # first two cols are characters for the geoid and names

  # add names to the character vector
  names(charvect) <- colnames(city_table)

  dbWriteTable(con, c(rc_schema, city_table_name), city_table,
               overwrite = FALSE, row.names = FALSE)

  #comment on table and columns
  comment <- paste0("COMMENT ON TABLE ", rc_schema, ".", city_table_name,  " IS '", indicator, " from ", source, ".';")
  print(comment)
  dbSendQuery(con, comment)
}
