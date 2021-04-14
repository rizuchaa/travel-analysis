# head -------------------------------------------------------------------------
head<-dashboardHeader(
    title = dashboardBrand(
        title = "Travel Insurance",
        color = "info",
    )
)

# side -------------------------------------------------------------------------
side<-bs4DashSidebar(
    sidebarMenu(
        menuItem(
            "Insight",
            tabName = "insight",
            icon = shiny::icon("angle-double-right"),
            selected = T
        ),
        menuItem(
            "Data",
            tabName = "data",
            icon = shiny::icon("angle-double-right"),
            selected = NULL
        )
    ),
    disable = FALSE,
    width = NULL,
    skin = "dark",
    status = "primary",
    elevation = 4,
    collapsed = FALSE,
    minified = TRUE,
    expandOnHover = TRUE,
    fixed = TRUE,
    id = "menu",
    customArea = NULL
)

# body -------------------------------------------------------------------------
bod<-bs4DashBody(
    bs4TabItems(
        bs4TabItem( 
            bs4Card(
            "Welcome to Travel Insurance summary page.This data was conducted by @mhdzahier on Kaggle that cosisted by A third-party travel insurance servicing company that is based in Singapore.",
            solidHeader = FALSE,
            title = "Welcome",
            width = 12,
            status = "info",
            footer = NULL
        ),
        fluidRow(
            bs4Card(
                plotlyOutput("plt1"),
                solidHeader = FALSE,
                title = "Commision & Duration Ratio",
                width = 6,
                status = "primary",
                footer = NULL
            ),
            bs4Card(
                plotlyOutput("plt2"),
                solidHeader = FALSE,
                title = "Insurance Claimed",
                width = 6,
                status = "info",
                footer = NULL
            )
        ),
        bs4Card(
            plotlyOutput("plt3"),
            solidHeader = FALSE,
            title = "Insurance Packages",
            width = 12,
            status = "info",
            footer = NULL
        ), tabName = "insight"),
        bs4TabItem(
            dataTableOutput("tables"),
            tabName = "data")
    )
)

# footer -----------------------------------------------------------------------
foo<-dashboardFooter("Rahmah Nur Rizki @ 2021 All Right Reserved")

# main -------------------------------------------------------------------------
dashboardPage(
    header = head,
    sidebar = side,
    body = bod,
    footer = foo,
    title = "Travel Insurance",
    scrollToTop = T
)