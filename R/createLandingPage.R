#' Create a landing page
#'
#' Define a function to create a landing page in which users can specify or upload \link{SummarizedExperiment} objects.
#'
#' @param seUI Function that accepts a single \code{id} argument and returns a UI element for specifying the SummarizedExperiment.
#' @param seLoad Function that accepts the input value of the UI element from \code{seUI}
#' and returns a \linkS4class{SummarizedExperiment} object.
#' @param initUI Function that accepts a single \code{id} argument and returns a UI element for specifying the initial state.
#' @param initLoad Function that accepts the input value of the UI element from \code{initUI}
#' and returns a list of \linkS4class{Panel}s.
#' @param requireButton Logical scalar indicating whether the app should require an explicit button press to initialize,
#' or if it should initialize upon any modification to the UI element in \code{seUI}.
#'
#' @return A function that generates a landing page upon being passed to \code{\link{iSEE}}
#' as the \code{landingPage} argument.
#'
#' @details
#' By default, this function creates a landing page in which users can upload an RDS file containing a SummarizedExperiment,
#' which is subsequently read by \code{\link{readRDS}} to launch an instance of \code{\link{iSEE}}.
#' However, any source of SummarizedExperiment objects can be used;
#' for example, we can retrieve them from databases by modifying \code{seUI} and \code{seLoad} appropriately.
#'
#' The default landing page also allows users to upload a RDS file containing a list of \linkS4class{Panel}s
#' that specifies the initial state of the \code{\link{iSEE}} instance
#' (to be used as the \code{initial} argument in \code{\link{iSEE}}).
#' Again, any source can be used to create this list if \code{initUI} and \code{initLoad} are modified appropriately.
#'
#' The UI elements for the SummarizedExperiment and the initial state are named \code{"se"} and \code{"initial"} respectively.
#' This can be used in Shiny bookmarking to initialize an \code{\link{iSEE}} in a desired state by simply clicking a link,
#' provided that \code{requireButton=FALSE} so that reactive expressions are immediately triggered upon setting \code{se=} and \code{initial=} in the URL.
#' We do not use bookmarking to set all individual \code{\link{iSEE}} parameters as we will run afoul of URL character limits.
#'
#' @section Defining a custom landing page:
#' We note that \code{createLandingPage} is just a limited wrapper around the landing page API.
#' In \code{\link{iSEE}}, \code{landingPage} can be any function that accepts the following arguments:
#' \itemize{
#' \item \code{FUN}, a function to initialize the \code{\link{iSEE}} observer architecture.
#' This function expects to be passed:
#'   \itemize{
#'   \item \code{SE}, a SummarizedExperiment object.
#'   \item \code{INITIAL}, a list of \linkS4class{Panel} objects describing the initial application state.
#'   If \code{NULL}, the initial state from \code{initial} in the top-level \code{\link{iSEE}} call is used instead.
#'   \item \code{TOUR}, a data.frame containing a tour to be attached to the app - see \code{\link{defaultTour}} for an example.
#'   If \code{NULL} (the default), no tour is added.
#'   \item \code{COLORMAP}, an \linkS4class{ExperimentColorMap} object that defines the colormaps to use in the application.
#'   }
#' \item \code{input}, the Shiny input list.
#' \item \code{output}, the Shiny output list.
#' \item \code{session}, the Shiny session object.
#' }
#'
#' The \code{landingPage} function should define a \code{\link{renderUI}} expression that is assigned to \code{output$allPanels}.
#' This should define a UI that contains all widgets necessary for a user to set up an \code{\link{iSEE}} session interactively.
#' We suggest that all UI elements have IDs prefixed with \code{"initialize_INTERNAL"} to avoid conflicts.
#'
#' The function should also define observers to respond to user interactions with the UI elements.
#' These are typically used to define a SummarizedExperiment object and an input state as a list of \linkS4class{Panel}s;
#' any one of these observers may then call \code{FUN} on those arguments to launch the main \code{\link{iSEE}} instance.
#'
#' Note that, once the main app is launched,
#' the UI elements constructed here are lost and observers will never be called again.
#' There is no explicit \dQuote{unload} mechanism to return to the landing page from the main app,
#' though a browser refresh is usually sufficient.
#'
#' @author Aaron Lun
#' @examples
#' createLandingPage()
#'
#' # Alternative approach, to create a landing page
#' # that opens one of the datasets from the scRNAseq package.
#' library(scRNAseq)
#' all.data <- ls("package:scRNAseq")
#' all.data <- all.data[grep("Data$", all.data)]
#'
#' lpfun <- createLandingPage(
#'     seUI=function(id) selectInput(id, "Dataset:", choices=all.data),
#'     seLoad=function(x) get(x, as.environment("package:scRNAseq"))()
#' )
#'
#' app <- iSEE(landingPage=lpfun)
#' if (interactive()) {
#'   shiny::runApp(app, port=1234)
#' }
#'
#' @export
#' @importFrom shiny showNotification fileInput HTML observeEvent textInput actionButton
#' @importFrom shinyjs hidden
createLandingPage <- function(seUI=NULL, seLoad=NULL, initUI=NULL, initLoad=NULL, requireButton=TRUE) {
    if (is.null(seUI)) {
        seUI <- function(id) fileInput(id, "SummarizedExperiment RDS file:", multiple = FALSE)
    }
    if (is.null(seLoad)) {
        seLoad <- function(x) readRDS(x$datapath)
    }
    if (is.null(initUI)) {
        initUI <- function(id) fileInput(id, "Initial state RDS file:", multiple=FALSE)
    }
    if (is.null(initLoad)) {
        initLoad <- function(x) readRDS(x$datapath)
    }
    force(requireButton)

    function (FUN, input, output, session) {
        # nocov start
        output$allPanels <- renderUI({
            tagList(
               seUI(.initializeSE),
               initUI(.initializeInitial),
               if (requireButton) actionButton(.initializeLaunch, label="Launch", style=.actionbutton_biocstyle)
            )
        })
        # nocov end

        target <- if (requireButton) .initializeLaunch else .initializeSE

        # nocov start
        observeEvent(input[[target]], {
            se2 <- try(seLoad(input[[.initializeSE]]))
            if (is(se2, "try-error")) {
                showNotification("invalid SummarizedExperiment supplied", type="error")
            } else {
                init <- try(initLoad(input[[.initializeInitial]]))
                if (is(init, "try-error")) {
                    showNotification("invalid initial state supplied", type="warning")
                    init <- NULL
                }
                FUN(SE=se2, INITIAL=init)
            }
        }, ignoreNULL=TRUE, ignoreInit=TRUE)
        # nocov end

        invisible(NULL)
    }
}

# Using the same names as iSEE() for convenience.
.initializeSE <- "se"
.initializeInitial <- "initial"
.initializeLaunch <- "iSEE_INTERNAL_launch_init"
