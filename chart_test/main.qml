import QtQuick 2.15
import QtQuick.Window 2.15
import QtCharts 2.15
import QtGraphicalEffects 1.15
import QtDataVisualization 1.15
Window {
    width: 500
    height: 500
    visible: true
    title: qsTr("Hello World")
    property double val_X: 0
    property double val_Y: 5
    property double idx: 1
    property var line : test.createSeries(ChartView.SeriesTypeSpline, "line series", xAxis, yAxis);
    property var area : test.createSeries(ChartView.SeriesTypeArea, "area series", xAxis, yAxis);

    ValueAxis {
        id: xAxis
        min: 0
        max: 100
        tickCount: 11
        labelFormat: "%.0f"
        visible: false
    }

    // Y 축 설정
    ValueAxis {
        id: yAxis
        min: 0
        max: 200
        tickCount: 5
        labelFormat: "%.0f"
    }

    Item {
        Timer {
            id: myTimer
            interval: 30 // 1000 milliseconds = 1 second
            running: true
            repeat: true // Set to true if you want the timer to repeat
            onTriggered: {
                area.upperSeries.append(val_X, Math.random()*100);
                area.opacity = 0.7;
                val_X = val_X + 10 ;
                val_Y = val_Y + idx ;
            }
        }
    }

    Item {
        Timer {
            id: myTimer2
            interval: 4000
            running: true
            repeat: true
            onTriggered: {
                val_X = 0;
                val_Y = 5;
                idx=1;
                area.upperSeries.clear();
            }
        }
    }

    ChartView {
        id:test
        anchors.fill: parent
//        anchors { fill: parent; margins: -10 }
//        margins { right: 0; bottom: 0; left: 0; top: 0 }
//        antialiasing: true
        animationOptions: ChartView.SeriesAnimations
        legend.visible: false
        animationDuration: 30
        backgroundColor:"black"
    }
    Gradient {
        id: grad
            GradientStop { position: 0.0; color: "red" }
            GradientStop { position: 1.0; color: "green" }
    }
//    Component.onCompleted:{
//        area.brush=grad;
//    }
}
