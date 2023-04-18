import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis

Window {
    width: 600
    height: 400
    visible: true
    color: "#f0f0f0"
    title: "Emoji Picker"
    property var searchModel: Emojis.emojis.filter(i => i.emojis.filter(i => i.description.includes(listview.headerItem.children[0].text)).length)
    Column{
        anchors.fill: parent;
        ListView{
            id: tabview; currentIndex: 0
            z: 2
            interactive: false
            width: parent.width
            height: 40
            orientation: listview.Horizontal;
            highlight: Component{
                Rectangle{z: 1; color: 'green'; opacity: 0.2
                }
            }
            highlightMoveDuration: 200;
            model: searchModel
            delegate: Rectangle{
                color: "#f0f0f0"
                width: tabview.width/listview.model.length
                height: 40; Text{anchors.centerIn: parent
                text: modelData.emojis[1].emoji
                font.pointSize: 16}
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        tabview.currentIndex = index; listview.currentIndex = index;
                    }
                }
            }
        }
        ListView{
            id: listview
            anchors.top: tabview.bottom; anchors.bottom: parent.bottom; bottomMargin: 70; anchors.bottomMargin: 10; anchors.topMargin: 10
            width: parent.width
            clip: true
            spacing: 70
            highlightRangeMode: ListView.ApplyRange; preferredHighlightBegin : 0; highlightMoveDuration: 200
            onContentYChanged: {
                tabview.currentIndex = indexAt(contentX, contentY) >= 0 ? indexAt(contentX, contentY) : tabview.currentIndex
            }
            header: Rectangle{
                anchors.left: parent.left; anchors.right: parent.right; anchors.margins: 10
                height: 40
                z: 3
                radius: 12
                property alias searching: search.text
                TextInput{
                    id: search
                    focus: true
                    anchors.fill: parent; anchors.margins: 10
                    Text{ text: "Search Emojis"; visible: parent.text === "" ? true : false
                    }
                }
            }
            headerPositioning: listview.headerItem.searching ? ListView.OverlayHeader : ListView.PullBackHeader;
            model: Emojis.emojis
            delegate: Column{
                width: parent.width - padding
                height: modelData.emojis.filter((i) => i.description.includes(listview.headerItem.children[0].text)).length === 0 ? 0 : flow.childrenRect.height
                spacing: 20
                padding: 10
                Text{
                    text: modelData.category;
                    visible:  modelData.emojis.filter((i) => i.description.includes(listview.headerItem.children[0].text)).length !== 0 ? true : false
                }
                Flow{
                    id: flow
                    width: parent.width
                    height: childrenRect.height;
                    Repeater{
                        width: parent.width
                        model: modelData.emojis.filter((i) => i.description.includes(listview.headerItem.children[0].text))
                        Rectangle {width: 40; height: 40; color: '#00000000'
                            Text {
                                anchors.centerIn: parent
                                text:  modelData.emoji
                                font.pointSize: 24
                                font.family: 'Apple Color Emoji'
                            }
                        }
                    }
                }
            }
        }
    }
}
