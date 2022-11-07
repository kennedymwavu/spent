#' POST server module
#'
#' @param id module id
#' @param post_url POST url
#'
#' @return NULL
#' @noRd
analysis_server <- function(id, post_url) {
  moduleServer(
    id = id, 
    module = function(input, output, session) {
      
    }
  )
}
