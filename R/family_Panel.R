#' The Panel virtual class
#'
#' The Panel is a virtual base class for all \pkg{iSEE} panels.
#' It provides slots and methods to control the height and width of each panel,
#' as well as to control the choice of transmitting panels from which to receive a selection.
#'
#' @section Slot overview:
#' The following slots are relevant to panel organization:
#' \itemize{
#' \item \code{PanelId}, an integer scalar specifying the identifier for the panel.
#' This should be unique across panels of the same concrete class.
#' \item \code{PanelWidth}, an integer scalar specifying the width of the panel.
#' Bootstrap coordinates are used so this value should lie between 2 and 12; defaults to 4.
#' \item \code{PanelHeight}, an integer scalar specifying the height of the panel in pixels.
#' This is expected to lie between 400 and 1000; defaults to 500.
#' }
#'
#' The following slots are relevant to receiving a selection of points:
#' \itemize{
#' \item \code{SelectBoxOpen}, a logical scalar indicating whether the selection parameter box should be open.
#' Defaults to \code{FALSE}.
#' \item \code{SelectRowSource}, a string specifying the name of the panel from which to receive a selection along the rows (e.g., \code{"rowDataPlot1"}).
#' Defaults to \code{"---"}.
#' \item \code{SelectRowType}, a string specifying which row-based selections should be used.
#' Takes one of \code{"Active"}, only the active selection;
#' \code{"Union"}, the union of active and saved selections;
#' and \code{"Saved"}, one of the saved selections.
#' Defaults to \code{"Active"}.
#' \item \code{SelectRowSaved}, an integer scalar specifying the index of the saved selection to use when \code{SelectRowType="Saved"}.
#' Defaults to 0.
#' \item \code{"SelectColSource"}, a string specifying the name of the panel from which to receive a selection along the columns (e.g., \code{"colDataPlot1"}).
#' Defaults to \code{"---"}.
#' \item \code{SelectColType}, a string specifying which column-based selections should be used.
#' Takes one of \code{"Active"}, only the active selection;
#' \code{"Union"}, the union of active and saved selections;
#' and \code{"Saved"}, one of the saved selections.
#' Defaults to \code{"Active"}.
#' \item \code{SelectColSaved}, an integer scalar specifying the index of the saved selection to use when \code{SelectColType="Saved"}.
#' Defaults to 0.
#' }
#'
#' The following slots are relevant to transmitting a selection of points:
#' \itemize{
#' \item \code{MultiSelectHistory}, a list of arbitrary elements that contain parameters for saved selections.
#' Each element of this list corresponds to one saved selection.
#' Defaults to an empty list.
#' }
#'
#' @section Getting and setting slots:
#' In all of the following code chunks, \code{x} is an instance of a Panel,
#' and \code{i} is a string containing the slot name:
#' \itemize{
#' \item \code{x[[i]]} returns the value of a slot named \code{i}.
#' \item \code{x[[i]] <- value} modifies \code{x} so that the value in slot \code{i} is replaced with \code{value}.
#' }
#'
#' @section Contract description:
#' The Panel class offers interface elements to modify all of its slots.
#' Observers are also created to trigger rerendering upon changes to a slot or when a selection in a transmitting panel changes.
#'
#' Subclasses are required to implement methods for:
#' \itemize{
#' \item \code{\link{.defineOutput}}
#' \item \code{\link{.generateOutput}}
#' \item \code{\link{.renderOutput}}
#' \item \code{\link{.fullName}}
#' \item \code{\link{.panelColor}}
#' }
#' Subclasses that transmit selections should also implement specialized methods for selection-related parameters listed below.
#'
#' @section Supported methods:
#' In the following code snippets, \code{x} is an instance of a \linkS4class{ColumnDotPlot} class.
#' Refer to the documentation for each method for more details on the remaining arguments.
#'
#' For setting up data values:
#' \itemize{
#' \item \code{\link{.refineParameters}(x, se)} is a no-op, returning \code{x} without modification.
#' \item \code{\link{.cacheCommonInfo}(x, se)} is a no-op, returning \code{se} without modification.
#' }
#'
#' For defining the interface:
#' \itemize{
#' \item \code{\link{.defineInterface}(x, se, select_info)} will return a list of collapsible boxes for changing data and selection parameters.
#' The data parameter box will be populated based on \code{\link{.defineDataInterface}}.
#' \item \code{\link{.defineDataInterface}(x, se, select_info)} will return an empty list.
#' \item \code{\link{.hideInterface}(x, field)} will always return \code{FALSE}.
#' }
#'
#' For monitoring reactive expressions:
#' \itemize{
#' \item \code{\link{.createObservers}(x, se, input, session, pObjects, rObjects)} will add observers to respond to changes in multiple selection options.
#' It will also call \code{\link{.singleSelectionSlots}(x)} to set up observers for responding to transmitted single selections.
#' \item \code{\link{.renderOutput}(x, se, ..., output, pObjects, rObjects)} will add elements to \code{output} for rendering the information textboxes at the bottom of each panel.
#' Each panel should specialize this method to add rendering expressions for the actual output (e.g., plots, tables),
#' followed by a \code{callNextMethod} to create the textboxes.
#' }
#' 
#' For controlling selections:
#' \itemize{
#' \item \code{\link{.multiSelectionRestricted}(x)} will always return \code{TRUE}.
#' \item \code{\link{.multiSelectionDimension}(x)} will always return \code{"none"}.
#' \item \code{\link{.multiSelectionActive}(x)} will always return \code{NULL}.
#' \item \code{\link{.multiSelectionClear}(x)} will always return \code{x}.
#' \item \code{\link{.multiSelectionInvalidated}(x)} will always return \code{FALSE}.
#' \item \code{\link{.multiSelectionAvailable}(x, contents)} will return \code{nrow(contents)}.
#' \item \code{\link{.singleSelectionDimension}(x)} will return \code{.multiSelectionDimension(x)}.
#' \item \code{\link{.singleSelectionValue}(x)} will always return \code{NULL}.
#' \item \code{\link{.singleSelectionSlots}(x)} will always return an empty list.
#' }
#'
#' @author Aaron Lun
#'
#' @seealso
#' \linkS4class{DotPlot} and \linkS4class{Table}, for examples of direct subclasses.
#' 
#' @name Panel-class
#' @aliases 
#' initialize,Panel-method
#' [[,Panel-method
#' [[<-,Panel-method
#' [[,Panel,ANY,ANY-method
#' [[<-,Panel,ANY,ANY-method
#' .defineInterface,Panel-method
#' .refineParameters,Panel-method
#' .cacheCommonInfo,Panel-method
#' .createObservers,Panel-method
#' .hideInterface,Panel-method
#' .defineDataInterface,Panel-method
#' .renderOutput,Panel-method
#' .multiSelectionRestricted,Panel-method
#' .multiSelectionDimension,Panel-method 
#' .multiSelectionClear,Panel-method 
#' .multiSelectionActive,Panel-method 
#' .multiSelectionInvalidated,Panel-method 
#' .multiSelectionAvailable,Panel-method 
#' .singleSelectionDimension,Panel-method
#' .singleSelectionValue,Panel-method
#' .singleSelectionSlots,Panel-method
NULL

