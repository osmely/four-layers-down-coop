global.FourLayersDownMode = false;

function initialize_ability_index()
{
    global.TrueAbilityIndex = array_concat(countup_array(20), array_create(30, UnknownEnum.Value_1));
    global.AbilityIndex = [];
    array_copy(global.AbilityIndex, 0, global.TrueAbilityIndex, 0, array_length(global.TrueAbilityIndex));
}

initialize_ability_index();

function functional_guard_id(arg0)
{
    if (!global.FourLayersDownMode)
    {
        return UnknownEnum.Value_1;
    }
    return global.AbilityIndex[arg0];
}

function true_guard_ability(arg0)
{
    return global.TrueAbilityIndex[global.Guard] == arg0;
}

function guard_ability(arg0)
{
    if (global.Night == "Custom")
    {
        return global.CustomNightGuardAbility == arg0;
    }
    return functional_guard_id(global.Guard) == arg0 || coop_ability(arg0);
}

function coop_ability(arg0)
{
    if (!global.FourLayersDownMode || arg0 == UnknownEnum.Value_0 || arg0 == UnknownEnum.Value_2 || arg0 == UnknownEnum.Value_4 || arg0 == UnknownEnum.Value_5)
    {
        return false;
    }
    var Partner = coop_partner();
    return Partner != -1 && functional_guard_id(Partner) == arg0;
}

function guard_ability_in_party(arg0)
{
    for (var i = 0; i < array_length(global.Lives); i++)
    {
        if (functional_guard_id(global.Lives[i]) == arg0)
        {
            return true;
        }
    }
    return false;
}

function true_guard_ability_in_party(arg0)
{
    for (var i = 0; i < array_length(global.Lives); i++)
    {
        if (global.TrueAbilityIndex[global.Lives[i]] == arg0)
        {
            return true;
        }
    }
    return false;
}

function get_guard_description(arg0, arg1 = true)
{
    if (arg0 >= 21)
    {
        return global.GuardParameters.description;
    }
    return get_guard_true_description(arg0, arg1);
}

function get_guard_true_description(arg0, arg1 = true)
{
    switch (arg1 ? global.TrueAbilityIndex[arg0] : global.AbilityIndex[arg0])
    {
        case UnknownEnum.Value_0:
            return "Cheaper animatronics are more likely to appear.";
        case UnknownEnum.Value_2:
            return "More expensive animatronics are more likely to appear.";
        case UnknownEnum.Value_3:
            return "Challenge shops appear more frequently.";
        case UnknownEnum.Value_4:
            return "Animatronics from the base game are much more likely to appear.";
        case UnknownEnum.Value_5:
            return "Animatronics from the update roster are much more likely to appear.";
        case UnknownEnum.Value_6:
            return "You no longer get token or power bonuses, but all shops are at a 20% discount.";
        case UnknownEnum.Value_7:
            return "Blocked animatronics no longer drop tokens, but you earn 1.5x as many tokens from minigames.";
        case UnknownEnum.Value_8:
            return "The night will not end until you've collected a certain amount of tokens. The amount needed increases each round.";
        case UnknownEnum.Value_10:
            return "Animatronics' aggression levels are doubled, but their salvage values are 25% higher, and you have to pick less of them each round.";
        case UnknownEnum.Value_11:
            return "You start each night with a Beartrap, but dying will immediately end your run.";
        case UnknownEnum.Value_12:
            return $"You start out with ${250}, but can no longer earn money from salvages or end-of-night bonuses. (In party mode, switching to a different character will deplete 10% of this initial amount.)";
        case UnknownEnum.Value_13:
            return "You have less animatronics to pick from, but can visit any shop at the end of each round.";
        case UnknownEnum.Value_19:
            return "The night only ends once you've earned enough points by playing minigames, and your minigame selection is randomized each round.";
        case UnknownEnum.Value_17:
            return "Time progresses at half speed while facing the front of the office, but double speed when listening to the music player in the back.";
        case UnknownEnum.Value_14:
            return "Each round, prior to animatronic selection, you will also need to pick one of three Eleanor challenges.";
        case UnknownEnum.Value_15:
            return "Your power drains much faster, but can be refilled by wearing the mask.";
        case UnknownEnum.Value_18:
            return "The temperature meter is replaced by a panic meter. Your panic increases when dealing with animatronics, and can be decreased by looking out the back window.";
        case UnknownEnum.Value_16:
            return "Your power won't drain so long as you have 1 bar of usage or less. Otherwise, your power will drain significantly faster than usual.";
        case UnknownEnum.Value_9:
            return "You start out with the FredTV+ upgrade, but your camera views on the monitor are shrouded in darkness.";
        case UnknownEnum.Value_20:
            return "You need to choose an additional animatronic each round, but can also pay to remove any animatronic once per round.";
        case UnknownEnum.Value_27:
            return $"Your ability is randomized each round.{(functional_guard_id(arg0) == UnknownEnum.Value_27) ? "" : (" CURRENTLY: " + get_guard_description(arg0, false))}";
        case UnknownEnum.Value_28:
            return $"You may freely pick between any bonus ability at the start of your run. {(functional_guard_id(arg0) == UnknownEnum.Value_28) ? "" : (" CURRENTLY: " + get_guard_description(arg0, false))} (NOT CURRENTLY FUNCTIONAL)";
        case UnknownEnum.Value_21:
            return "Using the monitor no longer drains power, but every other tool drains power twice as fast.";
        case UnknownEnum.Value_22:
            return "Deathcoins can no longer be purchased from the shop, but Beartraps will remove any animatronic they block for the rest of a round.";
        case UnknownEnum.Value_24:
            return "Earnings from salvages are halved, but shops are at a 40% discount.";
        case UnknownEnum.Value_25:
            return "Earnings from salvages are doubled, but shops are 80% more expensive.";
        case UnknownEnum.Value_26:
            return "All animatronics' salvage values are equalized.";
        case UnknownEnum.Value_23:
            return "Items from Mendo's shop are in unlimited supply, but get exponentially more expensive for each one purchased.";
        case UnknownEnum.Value_1:
        default:
            return "No special abilities.";
    }
}

