/*
 * Taskly - A simple tasks app for Ubuntu Touch
 *
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

UbuntuListView {
    id: listView
    clip: true

    StateSaver.properties: "contentY"

    move: Transition {
        UbuntuNumberAnimation { properties: "x,y"; duration: UbuntuAnimation.SlowDuration }
    }

    moveDisplaced: Transition {
        UbuntuNumberAnimation { properties: "x,y"; duration: UbuntuAnimation.SlowDuration }
    }

    section.property: "section"
    section.delegate: ListItem.Header {
        text: section
    }

    delegate: TaskListItem {
        id: listItem

        checked: modelData.completed
        text: formatText(modelData.title)
        subText: modelData.dueDateString

        onCheckedChanged: {
            modelData.completed = checked
            if (modelData)
                checked = Qt.binding(function() { return modelData.completed })
        }

        onClicked: {
            pageStack.push(Qt.resolvedUrl("../ui/TaskDetailsPage.qml"), {task: modelData, project: project})
        }
    }
}
