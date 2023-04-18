import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis

Window {
    width: 600
    height: 400
    visible: true
    color: "#f0f0f0"
    title: "Emoji Picker"
    Column{
        anchors.fill: parent;
        ListView{
            id: tabview; currentIndex: 0
            z: 2
            interactive: false
            width: parent.width
            height: 40
            orientation: listview.Horizontal;
            highlight: Rectangle { z: 1; color: 'green'; opacity: 0.2 }
            highlightMoveDuration: 200;
            model: Emojis.emojis.filter(i => i.emojis.filter(i => i.description.includes(listview.headerItem.children[0].text)).length)
            delegate: Rectangle{
                color: "#f0f0f0"
                width: tabview.width/listview.model.length
                height: 40;
                Text {
                    anchors.centerIn: parent
                    text: modelData.emojis[1].emoji
                    font.pointSize: 28
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        tabview.currentIndex = index;
                        listview.currentIndex = index;
                    }
                }
            }
        }
        ListView {
            id: listview
            anchors { top: tabview.bottom; bottom: parent.bottom; bottomMargin: 10; topMargin: 10 }
            width: parent.width
            clip: true
            highlightRangeMode: ListView.ApplyRange; preferredHighlightBegin: 40; highlightMoveDuration: 200
            onContentYChanged: {
                tabview.currentIndex = indexAt(contentX, contentY) >= 0 ? indexAt(contentX, contentY) : tabview.currentIndex
            }
            header: Rectangle {
                anchors.left: parent.left; anchors.right: parent.right; anchors.margins: 10
                height: 40
                z: 3
                radius: 12
                property alias searching: search.text
                TextInput {
                    id: search
                    focus: true
                    anchors.fill: parent; anchors.margins: 10
                    Text { text: "Search Emojis"; visible: !parent.text }
                }
            }
            headerPositioning: listview.headerItem.searching ? ListView.OverlayHeader : ListView.PullBackHeader;
            model: Emojis.emojis
            delegate: Column {
                width: listview.width - padding
                padding: repeater.count ? 10 : 0
                topPadding: repeater.count ? 20 : 0
                Text {
                    text: modelData.category;
                    visible: repeater.count
                    bottomPadding: 10
                }
                Flow {
                    id: flow
                    width: parent.width
                    visible: repeater.count
                    Repeater {
                        id: repeater
                        width: parent.width
                        model: modelData.emojis.filter((i) => i.description.includes(listview.headerItem.children[0].text))
                        Rectangle {
                            width: 40; height: 40; color: '#00000000'
                            Text {
                                anchors.centerIn: parent
                                text: modelData.emoji
                                font.pointSize: 28
                                font.family: 'Apple Color Emoji'
                            }
                        }
                    }
                }
            }
        }
    }
}
