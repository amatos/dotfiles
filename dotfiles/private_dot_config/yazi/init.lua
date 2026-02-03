require("full-border"):setup {
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
}
require("git"):setup {
    -- Order of status signs showing in the linemode
    order = 1500,
}
require("mactag"):setup {
    -- Keys used to add or remove tags
    keys = {
        r = "Red",
        o = "Orange",
        y = "Yellow",
        g = "Green",
        b = "Blue",
        p = "Purple",
    },
    -- Colors used to display tags
    colors = {
        Red    = "#ee7b70",
        Orange = "#f5bd5c",
        Yellow = "#fbe764",
        Green  = "#91fc87",
        Blue   = "#5fa3f8",
        Purple = "#cb88f8",
    },
}
