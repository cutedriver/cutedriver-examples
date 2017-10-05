/*
 this is a part of an example test file for cutedriver

 Author(s):
    2017, Juhapekka Piiroinen <juhapekka.piiroinen@link-motion.com>

 Copyright (c) 2017, Link Motion Oy
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        objectName: "menuBar"
        Menu {
            objectName: "menu"
            title: qsTr("File")
            MenuItem {
                objectName: "menuItemOpen"
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                objectName: "menuItemExit"
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Rectangle {
       anchors.fill: parent
       color: "#fff"
    }

    Flickable {
       objectName: "flickable"
       anchors {
           left: parent.left
           top: parent.top
           bottom: parent.bottom
       }
       width: appWindow.width/2
       contentWidth: grid.width
       contentHeight: grid.height

       Grid {
           id: grid
           objectName: "grid"
           Repeater {
               objectName: "repeater"
               model: 5000
               Rectangle {
                   objectName: "Rect_" + index
                   width: 50
                   height: 50
                   color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
               }
           }
           Rectangle {
               objectName: "Rect_duplicate"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect_duplicate"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
       }
    }

    Flickable {
       objectName: "flickable2"
       anchors {
           right: parent.right
           top: parent.top
           bottom: parent.bottom
       }
       width: appWindow.width/2
       contentWidth: grid.width
       contentHeight: grid.height

       Grid {
           id: grid2
           objectName: "grid2"
           Rectangle {
               objectName: "Rect2_1"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_2"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_3"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_4"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_5"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_duplicate"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
           Rectangle {
               objectName: "Rect2_duplicate"
               width: 50
               height: 50
               color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
           }
       }
    }

    Button {
        objectName: "aButton"
        anchors {
            centerIn: parent
        }
        text: "button"
        onClicked: appWindow.title = "clicked"
    }
}
