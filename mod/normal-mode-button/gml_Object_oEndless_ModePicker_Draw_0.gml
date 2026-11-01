draw_set_font(global.FontW97White);
var SelectedItem = -1;
var TopBarOffset = -30 * (1 - TileSize);
draw_set_halign(fa_center);
for (var i = 0; i < array_length(OptionTitles); i++)
{
    var ButtonX = 116 + (224 * (i % 2));
    var ButtonY = 36 + (140 * (i div 2));
    ButtonX += ((1 - TileSize) * 92);
    ButtonY += ((1 - TileSize) * 65);
    var CurrentDirection = Timer + ((ButtonX + ButtonY) / -4);
    ButtonX += round(lengthdir_x(2, CurrentDirection));
    ButtonY += round(lengthdir_y(2, CurrentDirection));
    ButtonX = round(ButtonX);
    ButtonY = round(ButtonY);
    var TileAngle = 0;
    var Hovered = mouse_in_zone(ButtonX, ButtonY, 184, 130) && UnlockedArray[i] && Active && TileSize > 0.9;
    if (Hovered)
    {
        SelectedItem = i;
        if (mouse_check_button_pressed(mb_left) && i == 3)
        {
            Active = false;
            audio_stop_all();
            audio_play_sound(sfxClick, 5, false);
            global.ModStartNormalMode = true;
            room_goto(TitleScreenMap);
        }
        else if (mouse_check_button_pressed(mb_left))
        {
            global.NuzlockeMode = i;
            audio_play_sound(sfxClick, 5, false);
            WaitToGoBack = true;
            Active = false;
            instance_destroy(oEndless_DifficultyPicker);
            instance_create_depth(0, 0, depth - 1, oEndless_DifficultyPicker);
            if (i == 2)
            {
                global.NuzlockeMode = DailyChallengeMode;
                global.Seed = get_daily_seed();
                random_set_seed(global.Seed);
                oEndless_DifficultyPicker.DailyChallengeGuard = DailyChallengeGuard;
                var MinigameSet = [];
                for (var m = 0; m < 16; m++)
                {
                    if (m == UnknownEnum.Value_7)
                    {
                        continue;
                    }
                    array_push(MinigameSet, m);
                }
                MinigameSet = array_shuffle(MinigameSet);
                array_copy(global.EndlessInventory.Cartridges, 0, MinigameSet, 0, 3);
            }
        }
    }
    var Alpha = 1;
    draw_sprite_ext(sEndless_ModeSelect, 3 + Hovered, ButtonX, ButtonY, TileSize, TileSize, 0, c_white, Alpha);
    if (UnlockedArray[i])
    {
        if (i == 3)
        {
            draw_sprite_ext(sGameTitle, 0, ButtonX + round(92 * TileSize), ButtonY + round(50 * TileSize), 0.4 * TileSize, 0.4 * TileSize, 0, c_white, Alpha);
        }
        else
        {
            draw_sprite_ext(sEndless_ModeSelect, i, ButtonX, ButtonY, TileSize, TileSize, 0, c_white, Alpha);
        }
        if (round(TileSize * 50) < 50)
        {
            draw_text_transformed(ButtonX + round(92 * TileSize), ButtonY + round(105 * TileSize), OptionTitles[i], TileSize, TileSize, 0);
        }
        else
        {
            draw_text(ButtonX + round(92 * TileSize), ButtonY + round(105 * TileSize), OptionTitles[i]);
        }
        if (i == 2)
        {
            draw_sprite_ext(sCustomNightGuardFaces, DailyChallengeGuard, ButtonX + (123 * TileSize), ButtonY + (47 * TileSize), TileSize, TileSize, 0, c_white, 1);
        }
    }
    else
    {
        draw_set_valign(fa_middle);
        var GuardsLeft = ((i == 2) ? Quota_DailyChallenge : Quota_PartyMode) - GuardsUnlocked;
        var Text = $"Unlock {GuardsLeft} more guard{(GuardsLeft == 1) ? "" : "s"} to unlock this mode!";
        if (round(TileSize * 50) < 50)
        {
            draw_text_ext_transformed(ButtonX + round(92 * TileSize), ButtonY + round(65 * TileSize), Text, 15, 170, TileSize, TileSize, 0);
        }
        else
        {
            draw_text_ext(ButtonX + round(92 * TileSize), ButtonY + round(65 * TileSize), Text, 15, 170);
        }
    }
    draw_set_valign(fa_top);
}
draw_set_halign(fa_center);
for (var i = 0; i < array_length(TextOffset); i++)
{
    var Text = OptionDescs[i];
    TextOffset[i] += (((SelectedItem == i) ? 0 : 50) - TextOffset[i]) / 5;
    draw_set_font(global.FontW97Black);
    for (var FontDirection = 0; FontDirection < 360; FontDirection += 15)
    {
        for (var FontBold = 1; FontBold <= 3; FontBold++)
        {
            draw_text_ext(320 + round(lengthdir_x(FontBold, FontDirection)), 314 + TextOffset[i] + round(lengthdir_y(FontBold, FontDirection)), Text, 15, 400);
        }
    }
    draw_set_font(global.FontW97White);
    draw_text_ext(320, 314 + TextOffset[i], Text, 15, 400);
}
draw_set_halign(fa_left);
draw_set_font(global.FontW97Black);
var Quit = input_check_pressed(UnknownEnum.Value_1);
if (Active && Quit && TileSize > 0.5)
{
    audio_stop_all();
    audio_play_sound(sfxBump, 10, false);
    room_goto(title_screen());
}
if (Active)
{
    TileSize += ((1 - TileSize) / 5);
    if (WaitToGoBack)
    {
        WaitToGoBack = false;
    }
}
else
{
    TileSize -= (TileSize / 5);
}
Timer = (Timer + 4) % 360;
draw_set_halign(fa_left);

enum UnknownEnum
{
    Value_1 = 1,
    Value_7 = 7
}
