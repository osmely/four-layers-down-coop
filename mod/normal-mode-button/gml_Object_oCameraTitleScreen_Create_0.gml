if (instance_number(oCamera3DMaze) > 1)
{
    instance_destroy();
}
Width = 640;
Height = 360;
application_surface_draw_enable(true);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_texrepeat(true);
CameraRotationH = 90;
CameraRotationHTarget = 90;
CameraRotationV = 0;
CameraRotationVTarget = 0;
CameraRotationD = 0;
CameraRotationDTarget = 0;
CameraX = x;
CameraY = y;
CameraZ = 32;
CameraXTo = x;
CameraYTo = y - 32;
CameraZTo = 32;
LockX = 0;
LockY = 0;
LockZ = 0;
FOV = 64;
Frame = 0;
SpeedX = 0;
SpeedY = 0;
SpeedTurn = 0;
Perspective = 1;
HeightOffset = 48;
LockOnTarget = -4;
application_surface_draw_enable(true);
Palettes = [[13497343, 9150972, 2367462, 3670100], [16776682, 15582005, 10510858, 3875328], [13695200, 7389320, 5662772, 3354368], [15852799, 15045092, 9517434, 3997737], [14940415, 13479679, 11422463, 3670100], [15137535, 2740449, 2848732, 4417], [15592941, 9211020, 5263440, 1579032], [16773119, 9221623, 10253188, 1052696], [240, 144, 72, 0], [16777215, 10461087, 1248964, 0], [16777215, 8553215, 1248964, 0], [1118481, 328965, 131586, 0], [0, 72, 144, 240], [7302117, 7759285, 8018285, 7360565], [3025408, 2498560, 1180672, 0], [12452095, 10223742, 8192050, 3474688]];
CurrentPalette = 0;
Loudness = 0;
Frame = -90;
ScreenshotsTaken = 0;
Brightness = 0;
TitleAlpha = 0;
SpacePressed = false;
TitleBrightness = 0;
TitleFlyY = 0;
TitleFlySpeed = 0;
TransitionToCutscene = false;
audio_stop_sound(musTitleScreen);
layer_set_visible("Ceiling", visible);
layer_set_visible("Floor", visible);
load_save();
completion_checks();
global.FredbearMode = global.Night == 6 && global.Route == UnknownEnum.Value_4 && global.CanContinue;
define_music_loops();
texturegroup_load("BuildingTextures");
global.Cheats = array_create(10, false);
global.EleanorChallenge = undefined;
global.FourLayersDownMode = false;
global.FreshSave = false;
if (variable_global_exists("ModStartNormalMode") && global.ModStartNormalMode)
{
    Frame = 149;
    SpacePressed = true;
    TitleFlySpeed = 10.5;
    TitleFlyY = 360;
    play_music(musTitleScreen, 1, global.FredbearMode ? 0.9 : 1);
}

enum UnknownEnum
{
    Value_4 = 4
}
