import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis

Window {
    width: 600; height: 400; visible: true; color: "#f0f0f0"; title: "Emoji Picker"
    Column{ anchors.fill: parent;
    ListView{id: tabview; z: 2; interactive: false; width: parent.width; height: 40; orientation: listview.Horizontal;
    highlight: Component{Rectangle{z: 1; height: 0; color: 'green'}} highlightMoveDuration: 200; model: Emojis.emojis;
    delegate: Rectangle{ color: "#f0f0f0"; width: tabview.width/9; height: 40; Text{anchors.centerIn: parent; text: modelData.emojis[1].emoji; font.pointSize: 16}
        MouseArea{anchors.fill: parent; onClicked: { tabview.currentIndex = index; listview.currentIndex = index }}}
    }
    ListView{id: listview; anchors.top: tabview.bottom; anchors.bottom: parent.bottom; width: parent.width;
        anchors.bottomMargin: 100; topMargin: 10; spacing: 70; headerPositioning: listview.PullBackHeader;
        highlightRangeMode: ListView.ApplyRange; preferredHighlightBegin : 0; highlightMoveDuration: 200
        onContentYChanged: {tabview.currentIndex = indexAt(contentX, contentY) >= 0 ? indexAt(contentX, contentY) : tabview.currentIndex}
        header: Component{ Rectangle{ width: parent.width; height: 30; z: 2; radius: 12;
                TextInput{id: search; anchors.fill: parent; anchors.margins: 10; Text{ text: "Search Emojis"; visible: parent.text === "" ? true : false}}}}
        model: Emojis.emojis.filter((i) => i.emojis[1].description.includes("a"));
        delegate: Column{ width: parent.width - padding; height: flow.childrenRect.height; spacing: 20; padding: 10
            Text{text: modelData.category}
            Flow{id: flow; width: parent.width; height: 300
                Repeater{width: parent.width; height: 100; model: modelData.emojis
                    Rectangle {width: 40; height: 40; color: '#00000000'
                        Text {anchors.centerIn: parent; text:  modelData.emoji; font.pointSize: 24
                        }}}}}}}}
