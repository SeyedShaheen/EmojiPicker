import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis


Window {
    width: 600
    height: 400
    visible: true
    color: "#f0f0f0"
    title: qsTr("Emoji Picker")

    property var categories: [...new Set(Emojis.emojis.map(i => i.category))]

    Rectangle{
        anchors.fill: parent
        color: '#f0f0f0'

        Column{
            anchors.fill: parent
            spacing: 10

            Rectangle{
                id: sections
                width: parent.width
                height: 50
                color: '#f0f0f0'

                Component{
                    id: highlight
                    Rectangle{
                        color: 'green'

                    }
                }

                ListView{
                    id: tabList
                    anchors.fill: parent
                    model: categories
                    orientation: ListView.Horizontal
                    highlight: highlight
                    highlightMoveDuration: 200
                    contentWidth: tabList.width
                    highlightFollowsCurrentItem: true
                    focus: true
                    interactive: false
                    delegate: Rectangle{
                        width: 66.5
                        height: parent.height
                        clip: true
                        color: "#00000000"

                        Rectangle{
                            width: parent.width
                            height: 45
                            color: "#f0f0f0"
                        }

                        Text {
                            anchors.centerIn: parent
                            text: Emojis.emojis.filter((i) => i.category.includes(modelData))[0].emoji
                            font.pointSize: 18
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                tabList.currentIndex = index
                                listview.currentIndex = index
                                console.log(listview.itemAtIndex(index).y)
                        }
                    }}
                }
            }

            Rectangle{
                id: search
                width: parent.width
                height: 35
                color: '#f0f0f0'


                Rectangle{
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    color: '#fefefe'
                    radius: 12

                    TextInput{
                        id: searchF
                        anchors.fill: parent
                        anchors.margins: 10
                        property var searchRes: []
                        onTextChanged:  {

                            searchF.text !== '' ? placeholder.visible = false : placeholder.visible = true
                            searchRes = Emojis.emojis.filter((i) => i.description.includes(searchF.text)) /*&& Emojis.emojis.filter((i) => i.description.tags(searchF.text))*/
                            console.log(Emojis.emojis.map(i => i.tags).filter((i) => i.includes(searchF.text)))
                            searchF.text !== '' ? listview.model =[" "]   : listview.model = categories

                        }

                        Text{
                            id: placeholder
                            text: 'Search Emojis'
                            color: 'grey'
                        }

                    }
                }
            }

            Rectangle{
                width: parent.width
                height: parent.height
                color: 'transparent'

                ListView{
                    id: listview
                    anchors.fill: parent
                    anchors.margins: 10
                    clip: true
                    model: categories
                    spacing: 70
                    cacheBuffer: contentHeight
                    highlightRangeMode: ListView.ApplyRange
                    preferredHighlightBegin : 0
                    highlightMoveDuration: 200
                    //preferredHighlightEnd : real
                    onContentYChanged:  {
                        tabList.currentIndex = indexAt(contentX, contentY) >= 0 ? indexAt(contentX, contentY) : tabList.currentIndex
//                        console.log(indexAt(contentX, contentY))
                        contentY > 20 && searchF.text === "" ? search.visible = false : search.visible = true
                    }
                    footer: Component{
                        Rectangle{
                            height: 300
                            width: 10
                            color: 'transparent'
                        }
                    }
                    Component.onCompleted: {
                        var totalHeight = 0
                        for (var i = 0; i < listview.count; ++i) {
                            totalHeight += listview.currentItem.height

                        }

                        listview.contentHeight = totalHeight
                        console.log(listview.contentHeight)
                        console.log(totalHeight)
                    }
                    delegate:
                        Column{
                        height: flow.childrenRect.height
                        width: listview.width - 20
                        spacing: 20
                        property int itemId: index
                        Text{
                            visible: searchF.text === '' ? true : false
                            text: modelData
                        }
                        Flow {
                            id: flow
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater{
                                id: repeater
                                model: searchF.text !== '' ? searchF.searchRes.filter((i) => i.description.includes(searchF.text))  : Emojis.emojis.filter((i) => i.category.includes(modelData))
                                Rectangle {
                                    width: 40
                                    height: 40
                                    color: '#00000000'
                                    Text {
                                        anchors.centerIn: parent
                                        text:  modelData.emoji
                                        font.pointSize: 24
                                    }

                                    MouseArea{
                                        anchors.fill: parent

                                        onClicked: {
                                            console.log(modelData.emoji)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
