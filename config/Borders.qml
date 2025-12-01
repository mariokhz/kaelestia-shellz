pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: borders

    property var __fullscreenScreens: ({})
    property int __fullscreenCount: 0
    readonly property bool fullscreenActive: __fullscreenCount > 0

    property real thickness: fullscreenActive ? Config.border.fullscreen_thickness : Config.border.thickness

    function setFullscreen(screenName, active) {
        if (!screenName)
            return;
        const already = __fullscreenScreens[screenName] === true;
        if (active === already)
            return;
        if (active) {
            __fullscreenScreens[screenName] = true;
            __fullscreenCount += 1;
        } else {
            delete __fullscreenScreens[screenName];
            __fullscreenCount = Math.max(0, __fullscreenCount - 1);
        }
    }

    Behavior on thickness {
        NumberAnimation {
            duration: Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standard
        }
    }
}
