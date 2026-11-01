if (surface_exists(global.MinigameSurface))
{
    surface_free(global.MinigameSurface);
}
if (surface_exists(global.UISurface))
{
    surface_free(global.UISurface);
}
sprite_delete(FaceSprites);
sprite_delete(MaskSprite);
if (variable_instance_exists(id, "HelperFaceSprites"))
{
    sprite_delete(HelperFaceSprites);
}
audio_bus_main.effects[0] = undefined;
audio_bus_main.effects[1] = undefined;
audio_bus_main.effects[2] = undefined;
audio_bus_main.effects[3] = undefined;
with (oSuperGameManager)
{
    UpsideDownTest = false;
}