function get_guard_unlock_description(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_3:
            return "Beat a run.";
        case UnknownEnum.Value_4:
            return "Beat a run on Hard difficulty or higher... OR beat a run as 10 different guards.";
        case UnknownEnum.Value_5:
            return "Get a completion sticker on 40 or more animatronics.";
        case UnknownEnum.Value_6:
            return "Buy this guard a drink at the bar.";
        case UnknownEnum.Value_7:
            return $"Beat one of {anon_name(UnknownEnum.Value_140)}'s ++ rank minigames... OR clear Fredsweeper three times in a single round.";
        case UnknownEnum.Value_8:
            return "Enter the Angel's Sanctum with $100 or more saved up... OR finish a night with 150 or more tokens saved up.";
        case UnknownEnum.Value_10:
            return $"Get a completion sticker on all {87} animatronics.";
        case UnknownEnum.Value_11:
            return "Beat a run on Hard difficulty or higher without losing a life... OR beat round 10 while in the middle of a jumpscare.";
        case UnknownEnum.Value_12:
            return $"Beat a run with {anon_name(UnknownEnum.Value_73)} salvaged.";
        case UnknownEnum.Value_13:
            return "Meet every shopkeeper.";
        case UnknownEnum.Value_19:
            return "Unlock every minigame.";
        case UnknownEnum.Value_17:
            return "Lose a run on round 10 or later.";
        case UnknownEnum.Value_15:
            return "Beat a run with 5 or more Mask animatronics salvaged.";
        case UnknownEnum.Value_18:
            return "Finish a run with 5 or more Turnaround characters salvaged.";
        case UnknownEnum.Value_14:
            return $"Survive one of {anon_name(UnknownEnum.Value_138)}'s + rank challenges.";
        case UnknownEnum.Value_9:
            return "Beat a run with the Dead Ringer upgrade purchased.";
        case UnknownEnum.Value_16:
            return $"Beat a run as Jeremy, Mike, Vanessa and {global.UnlockedGuards[UnknownEnum.Value_3] ? "Fritz" : "???"}.";
        case UnknownEnum.Value_20:
            return "Guide all the lost home.";
        default:
            return "Unlocked by default.";
    }
}

function edwin_money_exchange(arg0)
{
    if (arg0 && !guard_ability(UnknownEnum.Value_12))
    {
        global.RunEarnings -= (25 * (11 - (global.EndlessRound % 10)));
    }
    if (!arg0 && guard_ability(UnknownEnum.Value_12))
    {
        global.RunEarnings += (25 * (11 - (global.EndlessRound % 10)));
    }
}

function guard_id_conversion(arg0, arg1 = false)
{
    return (arg0 >= 21) ? (arg0 - (21 - ((arg1 && !lunatic_unlocked()) ? 3 : 4))) : arg0;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_73 = 73,
    Value_138 = 138,
    Value_140 = 140
}
