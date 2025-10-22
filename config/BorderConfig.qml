import Quickshell.Io

JsonObject {
    property int thickness: Appearance.padding.normal
    property int rounding: Appearance.rounding.large
    // When a client is fullscreen, use this thickness for shell borders
    // Defaults to 0 when not specified in the user's config file
    property int fullscreenThickness: 0
}
