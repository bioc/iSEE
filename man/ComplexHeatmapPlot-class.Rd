% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/panel_ComplexHeatmapPlot.R
\docType{methods}
\name{ComplexHeatmapPlot-class}
\alias{ComplexHeatmapPlot-class}
\alias{ComplexHeatmapPlot}
\alias{.cacheCommonInfo,ComplexHeatmapPlot-method}
\alias{.createObservers,ComplexHeatmapPlot-method}
\alias{.defineDataInterface,ComplexHeatmapPlot-method}
\alias{.defineInterface,ComplexHeatmapPlot-method}
\alias{.defineOutput,ComplexHeatmapPlot-method}
\alias{.fullName,ComplexHeatmapPlot-method}
\alias{.generateOutput,ComplexHeatmapPlot-method}
\alias{.hideInterface,ComplexHeatmapPlot-method}
\alias{.multiSelectionResponsive,ComplexHeatmapPlot-method}
\alias{.multiSelectionRestricted,ComplexHeatmapPlot-method}
\alias{.panelColor,ComplexHeatmapPlot-method}
\alias{.refineParameters,ComplexHeatmapPlot-method}
\alias{.renderOutput,ComplexHeatmapPlot-method}
\alias{.exportOutput,ComplexHeatmapPlot-method}
\alias{initialize,ComplexHeatmapPlot-method}
\alias{.definePanelTour,ComplexHeatmapPlot-method}
\alias{[[,ComplexHeatmapPlot-method}
\alias{[[,ComplexHeatmapPlot,ANY,ANY-method}
\alias{[[<-,ComplexHeatmapPlot-method}
\alias{[[<-,ComplexHeatmapPlot,ANY,ANY-method}
\alias{updateObject,ComplexHeatmapPlot-method}
\title{The ComplexHeatmapPlot panel}
\description{
The ComplexHeatmapPlot is a panel class for creating a \linkS4class{Panel} that displays an assay of a \linkS4class{SummarizedExperiment} object as a \code{\link{Heatmap}} with features as rows and samples and columns, respectively.
It provides slots and methods for specifying the features of interest, which assay to display in the main heatmap, any transformations to perform on the data, and which metadata variables to display as row and column heatmap annotations.
}
\section{ComplexHeatmapPlot slot overview}{

The following slots control the rows that are used:
\itemize{
\item \code{CustomRows}, a logical scalar indicating whether the custom list of rows should be used.
If \code{FALSE}, the incoming selection is used instead. Defaults to \code{TRUE}.
\item \code{CustomRowsText}, string containing newline-separated row names.
This specifies which rows of the \linkS4class{SummarizedExperiment} object are to be shown in the heatmap.
If \code{NA}, defaults to the first row name of the SummarizedExperiment.
}

The following slots control the metadata variables that are used:
\itemize{
\item \code{ColumnData}, a character vector specifying columns of the \code{\link{colData}} to show as \code{\link{columnAnnotation}}.
Defaults to \code{character(0)}.
\item \code{RowData}, a character vector specifying columns of the \code{\link{rowData}} to show as \code{\link{rowAnnotation}}.
Defaults to \code{character(0)}.
\item \code{ShowColumnSelection}, a logical vector indicating whether the column selection should be shown as an extra annotation bar.
Defaults to \code{TRUE}.
\item \code{OrderColumnSelection}, a logical vector indicating whether the column selection should be used to order columns in the heatmap.
Defaults to \code{TRUE}.
}

The following slots control the choice of assay values:
\itemize{
\item \code{Assay}, string specifying the name of the assay to use for obtaining expression values.
Defaults to \code{"logcounts"} in \code{\link{getPanelDefault}},
falling back to the first valid assay name (see \code{.cacheCommonInfo} below).
}

The following slots control the clustering of rows:
\itemize{
\item \code{ClusterRows}, a logical scalar indicating whether rows should be clustered by their assay values.
Defaults to \code{FALSE}.
\item \code{ClusterRowsDistance}, string specifying a distance measure to use.
This can be any one of \code{"euclidean"}, \code{"maximum"}, \code{"manhattan"}, \code{"canberra"}, \code{"binary"}, \code{"minkowski"}, \code{"pearson"}, \code{"spearman"}, or \code{"kendall"}.
Defaults to \code{"spearman"}.
\item \code{ClusterRowsMethod}, string specifying a linkage method to use.
This can be any one of \code{"ward.D"}, \code{"ward.D2"}, \code{"single"}, \code{"complete"}, \code{"average"}, \code{"mcquitty"}, \code{"median"}, or \code{"centroid"}.
Defaults to \code{"ward.D2"}.
}

The following control transformations applied to rows:
\itemize{
\item \code{AssayCenterRows} is a logical scalar indicating whether assay values should be centered for each row.
\item \code{AssayScaleRows} is a logical scalar indicating whether assay values should be scaled for each row.
This transformation is only applicable if \code{AssayCenterRows} is \code{TRUE}.
}

The following slots control the color scale:
\itemize{
\item \code{CustomBounds} is logical scale indicating whether the color scale should be constrained by an upper and/or a lower bounds.
\item \code{LowerBound} is a numerical value setting the lower bound of the color scale;
or \code{NA} to disable the lower bound when \code{CustomBounds} is \code{TRUE}.
\item \code{UpperBound} is a numerical value setting the lower bound of the color scale;
or \code{NA} to disable the upper bound when \code{CustomBounds} is \code{TRUE}.
\item \code{DivergentColormap} is a character scalar indicating a 3-color divergent colormap to use when \code{AssayCenterRows} is \code{TRUE}.
}

The following slots refer to general plotting parameters:
\itemize{
\item \code{ShowDimNames}, a character vector specifying the dimensions for which to display names.
This can contain zero or more of \code{"Rows"} and \code{"Columns"}.
Defaults to \code{"Rows"}.
\item \code{NamesRowFontSize}, a numerical value setting the font size of the row names.
\item \code{NamesColumnFontSize}, a numerical value setting the font size of the column names.
\item \code{LegendPosition}, string specifying the position of the legend on the plot.
Defaults to \code{"Bottom"} in \code{\link{getPanelDefault}} but can also be \code{"Right"}.
\item \code{LegendDirection}, string specifying the orientation of the legend on the plot for continuous covariates.
Defaults to \code{"Horizontal"} in \code{\link{getPanelDefault}} but can also be \code{"Vertical"}.
}

The following slots control some aspects of the user interface:
\itemize{
\item \code{DataBoxOpen}, a logical scalar indicating whether the data parameter box should be open.
Defaults to \code{FALSE}.
\item \code{VisualBoxOpen}, a logical scalar indicating whether the visual parameter box should be open.
Defaults to \code{FALSE}.
}

In addition, this class inherits all slots from its parent \linkS4class{Panel} class.
}

\section{Constructor}{

\code{ComplexHeatmapPlot(...)} creates an instance of a ComplexHeatmapPlot class, where any slot and its value can be passed to \code{...} as a named argument.
}

\section{Supported methods}{

In the following code snippets, \code{x} is an instance of a \linkS4class{ComplexHeatmapPlot} class.
Refer to the documentation for each method for more details on the remaining arguments.

For setting up data values:
\itemize{
\item \code{\link{.cacheCommonInfo}(x)} adds a \code{"ComplexHeatmapPlot"} entry containing
\code{valid.assay.names}, a character vector of valid (i.e., non-empty) assay names;
\code{discrete.assay.names}, a character vector of valid assay names with discrete atomic values;
\code{continuous.assay.names}, a character vector of valid assay names with continuous atomic values;
\code{valid.colData.names}, a character vector of names of columns in \code{colData} that are valid;
\code{discrete.colData.names}, a character vector of names for columns in \code{colData} with discrete atomic values;
\code{continuous.colData.names}, a character vector of names of columns in \code{colData} with continuous atomic values;
\code{valid.rowData.names}, a character vector of names of columns in \code{rowData} that are valid;
\code{discrete.rowData.names}, a character vector of names for columns in \code{rowData} with discrete atomic values;
\code{continuous.rowData.names}, a character vector of names of columns in \code{rowData} with continuous atomic values.
Valid assay names are defined as those that are non-empty, i.e., not \code{""};
valid columns in \code{colData} and \code{rowData} are defined as those that contain atomic values.
This will also call the equivalent \linkS4class{Panel} method.
\item \code{\link{.refineParameters}(x, se)} replaces
any \code{NA} value in \code{"Assay"} with the first valid assay name;
and \code{NA} value in \code{"CustomRowsText"} with the first row name.
This will also call the equivalent \linkS4class{Panel} method for further refinements to \code{x}.
If no valid column metadata fields are available, \code{NULL} is returned instead.
}

For defining the interface:
\itemize{
\item \code{\link{.defineInterface}(x, se, select_info)} defines the user interface for manipulating all slots described above and in the parent classes.
TODO
It will also create a data parameter box that can respond to specialized \code{\link{.defineDataInterface}},
and a visual parameter box and a selection parameter box both specific to the \code{ComplexHeatmapPlot} panel.
This will \emph{override} the \linkS4class{Panel} method.
\item \code{\link{.defineDataInterface}(x, se, select_info)} returns a list of interface elements for manipulating all slots described above.
\item \code{\link{.defineOutput}(x)} returns a UI element for a brushable plot.
\item \code{\link{.panelColor}(x)} will return the specified default color for this panel class.
\item \code{\link{.hideInterface}(x, field)} returns a logical scalar indicating whether the interface element corresponding to \code{field} should be hidden.
This returns \code{TRUE} for the selection history (\code{"SelectionHistory"}),
otherwise it dispatches to the \linkS4class{Panel} method.
}

For generating the output:
\itemize{
\item \code{\link{.generateOutput}(x, se, all_memory, all_contents)} returns a list containing \code{plot}, a \link{Heatmap} object;
\code{commands}, a list of character vector containing the R commands required to generate \code{contents} and \code{plot};
and \code{contents} and \code{varname}, both set to \code{NULL} as this is not a transmitting panel.
\item \code{\link{.exportOutput}(x, se, all_memory, all_contents)} will create a PDF file containing the current plot, and return a string containing the path to that PDF.
This assumes that the \code{plot} field returned by \code{\link{.generateOutput}} is a \link{Heatmap} object.
}

For monitoring reactive expressions:
\itemize{
\item \code{\link{.createObservers}(x, se, input, session, pObjects, rObjects)} sets up observers for all slots described above and in the parent classes.
This will also call the equivalent \linkS4class{Panel} method.
\item \code{\link{.renderOutput}(x, se, output, pObjects, rObjects)} will add a rendered plot element to \code{output}.
The reactive expression will add the contents of the plot to \code{pObjects$contents} and the relevant commands to \code{pObjects$commands}.
This will also call the equivalent \linkS4class{Panel} method to render the panel information text boxes.
}

For defining the panel name:
\itemize{
\item \code{\link{.fullName}(x)} will return \code{"Complex heatmap"}.
}

For documentation:
\itemize{
\item \code{\link{.definePanelTour}(x)} returns an data.frame containing a panel-specific tour.
}
}

\examples{
#################
# For end-users #
#################

x <- ComplexHeatmapPlot()
x[["ShowDimNames"]]
x[["ShowDimNames"]] <- c("Rows", "Columns")

##################
# For developers #
##################

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

old_cd <- colData(sce)
colData(sce) <- NULL

# Spits out a NULL and a warning if there is nothing to plot.
sce0 <- .cacheCommonInfo(x, sce)
.refineParameters(x, sce0)

# Replaces the default with something sensible.
colData(sce) <- old_cd
sce0 <- .cacheCommonInfo(x, sce)
.refineParameters(x, sce0)

}
\seealso{
\linkS4class{Panel}, for the immediate parent class.
}
\author{
Kevin Rue-Albrecht
}
