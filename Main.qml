import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis

Window {
    width: 600; height: 400; visible: true; color: "#f0f0f0"; title: "Emoji Picker"
    ListView{
        id: listview
        anchors.fill: parent; anchors.bottomMargin: 100; model: Emojis.emojis; spacing: 70; headerPositioning: listview.PullBackHeader
        header: Component{ Rectangle{ width: parent.width; height: 50; z: 2; radius: 12} }
        delegate: Column{ width: parent.width - padding; height: flow.childrenRect.height; spacing: 20; padding: 10
            Text{text: modelData.category}
            Flow{id: flow; width: parent.width; height: 300
                Repeater{width: parent.width; height: 100; model: modelData.emojis
                    Rectangle {width: 40; height: 40; color: '#00000000'
                        Text {anchors.centerIn: parent; text:  modelData.emoji; font.pointSize: 24
                        }}}}}}}
