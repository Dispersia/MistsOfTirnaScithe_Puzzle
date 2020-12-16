local defaults = MistsOfTirnaScithe_Puzzle_Addon.defaults;
local availableCommands = MistsOfTirnaScithe_Puzzle_Addon.availableCommands;
local order = 0;

local window;

function MistsOfTirnaScithe_Puzzle_Addon:CreateButton(point, relativeFrame, relativePoint, xOffset, yOffset, action)
    local btn = CreateFrame("Button", "$parent" .. action.index, relativeFrame, "SecureHandlerClickTemplate");

    btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset - 3);
    btn:SetSize(defaults.buttonWidth, defaults.buttonHeight);
    btn:SetNormalTexture(action.image);
    btn:SetAlpha(0.8);
    btn:RegisterForClicks("AnyUp");
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            MistsOfTirnaScithe_Puzzle_Addon:ProcessAction(self, action);
        else
            if button == "RightButton" then
                MistsOfTirnaScithe_Puzzle_Addon:Reset();
            end
        end
    end);
    btn:SetScript("OnEnter", function(self)
        if not action.selected then
            self:SetAlpha(1);
        end
    end);
    btn:SetScript("OnLeave", function(self)
        if not action.selected then
            self:SetAlpha(0.8);
        end
    end);
    return btn;
end

function MistsOfTirnaScithe_Puzzle_Addon:CreateWindow()
    local frameName = "MistsOfTirnaScithe_Puzzle_Frame";
    window = CreateFrame("Frame", frameName, UIParent);
    window.values = {};

    window:SetSize(240, 125);
    window:SetPoint("CENTER");
    window:SetMovable(true);
    window:EnableMouse(true);
    window:RegisterForDrag("LeftButton");
    window:SetScript("OnDragStart", window.StartMoving);
    window:SetScript("OnDragStop", window.StopMovingOrSizing);

    window.Backdrop = CreateFrame("Frame", frameName .. "Backdrop", window, "BackdropTemplate");
    window.Backdrop:SetAllPoints();
    window.Backdrop:SetBackdrop({
        edgeFile = "",
        edgeSize = 1,
        bgFile = [[Interface\AddOns\MistsOfTirnaScithe_Puzzle\Images\background]],
        tileSize = 64,
        tile = true
    })
    window.Backdrop:SetBackdropColor(0.5, 0.5, 0.5, 0.8);
    window.Backdrop:SetBackdropBorderColor(0, 0, 0, 0);

    for i, o in ipairs(availableCommands) do
        local position = i - 1;

        local xOffset = (position % defaults.columns) * defaults.buttonWidth * 1.1 + 1;
        local yOffset = -((position >= defaults.columns) and 1 or 0) * defaults.buttonHeight * 1.1 - 1;

        window.values[i] = MistsOfTirnaScithe_Puzzle_Addon:CreateButton("TOPLEFT", window, "TOPLEFT", xOffset, yOffset,
                               o);
    end

    return window;
end

function MistsOfTirnaScithe_Puzzle_Addon:ProcessAction(button, action)
    order = order + 1;
    action.order = order;

    if action.selected then
        order = order - 1
        action.order = 0;
    else
        button:SetAlpha(0.2);
    end
    
    action.selected = not action.selected;

    if order > 2 then
        local shape = {};
        local filled = {};
        local circled = {};
        local objects = {};

        for _, o in ipairs(availableCommands) do
            if o.order > 0 then
                shape[o.order] = o.shape;
                filled[o.order] = o.filled;
                circled[o.order] = o.circled;
                objects[o.order] = o;
            end
        end

        if order == 3 then
            for _, o1 in ipairs(objects) do
                for _, o2 in ipairs(objects) do
                    local o3;

                    if o1.order ~= 1 and o2.order ~= 1 then
                        for _, o4 in ipairs(objects) do
                            if o4.order == 1 then
                                o3 = o4;
                            end
                        end
                    end
                    if o1.order ~= 2 and o2.order ~= 2 then
                        for _, o4 in ipairs(objects) do
                            if o4.order == 2 then
                                o3 = o4;
                            end
                        end
                    end
                    if o1.order ~= 3 and o2.order ~= 3 then
                        for _, o4 in ipairs(objects) do
                            if o4.order == 3 then
                                o3 = o4;
                            end
                        end
                    end

                    if o1.index ~= o2.index then
                        if (o1.shape == o2.shape and o1.filled == o2.filled and o3.shape ~= o1.shape and o3.filled ~=
                            o1.filled) or
                            (o1.shape == o2.shape and o1.circled == o2.circled and o3.shape ~= o1.shape and o3.circled ~=
                                o1.circled) or
                            (o1.filled == o2.filled and o1.circled == o2.circled and o3.filled ~= o1.filled and
                                o3.circled ~= o1.circled) then
                            ActionButton_ShowOverlayGlow(window.values[o3.index + 1]);
                            MistsOfTirnaScithe_Puzzle_Addon:ResetButton(window.values[o3.index + 1]);
                            return;
                        end
                    end
                end
            end
        end

        local hasUniqueShape, shapeValue = MistsOfTirnaScithe_Puzzle_Addon:GetUniqueValue(shape);
        local hasUniqueFilled, filledValue = MistsOfTirnaScithe_Puzzle_Addon:GetUniqueValue(filled);
        local hasUniqueCircled, circledValue = MistsOfTirnaScithe_Puzzle_Addon:GetUniqueValue(circled);

        local count = 0;

        if hasUniqueShape then
            count = count + 1;
        end
        if hasUniqueFilled then
            count = count + 1;
        end
        if hasUniqueCircled then
            count = count + 1;
        end

        if count == 1 then
            for _, o in ipairs(availableCommands) do
                if o.order > 0 then
                    if hasUniqueShape and shapeValue == o.shape or hasUniqueFilled and filledValue == o.filled or
                        hasUniqueCircled and circledValue == o.circled then
                        ActionButton_ShowOverlayGlow(window.values[o.index + 1]);
                        MistsOfTirnaScithe_Puzzle_Addon:ResetButton(window.values[o.index + 1]);
                        break
                    end
                end
            end
        end
    end
end

function MistsOfTirnaScithe_Puzzle_Addon:GetUniqueValue(list)
    local uniqueValue = false;
    local value;
    local hash = {};

    for _, o in ipairs(list) do
        local index = o;
        hash[index] = (hash[index] or 0) + 1;
    end

    for k, v in ipairs(hash) do
        if v == 1 then
            uniqueValue = true;
            value = k;
        end
    end

    return uniqueValue, value;
end

function MistsOfTirnaScithe_Puzzle_Addon:Reset()
    for i, o in ipairs(availableCommands) do
        ActionButton_HideOverlayGlow(window.values[i]);
        MistsOfTirnaScithe_Puzzle_Addon:ResetButton(window.values[i]);
        o.selected = false;
        o.order = 0;
    end

    order = 0;
end

function MistsOfTirnaScithe_Puzzle_Addon:ResetButton(button)
    button:SetAlpha(0.8);
end

function MistsOfTirnaScithe_Puzzle_Addon:Toggle(val)
    if InCombatLockdown() then
        print("|cff00ccffMists of Tirna Scithe Puzzle Solver|r is unable to change window state while in combat.");
        return;
    end

    local panel = window or MistsOfTirnaScithe_Puzzle_Addon:CreateWindow();

    if panel ~= nil then
        panel:SetShown(val);
    end
end
