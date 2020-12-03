local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", function()
    MistsOfTirnaScithe_Puzzle_Addon.InitSlashCommands();
    MistsOfTirnaScithe_Puzzle_Addon:Toggle(false);
end);
