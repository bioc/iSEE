% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R
\name{multi-select-generics}
\alias{multi-select-generics}
\alias{.multiSelectionDimension}
\alias{.isBrushable}
\alias{.multiSelectionRestricted}
\alias{.multiSelectionActive}
\alias{.multiSelectionCommands}
\alias{.multiSelectionClear}
\alias{.multiSelectionInvalidated}
\alias{.multiSelectionAvailable}
\alias{.multiSelectionResponsive}
\title{Generics for controlling multiple selections}
\description{
A panel can create a multiple selection on either the rows or columns and transmit this selection to another panel to affect its set of displayed points.
For example, users can brush on a \linkS4class{DotPlot}s to select a set of points, and then the panel can transmit the identities of those points to another panel for highlighting.

This suite of generics controls the behavior of these multiple selections.
In all of the code chunks shown below, \code{x} is assumed to be an instance of the \linkS4class{Panel} class.
}
\section{Possibility of selection}{

\code{.isBrushable(x)} should return a logical specifying whether the panel supports selection using a Shiny brush or lasso waypoints.
The output should be constant for all instances of \code{x} and is used to govern the reporting of multiple selections in the code tracker.
}

\section{Specifying the dimension}{

\code{.multiSelectionDimension(x)} should return a string specifying whether the selection contains rows (\code{"row"}), columns (\code{"column"}) or if the Panel in \code{x} does not perform multiple selections at all (\code{"none"}).
The output should be constant for all instances of \code{x} and is used to govern the interface choices for the selection parameters.
}

\section{Specifying the active selection}{

\code{.multiSelectionActive(x)} should return some structure containing all parameters required to identify all points in the active multiple selection of \code{x}.
For example, the \linkS4class{DotPlot} method for this generic would return the contents of the \code{BrushData} slot, usually a list containing a Shiny brush or lasso waypoints for \linkS4class{DotPlot} classes.
If \code{.multiSelectionActive(x)} returns \code{NULL}, \code{x} is assumed to have no active multiple selection.

The active selection is considered to be the one that can be directly changed by the user, as compared to saved selections that are not modifiable (other than being deleted on a first-in-last-out basis).
This generic is primarily used to bundle up selection parameters to be stored in the \code{SelectionHistory} slot when the user saves the current active selection.
}

\section{Evaluating the selection}{

\code{.multiSelectionCommands(x, index)} is expected to return a character vector of commands to generate a character vector of row or column names in the desired multiple selection of \code{x}.
If \code{index=NA}, the desired selection is the currently active one; developers can assume that \code{.multiSelectionActive(x)} returns a non-\code{NULL} value in this case.
Otherwise, for an integer \code{index}, it refers to the corresponding saved selection in the \code{SelectionHistory}.

The commands will be evaluated in an environment containing:
\itemize{
\item \code{select}, a variable of the same type as returned by \code{\link{.multiSelectionActive}(x)}.
This will contain the active selection if \code{index=NA} and one of the saved selections otherwise.
For example, for \linkS4class{DotPlot}s, \code{select} will be either a Shiny brush or a lasso structure.
\item \code{contents}, some arbitrary content saved by the rendering expression in \code{\link{.renderOutput}(x)}.
This is most often a data.frame but can be anything as long as \code{.multiSelectionCommands} knows how to process it.
For example, a data.frame of coordinates is stored by \linkS4class{DotPlot}s to identify the points selected by a brush/lasso.
\item \code{se}, the \linkS4class{SummarizedExperiment} object containing the current dataset.
}

The output commands are expected to produce a character vector named \code{selected} in the evaluation environment.
All other variables generated by the commands should be prefixed with \code{.} to avoid name clashes.
}

\section{Determining the available points for selection}{

\code{.multiSelectionAvailable(x, contents)} is expected to return an integer scalar specifying the number of points available for selection in the the current instance of the panel \code{x}.
The \code{contents} field in the output of \code{\link{.generateOutput}} is passed to the \code{contents} argument of this generic.

The default method for this generic returns \code{nrow(contents)} for all \linkS4class{Panel} subclasses, assuming that \code{contents} is a data.frame where each row represents a point.
If not, this method needs to be specialized in order to return an accurate total of available points, which is ultimately used to compute the percentage selected in the multiple selection information panels.
}

\section{Destroying selections}{

\code{.multiSelectionClear(x)} should return \code{x} after removing the active selection, i.e., so that nothing is selected.
This is used internally to remove multiple selections that do not make sense after protected parameters have changed.
For example, a brush or lasso made on a PCA plot in \linkS4class{ReducedDimensionPlot}s would not make sense after switching to t-SNE coordinates, so the application will automatically erase those selections to avoid misleading conclusions.
}

\section{Responding to selections}{

These generics control how \code{x} responds to a transmitted multiple selection, not how \code{x} itself transmits selections.

\code{.multiSelectionRestricted(x)} should return a logical scalar indicating whether \code{x}'s displayed contents will be restricted to the selection transmitted from \emph{another panel}.
This is used to determine whether child panels of \code{x} need to be re-rendered when \code{x}'s transmitter changes its multiple selection.
For example, the method for \linkS4class{RowDotPlot}s and \linkS4class{ColumnDotPlot}s would return \code{TRUE} if \code{RowSelectionRestrict=TRUE} or \code{ColumnSelectionRestrict=TRUE}, respectively.
Otherwise, it would be \code{FALSE} as the transmitted selection is only used for aesthetics, not for changing the identity of the displayed points.

\code{.multiSelectionInvalidated(x)} should return a logical scalar indicating whether a transmission of a multiple selection to \code{x} invalidates \code{x}'s own existing selections.
This should only be \code{TRUE} in special circumstances, e.g., if receipt of a new multiple selection causes recalculation of coordinates in a \linkS4class{DotPlot}.

\code{.multiSelectionResponsive(x, dims)} should return a logical scalar indicating whether \code{x} is responsive to an incoming multiple selection on dimensions \code{dims}.
For example, the method for \linkS4class{ComplexHeatmapPlot} would return \code{TRUE} when an incoming selection originates from a row-oriented panel and \code{CustomRows=FALSE}.
Otherwise, it would be \code{FALSE} as the dimension of the transmitted selection is dismissed by the options of the child panel.
}

\author{
Aaron Lun
}
