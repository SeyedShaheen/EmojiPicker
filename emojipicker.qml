import QtQuick
import QtQuick.Window
import 'emojiList.js' as Emojis

Rectangle{

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
//                                listview.positionViewAtIndex(index, ListView.Beginning)
//                                listview.currentIndex = index
                                tabList.currentIndex = index

                                tabScrollAnim.from = listview.contentY
                                tabScrollAnim.to = listview.itemAtIndex(index).contentY
                                tabScrollAnim.running = true

                            }
                        }
                    }
                }
                NumberAnimation {
                    id: tabScrollAnim
                    target: listview
                    property: "contentX"
                    duration: 500
                }
            }

            Rectangle{
                id: scrollTitle
                width: parent.width - 20
                height: 10
                color: '#f0f0f0'
                visible: false

                Text {
                    id: scrollTitleText
                    text: "Category"
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.topMargin: 5
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
                            searchRes = Emojis.emojis.filter((i) => i.tags.includes(searchF.text)) /*&& Emojis.emojis.filter((i) => i.description.includes(searchF.text))*/
                            searchF.text !== '' ? listview.model =[...new Set(searchRes.map(i => i.category))]   : listview.model = categories

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
                    contentHeight: totalHeight
                    property var totalHeight: 0
                    onContentYChanged:  {

                        tabList.currentIndex = indexAt(contentX, contentY)
//                        indexAt(contentX, contentY) !== null ? scrollTitleText.text = model[indexAt(contentX, contentY)] : null
//                        console.log(contentY)
                        contentY > 100 ? search.visible = false : search.visible = true
                        contentY > 100 ? scrollTitle.visible = true : scrollTitle.visible = false
                        console.log('de')
                    }

                    Component.onCompleted: {
//                        for (var i = 0; i < listView.count; ++i) {
//                            listView.currentIndex = i
//                            totalHeight += listView.currentItem.height
//                        }

                        for (e in listview){
                            console.log(totalHeight)
                            totalHeight += e.height
                            console.log(totalHeight)
                        }
                    }

                    move: Transition {
                        id: scrollAnim
                                SequentialAnimation {
                                    NumberAnimation { properties: "x,y"; duration: 800; easing.type: Easing.OutBack }
                                }
                    }

                    delegate:
                        Column{
                        height: flow.childrenRect.height
                        width: listview.width - 20
                        spacing: 20
                        property var itemId: index
                        Text{text: modelData}
                        Flow {
                            id: flow
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater{
                                id: repeater
                                model: searchF.text !== '' ? searchF.searchRes.filter((i) => i.category.includes([...new Set(searchF.searchRes.map(i => i.category))]))  : Emojis.emojis.filter((i) => i.category.includes(modelData))
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
                                            console.log(listview.model)
                                            console.log(modelData.category)
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