#' @export
setMethod("initialize", "Panel", function(.Object, ...) {
    args <- list(...)

    args <- .empty_default(args, .organizationId, NA_integer_)
    args <- .empty_default(args, .organizationHeight, 500L)
    args <- .empty_default(args, .organizationWidth, 4L)

    args <- .empty_default(args, .selectParamBoxOpen, FALSE)
    args <- .empty_default(args, .selectRowSource, .noSelection)
    args <- .empty_default(args, .selectColSource, .noSelection)

    args <- .empty_default(args, .selectRowType, .selectMultiActiveTitle)
    args <- .empty_default(args, .selectRowSaved, 0L)
    args <- .empty_default(args, .selectColType, .selectMultiActiveTitle)
    args <- .empty_default(args, .selectColSaved, 0L)

    args <- .empty_default(args, .dataParamBoxOpen, FALSE)

    do.call(callNextMethod, c(list(.Object), args))
})

setValidity2("Panel", function(object) {
    msg <- character(0)
    msg <- .valid_logical_error(msg, object, c(.selectParamBoxOpen, .dataParamBoxOpen))
    msg <- .single_string_error(msg, object, c(.selectRowSource, .selectColSource))

    msg <- .valid_number_error(msg, object, .organizationHeight, lower=height_limits[1], upper=height_limits[2])
    msg <- .valid_number_error(msg, object, .organizationWidth, lower=width_limits[1], upper=width_limits[2])

    if (length(val <- object[[.organizationId]])!=1 || (!is.na(val) && val <= 0L)) {
        msg <- c(msg, sprintf("'%s' must be a positive integer or NA for '%s'", .organizationId, class(object)[1]))
    }

    for (field in c(.selectRowType, .selectColType)) {
        msg <- .allowable_choice_error(msg, object, field,
            c(.selectMultiActiveTitle, .selectMultiUnionTitle, .selectMultiSavedTitle))
    }

    for (field in c(.selectRowSaved, .selectColSaved)) {
        if (length(saved <- object[[field]]) > 1L || saved < 0L) {
            msg <- c(msg, sprintf("'%s' must be a non-negative integer in '%s'", field, class(object)[1]))
        }
    }

    if (length(msg)) {
        return(msg)
    }
    TRUE
})

