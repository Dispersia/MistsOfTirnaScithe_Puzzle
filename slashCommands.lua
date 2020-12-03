local function SlashCommand(msg)
    if msg == 'show' then
        MistsOfTirnaScithe_Puzzle_Addon:Toggle(true);
    elseif msg == 'hide' then
        MistsOfTirnaScithe_Puzzle_Addon:Toggle(false);
    end
end

function MistsOfTirnaScithe_Puzzle_Addon:InitSlashCommands()
    SLASH_MOTS1 = "/mots";
    SlashCmdList.MOTS = SlashCommand;
end
