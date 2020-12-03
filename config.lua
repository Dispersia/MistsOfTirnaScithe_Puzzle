MistsOfTirnaScithe_Puzzle_Addon = {};

MistsOfTirnaScithe_Puzzle_Addon.defaults = {
    buttonWidth = 55,
    buttonHeight = 55,
    columns = 4,
    font = "GameFontNormalLarge",
    highlightFont = "GameFontHighlightLarge"
};

local shapes = {
    LEAF = 1,
    FLOWER = 2
};

local filled = {
    FILLED = 1,
    NOT_FILLED = 2
};

local circled = {
    CIRCLED = 1,
    NOT_CIRCLED = 2
};

MistsOfTirnaScithe_Puzzle_Addon.availableCommands = {{
    index = 0,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\LeafEmpty",
    shape = shapes.LEAF,
    filled = filled.NOT_FILLED,
    circled = circled.NOT_CIRCLED
}, {
    index = 1,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\FlowerEmpty",
    shape = shapes.FLOWER,
    filled = filled.NOT_FILLED,
    circled = circled.NOT_CIRCLED
}, {
    index = 2,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\CircledLeafEmpty",
    shape = shapes.LEAF,
    filled = filled.NOT_FILLED,
    circled = circled.CIRCLED
}, {
    index = 3,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\CircledFlowerEmpty",
    shape = shapes.FLOWER,
    filled = filled.NOT_FILLED,
    circled = circled.CIRCLED
}, {
    index = 4,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\LeafFull",
    shape = shapes.LEAF,
    filled = filled.FILLED,
    circled = circled.NOT_CIRCLED
}, {
    index = 5,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\FlowerFull",
    shape = shapes.FLOWER,
    filled = filled.FILLED,
    circled = circled.NOT_CIRCLED
}, {
    index = 6,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\CircledLeafFull",
    shape = shapes.LEAF,
    filled = filled.FILLED,
    circled = circled.CIRCLED
}, {
    index = 7,
    order = 0,
    selected = false,
    image = "Interface\\Addons\\MistsOfTirnaScithe_Puzzle\\Images\\CircledFlowerFull",
    shape = shapes.FLOWER,
    filled = filled.FILLED,
    circled = circled.CIRCLED
}};
