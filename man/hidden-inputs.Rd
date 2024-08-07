% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interface_hidden.R
\name{hidden-inputs}
\alias{hidden-inputs}
\alias{.selectInputHidden}
\title{Hidden interface elements}
\usage{
.selectInputHidden(x, field, ...)
}
\arguments{
\item{x}{An instance of a \linkS4class{Panel} class.}

\item{field}{String specifying the name of the suffix of the ID of the interface element.}

\item{...}{Further arguments to pass to the Shiny function responsible for producing the interface element.}
}
\value{
The output of \code{FUN(id, ..)} is returned where \code{id} is defined by concatenating \code{\link{.getEncodedName}(x)} and \code{field} (separated by an underscore).
}
\description{
Returns an interface element with or without the CSS class \code{shinyjs-hide}, depending on whether the element is hidden based on \code{\link{.hideInterface}}.
This allows panels to hide interface elements that are provided by parent classes but are not needed in the subclass.
}
\details{
\code{.selectInputHidden(x, field, ...)} produces a Shiny \code{\link{selectInput}} element that will be hidden if \code{.hideInterface(x)} is \code{TRUE}.
}
\examples{
.selectInputHidden(ComplexHeatmapPlot(), "SelectionHistory",
  choices = c(1, 2, 3), label = "Saved selection (hidden)")
  
.selectInputHidden(ReducedDimensionPlot(), "Type",
  choices = c("UMAP", "PCA"), label = "Reduced dimension type (hidden)")
}
\author{
Kevin Rue-Albrecht
}
