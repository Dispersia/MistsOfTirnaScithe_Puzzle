local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", function(__, event, addon)
    if (event == "ADDON_LOADED" and addon == "MistsOfTirnaScithe_Puzzle") then
        MistsOfTirnaScithe_Puzzle_Addon.InitSlashCommands();
        MistsOfTirnaScithe_Puzzle_Addon:Toggle(false);
        frame:UnregisterEvent("ADDON_LOADED");
    end
end);
