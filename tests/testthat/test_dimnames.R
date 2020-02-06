# Tests the table linking functions for point-based plots.
# library(iSEE); library(testthat); source("setup_sce.R"); source("setup_other.R"); source("test_dimnames.R")

context("table_links")

test_that("dimname observers work to change the source", {
    memory <- list(
        FeatAssayPlot(YAxisRowTable="RowStatTable1"),
        RowStatTable(),
        RowStatTable()
    )

    pObjects <- mimic_live_app(sce, memory)
    rObjects <- new.env()
    input <- list()

    # The y-axis table choice has not changed.
    out <- iSEE:::.setup_dimname_source_observer(
        "FeatAssayPlot1", use_mode_field=NA, use_value=NA,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.featAssayYAxisFeatName,
        tab_field=iSEE:::.featAssayYAxisRowTable,
        choices=NULL)

    expect_false(out)
    expect_identical(pObjects$memory$FeatAssayPlot1[["YAxisRowTable"]], "RowStatTable1")
    expect_true(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable1", "FeatAssayPlot1"))

    # Changing the table.
    input$FeatAssayPlot1_YAxisRowTable <- "RowStatTable2"

    out <- iSEE:::.setup_dimname_source_observer(
        "FeatAssayPlot1", use_mode_field=NA, use_value=NA,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.featAssayYAxisFeatName,
        tab_field=iSEE:::.featAssayYAxisRowTable,
        choices=NULL)

    expect_false(out)
    expect_identical(pObjects$memory$FeatAssayPlot1[["YAxisRowTable"]], "RowStatTable2")
    expect_false(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable1", "FeatAssayPlot1"))
    expect_true(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable2", "FeatAssayPlot1"))

    # Erasing the table.
    input$FeatAssayPlot1_YAxisRowTable <- "---"

    out <- iSEE:::.setup_dimname_source_observer(
        "FeatAssayPlot1", use_mode_field=NA, use_value=NA,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.featAssayYAxisFeatName,
        tab_field=iSEE:::.featAssayYAxisRowTable,
        choices=NULL)

    expect_false(out)
    expect_identical(pObjects$memory$FeatAssayPlot1[["YAxisRowTable"]], "---")
    expect_false(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable1", "FeatAssayPlot1"))
    expect_false(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable2", "FeatAssayPlot1"))
})

test_that("dimname observers work to change the usage mode", {
    memory <- list(
        RedDimPlot(),
        FeatAssayPlot(YAxisRowTable="RowStatTable1"),
        RowStatTable()
    )

    pObjects <- mimic_live_app(sce, memory)
    rObjects <- new.env()
    input <- list()

    # The color choice has changed.
    input$RedDimPlot1_ColorBy <- "Feature name"
    input$RedDimPlot1_ColorByRowTable <- "RowStatTable1"
    expect_identical(pObjects$memory$RedDimPlot1[["ColorBy"]], "None")
    expect_false(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable1", "RedDimPlot1"))

    out <- iSEE:::.setup_dimname_source_observer(
        "RedDimPlot1",
        use_mode_field=iSEE:::.colorByField, use_value=iSEE:::.colorByFeatNameTitle,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.colorByFeatName,
        tab_field=iSEE:::.colorByRowTable,
        choices=NULL)

    expect_true(out)
    expect_identical(pObjects$memory$RedDimPlot1[["ColorBy"]], "Feature name")
    expect_true(igraph::are_adjacent(pObjects$aesthetics_links, "RowStatTable1", "RedDimPlot1"))

    # The feature choice has changed.
    input$FeatAssayPlot1_XAxis <- "Feature name"
    input$FeatAssayPlot1_XAxisRowTable <- "RowStatTable1"
    expect_identical(pObjects$memory$FeatAssayPlot1[["XAxis"]], "None")

    id <- igraph::get.edge.ids(pObjects$aesthetics_links, c("RowStatTable1", "FeatAssayPlot1"))
    expect_identical(igraph::E(pObjects$aesthetics_links)$fields[[id]], iSEE:::.featAssayYAxisFeatName)

    out <- iSEE:::.setup_dimname_source_observer(
        "FeatAssayPlot1",
        use_mode_field=iSEE:::.featAssayXAxis, use_value=iSEE:::.featAssayXAxisFeatNameTitle,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.featAssayXAxisFeatName,
        tab_field=iSEE:::.featAssayXAxisRowTable,
        choices=NULL)

    expect_true(out)
    expect_identical(pObjects$memory$FeatAssayPlot1[["XAxis"]], "Feature name")
    expect_identical(igraph::E(pObjects$aesthetics_links)$fields[[id]],
        c(iSEE:::.featAssayYAxisFeatName, iSEE:::.featAssayXAxisFeatName))

    # Changing it back deletes the link.
    input$FeatAssayPlot1_XAxis <- "None"

    out <- iSEE:::.setup_dimname_source_observer(
        "FeatAssayPlot1",
        use_mode_field=iSEE:::.featAssayXAxis, use_value=iSEE:::.featAssayXAxisFeatNameTitle,
        pObjects=pObjects, rObjects=rObjects, input=input, session=NULL,
        name_field=iSEE:::.featAssayXAxisFeatName,
        tab_field=iSEE:::.featAssayXAxisRowTable,
        choices=NULL)

    expect_true(out)
    expect_identical(pObjects$memory$FeatAssayPlot1[["XAxis"]], "None")
    expect_identical(igraph::E(pObjects$aesthetics_links)$fields[[id]], iSEE:::.featAssayYAxisFeatName)
})

test_that(".setup_dimname_source_observer", {

    memory <- list(
        RedDimPlot(),
        FeatAssayPlot(YAxisRowTable="RowStatTable1"),
        RowStatTable(Selected=tail(rownames(sce), 1))
    )

    pObjects <- mimic_live_app(sce, memory)
    rObjects <- new.env()
    input <- list()

    # The color choice has changed.
    input$RedDimPlot1_ColorBy <- "Feature name"
    input$RedDimPlot1_ColorByRowTable <- "RowStatTable1"

    # Define dummy functions called by updateSelectizeInput
    session <- new.env()
    session$registerDataObj <- function(inputId, choices, selectizeJSON) { NULL }
    session$sendInputMessage <- function(inputId, message) { NULL }

    .setup_dimname_source_observer(
        "RedDimPlot1",
        use_mode_field=iSEE:::.colorByField, use_value=iSEE:::.colorByFeatNameTitle,
        name_field=iSEE:::.colorByFeatName,
        tab_field=iSEE:::.colorByRowTable,
        choices=letters,
        input=input, session=session,
        pObjects=pObjects, rObjects=rObjects)

})