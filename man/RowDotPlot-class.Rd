% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/family_RowDotPlot.R
\docType{methods}
\name{RowDotPlot-class}
\alias{RowDotPlot-class}
\alias{initialize,RowDotPlot-method}
\alias{.cacheCommonInfo,RowDotPlot-method}
\alias{.refineParameters,RowDotPlot-method}
\alias{.defineInterface,RowDotPlot-method}
\alias{.createObservers,RowDotPlot-method}
\alias{.hideInterface,RowDotPlot-method}
\alias{.multiSelectionDimension,RowDotPlot-method}
\title{Row dot plot panel family}
\description{
The RowDotPlot is a virtual class where each row in the \linkS4class{SummarizedExperiment} is represented by a point (\dQuote{dot}) in a brushable plot.
It provides slots and methods to control various aesthetics of the dots and to store the brush or lasso selection.
}
\section{Slot overview}{

The following slots control coloring of the points:
\itemize{
\item \code{ColorByRowData}, a string specifying the \code{\link{rowData}} field for controlling point color,
if \code{ColorBy="Row data"} (see the \linkS4class{Panel} class).
Defaults to the first field.
\item \code{ColorBySampNameAssay}, a string specifying the assay of the SummarizedExperiment object containing values to use for coloring,
if \code{ColorBy="Sample name"}.
Defaults to the name of the first assay.
\item \code{ColorByFeatNameColor}, a string specifying the color to use for coloring an individual sample on the plot,
if \code{ColorBy="Feature name"}.
Defaults to \code{"red"}.
}

The following slots control other metadata-related aesthetic aspects of the points:
\itemize{
\item \code{ShapeByRowData}, a string specifying the \code{\link{rowData}} field for controlling point shape,
if \code{ShapeBy="Row data"} (see the \linkS4class{Panel} class).
The specified field should contain categorical values; defaults to the first such field.
\item \code{SizeByRowData}, a string specifying the \code{\link{rowData}} field for controlling point size,
if \code{SizeBy="Row data"} (see the \linkS4class{Panel} class).
The specified field should contain continuous values; defaults to the first such field.
}
}

\section{Contract description}{

The RowDotPlot will provide user interface elements to change all above slots and in its parent classes \linkS4class{DotPlot} and \linkS4class{Panel}.
It will also provide observers to respond to any input changes in those slots and trigger rerendering of the output.

Subclasses are expected to implement methods for (at least) \code{\link{.generateDotPlotData}}.
}

\section{Supported methods}{

In the following code snippets, \code{x} is an instance of a \linkS4class{RowDotPlot} class.
Refer to the documentation for each method for more details on the remaining arguments.

For setting up data values:
\itemize{
\item \code{\link{.cacheCommonInfo}(x)} adds a \code{"RowDotPlot"} entry containing \code{valid.colData.names}, a character vector of valid column data names (i.e., containing atomic values); \code{discrete.colData.names}, a character vector of names for discrete columns; and \code{continuous.colData.names}, a character vector of names of continuous columns.
This will also call the equivalent \linkS4class{DotPlot} method.
\item \code{\link{.refineParameters}(x, se)} replaces \code{NA} values in \code{ColorByFeatAssay} with the first valid assay name in \code{se}.
This will also call the equivalent \linkS4class{DotPlot} method.
}

For defining the interface:
\itemize{
\item \code{\link{.defineInterface}(x, se, select_info)} defines the user interface for manipulating all slots in the \linkS4class{RowDotPlot}.
It will also create a data parameter box that can respond to specialized \code{\link{.defineDataInterface}}.
This will \emph{override} the \linkS4class{Panel} method.
\item \code{\link{.hideInterface}(x, field)} returns a logical scalar indicating whether the interface element corresponding to \code{field} should be hidden.
This returns \code{TRUE} for row selection parameters (\code{"SelectRowSource"}, \code{"SelectRowType"} and \code{"SelectRowSaved"}),
otherwise it dispatches to the \linkS4class{Panel} method.
}

For monitoring reactive expressions:
\itemize{
\item \code{\link{.createObservers}(x, se, input, session, pObjects, rObjects)} sets up observers for all slots in the \linkS4class{RowDotPlot}.
This will also call the equivalent \linkS4class{DotPlot} method.
}

For controlling selections:
\itemize{
\item \code{\link{.multiSelectionDimension}(x)} returns \code{"column"} to indicate that a column selection is being transmitted.
}

Unless explicitly specialized above, all methods from the parent classes \linkS4class{DotPlot} and \linkS4class{Panel} are also available.
}

\seealso{
\linkS4class{DotPlot}, for the immediate parent class that contains the actual slot definitions.
}
\author{
Aaron Lun
}