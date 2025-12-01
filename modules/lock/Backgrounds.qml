pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import qs.config

Item {
    id: root

    required property bool locked
    required property bool isLarge
    required property bool isNormal
    required property var screen

    required property real weatherWidth
    required property real buttonsWidth
    required property real buttonsHeight
    required property real statusWidth
    required property real statusHeight

    readonly property real widthMult: isLarge ? Config.lock.sizes.widthMult : 1
    readonly property real heightMult: isLarge ? Config.lock.sizes.heightMult : 1

    readonly property real clockBottom: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real inputTop: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real weatherTop: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real weatherRight: (root.width - innerMask.width) / 2 + Config.lock.sizes.border
    readonly property real mediaY: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real mediaX: (root.width - innerMask.width) / 2 + Config.lock.sizes.border
    readonly property real buttonsTop: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real buttonsLeft: (root.width - innerMask.width) / 2 + Config.lock.sizes.border
    readonly property real statusBottom: (root.height - innerMask.height) / 2 + Config.lock.sizes.border
    readonly property real statusLeft: (root.width - innerMask.width) / 2 + Config.lock.sizes.border

    anchors.centerIn: parent
    width: screen.width * widthMult
    height: screen.height * heightMult

    Shape {
        id: shape

        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        ShapePath {
            id: innerMask

            readonly property real rounding: Appearance.rounding.large
            readonly property real roundingX: root.width < rounding * 2 ? root.width / 2 : rounding
            readonly property real roundingY: root.height < rounding * 2 ? root.height / 2 : rounding

            strokeWidth: -1
            fillColor: "transparent"

            startX: 0
            startY: innerMask.roundingY

            PathArc {
                relativeX: innerMask.roundingX
                relativeY: -innerMask.roundingY
                radiusX: Math.min(innerMask.rounding, root.width)
                radiusY: Math.min(innerMask.rounding, root.height)
            }
            PathLine {
                relativeX: root.width - innerMask.roundingX * 2
                relativeY: 0
            }
            PathArc {
                relativeX: innerMask.roundingX
                relativeY: innerMask.roundingY
                radiusX: Math.min(innerMask.rounding, root.width)
                radiusY: Math.min(innerMask.rounding, root.height)
            }
            PathLine {
                relativeX: 0
                relativeY: root.height - innerMask.roundingY * 2
            }
            PathArc {
                relativeX: -innerMask.roundingX
                relativeY: innerMask.roundingY
                radiusX: Math.min(innerMask.rounding, root.width)
                radiusY: Math.min(innerMask.rounding, root.height)
            }
            PathLine {
                relativeX: -(root.width - innerMask.roundingX * 2)
                relativeY: 0
            }
            PathArc {
                relativeX: -innerMask.roundingX
                relativeY: -innerMask.roundingY
                radiusX: Math.min(innerMask.rounding, root.width)
                radiusY: Math.min(innerMask.rounding, root.height)
            }
            PathLine {
                relativeX: 0
                relativeY: -(root.height - innerMask.roundingY * 2)
            }
        }

        ShapePath {
            id: weatherPath

            property int width: root.locked ? root.weatherWidth - Config.lock.sizes.border / 4 : 0
            property real height: root.locked ? Config.lock.sizes.barWidth : 0

            readonly property real rounding: Appearance.rounding.large * 2
            readonly property real roundingX: width < rounding * 2 ? width / 2 : rounding
            readonly property real roundingY: height < rounding * 2 ? height / 2 : rounding

            strokeWidth: -1
            fillColor: root.isLarge ? Colours.tPalette.m3surface : "transparent"

            startX: Math.ceil(innerMask.width) - width - rounding
            startY: Math.ceil(innerMask.height)

            PathArc {
                relativeX: weatherPath.roundingX
                relativeY: weatherPath.roundingY
                radiusX: Math.min(weatherPath.rounding, weatherPath.width)
                radiusY: Math.min(weatherPath.rounding, weatherPath.height)
            }
            PathLine {
                relativeX: 0
                relativeY: weatherPath.height - weatherPath.roundingY * 2
            }
            PathArc {
                relativeX: -weatherPath.roundingX
                relativeY: weatherPath.roundingY
                radiusX: Math.min(weatherPath.rounding, weatherPath.width)
                radiusY: Math.min(weatherPath.rounding, weatherPath.height)
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: -(weatherPath.width - weatherPath.roundingX * 2)
                relativeY: 0
            }
            PathArc {
                relativeX: -weatherPath.roundingX
                relativeY: -weatherPath.roundingY
                radiusX: Math.min(weatherPath.rounding, weatherPath.width)
                radiusY: Math.min(weatherPath.rounding, weatherPath.height)
            }
            PathLine {
                relativeX: 0
                relativeY: -(weatherPath.height - weatherPath.roundingY * 2)
            }
            PathArc {
                relativeX: weatherPath.roundingX
                relativeY: -weatherPath.roundingY
                radiusX: Math.min(weatherPath.rounding, weatherPath.width)
                radiusY: Math.min(weatherPath.rounding, weatherPath.height)
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: weatherPath.width - weatherPath.roundingX * 2
                relativeY: 0
            }

            Behavior on width {
                Anim {}
            }

            Behavior on height {
                Anim {}
            }

            Behavior on fillColor {
                ColorAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }

        ShapePath {
            id: mediaPath

            property int width: root.locked ? (root.isLarge ? Config.lock.sizes.mediaWidth : Config.lock.sizes.mediaWidthSmall) - Config.lock.sizes.border / 4 : 0
            property real height: root.locked ? (root.isLarge ? Config.lock.sizes.mediaHeight : Config.lock.sizes.mediaHeightSmall) : 0

            readonly property real rounding: Appearance.rounding.large * 2
            readonly property real roundingX: width < rounding * 2 ? width / 2 : rounding
            readonly property real roundingY: height < rounding * 2 ? height / 2 : rounding

            strokeWidth: -1
            fillColor: root.isNormal ? Colours.tPalette.m3surface : "transparent"

            startX: root.isLarge ? 0 : Math.ceil(innerMask.width)
            startY: root.isLarge ? height + roundingY : Math.ceil(innerMask.height) - height - roundingY

            PathArc {
                relativeX: mediaPath.roundingX * (root.isLarge ? 1 : -1)
                relativeY: mediaPath.roundingY * (root.isLarge ? -1 : 1)
                radiusX: Math.min(mediaPath.rounding, mediaPath.width)
                radiusY: Math.min(mediaPath.rounding, mediaPath.height)
            }
            PathLine {
                relativeX: (mediaPath.width - mediaPath.roundingX * 2) * (root.isLarge ? 1 : -1)
                relativeY: 0
            }
            PathArc {
                relativeX: mediaPath.roundingX * (root.isLarge ? 1 : -1)
                relativeY: mediaPath.roundingY * (root.isLarge ? -1 : 1)
                radiusX: Math.min(mediaPath.rounding, mediaPath.width)
                radiusY: Math.min(mediaPath.rounding, mediaPath.height)
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: 0
                relativeY: (mediaPath.height - mediaPath.roundingY * 2) * (root.isLarge ? -1 : 1)
            }
            PathArc {
                relativeX: mediaPath.roundingX * (root.isLarge ? 1 : -1)
                relativeY: mediaPath.roundingY * (root.isLarge ? -1 : 1)
                radiusX: Math.min(mediaPath.rounding, mediaPath.width)
                radiusY: Math.min(mediaPath.rounding, mediaPath.height)
            }
            PathLine {
                relativeX: (-mediaPath.width - mediaPath.roundingX) * (root.isLarge ? 1 : -1)
                relativeY: 0
            }

            Behavior on width {
                Anim {}
            }

            Behavior on height {
                Anim {}
            }

            Behavior on fillColor {
                ColorAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }

        ShapePath {
            id: buttonsPath

            property int width: root.locked ? root.buttonsWidth - Config.lock.sizes.border / 4 : 0
            property real height: root.locked ? root.buttonsHeight - Config.lock.sizes.border / 4 : 0

            readonly property real rounding: Appearance.rounding.large * 2
            readonly property real roundingX: width < rounding * 2 ? width / 2 : rounding
            readonly property real roundingY: height < rounding * 2 ? height / 2 : rounding

            strokeWidth: -1
            fillColor: root.isLarge ? Colours.tPalette.m3surface : "transparent"

            startX: Math.ceil(innerMask.width)
            startY: Math.ceil(innerMask.height) - height - rounding

            PathArc {
                relativeX: -buttonsPath.roundingX
                relativeY: buttonsPath.rounding
                radiusX: Math.min(buttonsPath.rounding, buttonsPath.width)
                radiusY: Math.min(buttonsPath.rounding, buttonsPath.height)
            }
            PathLine {
                relativeX: -(buttonsPath.width - buttonsPath.roundingX * 2)
                relativeY: 0
            }
            PathArc {
                relativeX: -buttonsPath.roundingX
                relativeY: buttonsPath.roundingY
                radiusX: Math.min(buttonsPath.rounding, buttonsPath.width)
                radiusY: Math.min(buttonsPath.rounding, buttonsPath.height)
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: 0
                relativeY: buttonsPath.height - buttonsPath.roundingY * 2
            }
            PathArc {
                relativeX: -buttonsPath.roundingX
                relativeY: buttonsPath.roundingY
                radiusX: Math.min(buttonsPath.rounding, buttonsPath.width)
                radiusY: Math.min(buttonsPath.rounding, buttonsPath.height)
            }
            PathLine {
                relativeX: buttonsPath.width + buttonsPath.roundingX
                relativeY: 0
            }

            Behavior on width {
                Anim {}
            }

            Behavior on height {
                Anim {}
            }

            Behavior on fillColor {
                ColorAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }

        ShapePath {
            id: statusPath

            property int width: root.locked ? root.statusWidth - Config.lock.sizes.border / 4 : 0
            property real height: root.locked ? root.statusHeight - Config.lock.sizes.border / 4 : 0

            readonly property real rounding: Appearance.rounding.large * 2
            readonly property real roundingX: width < rounding * 2 ? width / 2 : rounding
            readonly property real roundingY: height < rounding * 2 ? height / 2 : rounding

            strokeWidth: -1
            fillColor: root.isLarge ? Colours.tPalette.m3surface : "transparent"

            startX: Math.ceil(innerMask.width)
            startY: height + rounding

            PathArc {
                relativeX: -statusPath.roundingX
                relativeY: -statusPath.rounding
                radiusX: Math.min(statusPath.rounding, statusPath.width)
                radiusY: statusPath.rounding
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: -(statusPath.width - statusPath.roundingX * 2)
                relativeY: 0
            }
            PathArc {
                relativeX: -statusPath.roundingX
                relativeY: -statusPath.roundingY
                radiusX: Math.min(statusPath.rounding, statusPath.width)
                radiusY: Math.min(statusPath.rounding, statusPath.height)
            }
            PathLine {
                relativeX: 0
                relativeY: -(statusPath.height - statusPath.roundingY * 2)
            }
            PathArc {
                relativeX: -statusPath.roundingX
                relativeY: -statusPath.roundingY
                radiusX: Math.min(statusPath.rounding, statusPath.width)
                radiusY: Math.min(statusPath.rounding, statusPath.height)
                direction: PathArc.Counterclockwise
            }
            PathLine {
                relativeX: statusPath.width + statusPath.roundingX
                relativeY: 0
            }

            Behavior on width {
                Anim {}
            }

            Behavior on height {
                Anim {}
            }

            Behavior on fillColor {
                ColorAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.large
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.emphasized
    }
}
