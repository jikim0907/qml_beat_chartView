import QtQuick 2.15
import QtQuick.Window 2.15
import QtCharts 2.15
import QtGraphicalEffects 1.15
import QtDataVisualization 1.15
Window {
    width: 980
    height: 720
    visible: true
    title: qsTr("Hello World")
    property int aX: 0
    property double val_X: 0
    property double val_Y: 5
    property double idx: 1
    property var line : test.createSeries(ChartView.SeriesTypepline, "line series", xAxis, yAxis);
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
//                line.append(val_X, Math.random()*100);
                area.upperSeries.append(val_X, Math.random()*100);
                val_X = val_X + 1 ;
                val_Y = val_Y + idx ;
                aX++;
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
                line.clear();
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
        backgroundColor:"transparent"
    }

    Canvas {
        id: mycanvas
        width: 500
        height: 500
        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle="red"
            ctx.beginPath();
            ctx.moveTo(aX,parent.height);
            ctx.lineTo(aX,val_Y);
            ctx.closePath();
            ctx.stroke();
        }
    }

    Rectangle{
        id:graditem
        gradient :Gradient {
            id:grad
            GradientStop { position: 0.0; color: "yellow" }
            GradientStop { position: 0.7; color: "black" }
        }
    }
    Gradient {
        id:grad2
        GradientStop { position: 0.0; color: "yellow" }
        GradientStop { position: 0.7; color: "black" }
            }
    Component.onCompleted: {
//        area.upperSeries=line;
        line.color="lightblue";
//        area.brush= grad2;
        area.brushFilename="/mnt/hgfs/share/grad2.jpg";
        }
}
