#' Constants
#'
#' Constant values used throughout iSEE panels and extensions.
#' 
#' @section Panel slot names:
#' \describe{
#' \item{\code{.dataParamBoxOpen}}{Name of slot that indicates whether the 'Data parameter' box is open.}
#' \item{\code{.multiSelectHistory}}{Name of slot that stores the list of saved selections.}
#' \item{\code{.organizationHeight}}{Name of slot that stores the panel height.}
#' \item{\code{.organizationWidth}}{Name of slot that stores the panel width.}
#' }
#' 
#' @section Multiple selection parameters:
#' \describe{
#' \item{\code{.noSelection}}{Value displayed in the absence of selection.}
#' }
#'
#' @author Kevin Rue-Albrecht
#' 
#' @name constants
#' @aliases .dataParamBoxOpen
#' .multiSelectHistory
#' .noSelection
#' .organizationHeight
#' .organizationWidth
NULL

# Point colouring parameters. ----

.colorByNothingTitle <- "None"
.colorByColDataTitle <- "Column data"
.colorByRowDataTitle <- "Row data"
.colorByFeatNameTitle <- "Feature name"
.colorBySampNameTitle <- "Sample name"
.colorByColSelectionsTitle <- "Column selection"
.colorByRowSelectionsTitle <- "Row selection"

# Point shaping parameters. ----

.shapeByNothingTitle <- "None"
.shapeByColDataTitle <- "Column data"
.shapeByRowDataTitle <- "Row data"

# Point sizing parameters. ----

.sizeByNothingTitle <- "None"
.sizeByColDataTitle <- "Column data"
.sizeByRowDataTitle <- "Row data"

# Faceting parameters. ----

.facetByNothingTitle <- "None"
.facetByRowDataTitle <- "Row data"
.facetByColDataTitle <- "Column data"
.facetByRowSelectionsTitle <- "Row selection"
.facetByColSelectionsTitle <- "Column selection"

# Multiple selection parameters. ---

.multiSelectSave <- "INTERNAL_MultiSelectSave"
.multiSelectDelete <- "INTERNAL_MultiSelectDelete"


#' @export
.noSelection <- "---" # imported by e.g. iSEEu::AggregatedDotPlot
.customSelection <- "Custom ..."

# Zooming parameters. ----

.zoomClick <- "INTERNAL_ZoomClick"

# Lasso parameters. ----

.lassoClick <- "INTERNAL_LassoClick"

# Brush parameters. ----

.brushField <- "Brush"

# Button parameters ----

.buttonUpToDateLabel <- "Up to date"
.buttonEmptyHistoryLabel <- "No history"
.buttonDeleteLabel <- "Delete"
.buttonNoSelectionLabel <- "No selection"
.buttonSaveLabel <- "Save"

.dimnamesModalOpen <- "INTERNAL_DimNamesEdit"

# Other plot parameters. ----

.visualParamChoiceColorTitle <- "Color"
.visualParamChoiceShapeTitle <- "Shape"
.visualParamChoiceSizeTitle <- "Size"
.visualParamChoicePointTitle <- "Point"
.visualParamChoiceFacetTitle <- "Facet"
.visualParamChoiceTextTitle <- "Text"
.visualParamChoiceOtherTitle <- "Other"
.visualParamChoiceMetadataTitle <- "Annotations"
.visualParamChoiceLabelsTitle <- "Labels"
.visualParamChoiceTransformTitle <- "Transform"
.visualParamChoiceLegendTitle <- "Legends"

.showNamesRowTitle <- "Rows"
.showNamesColumnTitle <- "Columns"

.plotLegendRightTitle <- "Right"
.plotLegendBottomTitle <- "Bottom"

.plotLegendHorizontalTitle <- "Horizontal"
.plotLegendVerticalTitle <- "Vertical"

.plotFontSizeAxisTextDefault <- 10
.plotFontSizeAxisTitleDefault <- 12
.plotFontSizeLegendTextDefault <- 9
.plotFontSizeLegendTitleDefault <- 11
.plotFontSizeTitleDefault <- 12

.hoverTooltip <- "INTERNAL_hover_event"
.hoverInfo <- "INTERNAL_hover_info"

# Table parameters. ----

.int_statTableSelected <- "_rows_selected"
.int_statTableSearch <- "_search"
.int_statTableColSearch <- "_search_columns"

.tableExtraInfo <- "INTERNAL_extra_info"

# Tour parameters. ---

.panelHelpTour <- "INTERNAL_help"

# Reactive flags. ---

.flagOutputUpdate <- "INTERNAL_output_update"
.flagSingleSelect <- "INTERNAL_single_select"
.flagMultiSelect <- "INTERNAL_multi_select"
.flagRelinkedSelect <- "INTERNAL_relinked_select"

.panelMultiSelectInfo <- "INTERNAL_PanelMultiSelectInfo"
.panelSelectLinkInfo <- "INTERNAL_PanelSelectLinkInfo"

.flagTableUpdate <- "INTERNAL_table_update"

# Voice parameters ----

.voiceActivePanel <- "voiceActivePanel"

.voiceShowActivePanelInput = "voiceShowActivePanel"

.voiceCreatePanelInput <- "voiceCreatePanel"
.voiceRemovePanelInput <- "voiceRemovePanel"

.voiceControlPanelInput <- "voiceControlPanel"
.voiceColorUsingInput <- "voiceColorUsing"
.voiceColorByInput <- "voiceColorBy"
.voiceReceiveFromInput <- "voiceReceiveFrom"
.voiceSendToInput <- "voiceSendTo"

# Clustering parameters ----

.clusterDistanceEuclidean <- "euclidean"
.clusterDistanceMaximum <- "maximum"
.clusterDistanceManhattan <- "manhattan"
.clusterDistanceCanberra <- "canberra"
.clusterDistanceBinary <- "binary"
.clusterDistanceMinkowski <- "minkowski"
.clusterDistancePearson <- "pearson"
.clusterDistanceSpearman <- "spearman"
.clusterDistanceKendall <- "kendall"

.clusterMethodWardD <- "ward.D"
.clusterMethodWardD2 <- "ward.D2"
.clusterMethodSingle <- "single"
.clusterMethodComplete <- "complete"
.clusterMethodAverage <- "average"
.clusterMethodMcquitty <- "mcquitty"
.clusterMethodMedian <- "median"
.clusterMethodCentroid <- "centroid"

# .heatMapCenteredColormap colormaps ----

.colormapPurpleBlackYellow <- "purple < black < yellow"
.colormapBlueWhiteOrange <- "blue < white < orange"
.colormapBlueWhiteRed <- "blue < white < red"
.colormapGreenWhiteRed <- "green < black < red"

# Versioning information ---

#' @importFrom utils packageVersion
.latest_version <- list(iSEE=packageVersion("iSEE"))
