#' Send county and state tables to Postgres
#'
#' @param county_table or state_table
#'
#' @return Postgres table
#' @export
#'
#' @examples
#' to_postgres(county_table) or to_postgres(state_table)


to_postgres <- function(x,y) {
  # create connection for rda database
  source("W:\\RDA Team\\R\\credentials_source.R")
  con <- connect_to_db("racecounts")

  #STATE TABLE
  state_table <- as.data.frame(state_table)

  # make character vector for field types in postgresql db
  charvect = rep('numeric', dim(state_table)[2])

  # change data type for first two columns
  charvect[1:2] <- "varchar" # first two cols are characters for the geoid and names

  # add names to the character vector
  names(charvect) <- colnames(state_table)

  dbWriteTable(con, c(rc_schema, state_table_name), state_table,
               overwrite = FALSE, row.names = FALSE)

  #comment on table and columns
  comment <- paste0("COMMENT ON TABLE ", rc_schema, ".", state_table_name,  " IS '", indicator, " from ", source, ".';
                                                                        COMMENT ON COLUMN ", rc_schema, ".", state_table_name, ".state_id IS 'State fips';")
  print(comment)
  dbSendQuery(con, comment)

  #COUNTY TABLE
  county_table <- as.data.frame(county_table)

  # make character vector for field types in postgresql db
  charvect = rep('numeric', dim(county_table)[2])

  # change data type for first two columns
  charvect[1:2] <- "varchar" # first two are characters for the geoid and names

  # add names to the character vector
  names(charvect) <- colnames(county_table)

  dbWriteTable(con, c(rc_schema, county_table_name), county_table,
               overwrite = FALSE, row.names = FALSE)

  #comment on table and columns
  comment <- paste0("COMMENT ON TABLE ", rc_schema, ".", county_table_name,  " IS '", indicator, " from ", source, ".';
                                         COMMENT ON COLUMN ", rc_schema, ".", county_table_name, ".county_id IS 'County fips';")
  print(comment)
  dbSendQuery(con, comment)

  dbDisconnect(con)

  return(x)
}
