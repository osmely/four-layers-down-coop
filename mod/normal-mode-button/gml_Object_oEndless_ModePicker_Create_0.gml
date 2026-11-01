Timer = 0;
TileSize = 0;
Active = true;
var CurSeed = random_get_seed();
random_set_seed(get_daily_seed());
DailyChallengeMode = irandom(1);
do
{
    DailyChallengeGuard = irandom(20);
}
until (global.UnlockedGuards[DailyChallengeGuard]);
random_set_seed(CurSeed);
OptionTitles = ["Solo Mode", "Party Mode", "Daily Challenge", "Normal Mode"];
OptionDescs = ["Play as a single guard the whole way through. If you lose all your lives, it's game over!", "Start out with a single guard and recruit more as you play. If a guard loses a life, you switch to the next one!", $"Play a random challenge that changes each day!\n({global.GuardNames[DailyChallengeGuard]} - {DailyChallengeMode ? "Party" : "Solo"} Mode)", "Start a new game of the original Frickbear's 3 story! Takes you straight to night guard selection."];
TextOffset = array_create(array_length(OptionTitles), 50);
draw_set_alpha(1);
BarOffset = 0;
WaitToGoBack = true;
TopMenu = true;
Selected = false;
UnlockedArray = [true, true, true, true];
GuardsUnlocked = count_up(global.UnlockedGuards, true, 21);
Quota_PartyMode = 5;
Quota_DailyChallenge = 10;
if (GuardsUnlocked < Quota_PartyMode)
{
    UnlockedArray[1] = false;
}
if (GuardsUnlocked < Quota_DailyChallenge)
{
    UnlockedArray[2] = false;
}
var AllMinigamesUnlocked = true;
for (var i = 0; i < 16; i++)
{
    if (!global.UnlockedMinigames[i] && i != UnknownEnum.Value_7)
    {
        AllMinigamesUnlocked = false;
    }
}
if (AllMinigamesUnlocked)
{
    unlock_guard(UnknownEnum.Value_19);
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_19 = 19
}