#' @export
setMethod("[[", "Panel", function(x, i, j, ...) {
    slot(x, i)        
})

#' @export
setReplaceMethod("[[", "Panel", function(x, i, j, ..., value) {
    slot(x, i) <- value
    x
})

#' @export
setMethod(".refineParameters", "Panel", function(x, se) {
    x
})

#' @export
setMethod(".cacheCommonInfo", "Panel", function(x, se) {
    se
})

#' @export
setMethod(".defineInterface", "Panel", function(x, se, select_info) {
    list(
        .create_data_param_box(x, se, select_info), 
        .create_selection_param_box(x, select_info$multi$row, select_info$multi$column)
    )
})

#' @export
setMethod(".defineDataInterface", "Panel", function(x, se, select_info) list())

#' @export
setMethod(".createObservers", "Panel", function(x, se, input, session, pObjects, rObjects) {
    panel_name <- .getEncodedName(x)
    .input_FUN <- function(field) paste0(panel_name, "_", field)

    .safe_reactive_init(rObjects, panel_name)
    .safe_reactive_init(rObjects, .input_FUN(.flagSingleSelect))
    .safe_reactive_init(rObjects, .input_FUN(.flagMultiSelect))
    .safe_reactive_init(rObjects, .input_FUN(.flagRelinkedSelect))

    .create_box_observers(panel_name, c(.dataParamBoxOpen, .selectParamBoxOpen), pObjects, rObjects)

    .create_multi_selection_choice_observer(panel_name, by_field=.selectRowSource, 
        type_field=.selectRowType, saved_field=.selectRowSaved,
        input=input, session=session, pObjects=pObjects, rObjects=rObjects)

    .create_multi_selection_choice_observer(panel_name, by_field=.selectColSource, 
        type_field=.selectColType, saved_field=.selectColSaved,
        input=input, session=session, pObjects=pObjects, rObjects=rObjects)

    .create_multi_selection_type_observers(panel_name, by_field=.selectRowSource,
        type_field=.selectRowType, saved_field=.selectRowSaved,
        input=input, session=session, pObjects=pObjects, rObjects=rObjects)

    .create_multi_selection_type_observers(panel_name, by_field=.selectColSource,
        type_field=.selectColType, saved_field=.selectColSaved,
        input=input, session=session, pObjects=pObjects, rObjects=rObjects)

    .create_multi_selection_history_observers(panel_name, 
        input=input, session=session, pObjects=pObjects, rObjects=rObjects)

    for (f in .singleSelectionSlots(x)) {
        if ("dimension" %in% names(f)) {
            .create_dimname_observers(panel_name,
                name_field=f$parameter,
                choices=if (f$dimension=="column") colnames(se) else rownames(se),
                use_mode_field=f$use_mode,
                use_value=f$use_value,
                tab_field=f$source,
                protected=f$protected,
                input=input, session=session, pObjects=pObjects, rObjects=rObjects)
        }
    }
})

#' @export
setMethod(".renderOutput", "Panel", function(x, se, ..., output, pObjects, rObjects) {
    plot_name <- .getEncodedName(x)

    .create_selection_info_output(plot_name, se=se,
        output=output, pObjects=pObjects, rObjects=rObjects)

    .create_link_info_output(plot_name,
        output=output, pObjects=pObjects, rObjects=rObjects)
})

#' @export
setMethod(".hideInterface", "Panel", function(x, field) FALSE)

#' @export
setMethod(".multiSelectionRestricted", "Panel", function(x) TRUE)

#' @export
setMethod(".multiSelectionDimension", "Panel", function(x) "none")

#' @export
setMethod(".multiSelectionActive", "Panel", function(x) NULL)

#' @export
setMethod(".multiSelectionClear", "Panel", function(x) x)

#' @export
setMethod(".multiSelectionInvalidated", "Panel", function(x) FALSE)

#' @export
setMethod(".multiSelectionAvailable", "Panel", function(x, contents) nrow(contents))

#' @export
setMethod(".singleSelectionDimension", "Panel", function(x) .multiSelectionDimension(x))

#' @export
setMethod(".singleSelectionSlots", "Panel", function(x) list())