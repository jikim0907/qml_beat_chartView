import QtQuick 2.15
import QtQuick.Window 2.15
import QtCharts 2.15
Window {
    width: 500
    height: 500
    visible: true
    title: qsTr("Hello World")
    property double val_X: 0
    property double val_Y: 5
    property double idx: 1
    property double i: 0
    // lineSeries is a LineSeries object that has already been added to the ChartView; re-use its axes

//    property var myAxisX : test.axisX(root);
//    property var myAxisY : test.axisY(root);
    property var scatter : test.createSeries(ChartView.SeriesTypeSpline, "line series", xAxis, yAxis);
    property var area : test.createSeries(ChartView.SeriesTypeArea,"area series", xAxis, yAxis);


    ValueAxis {
        id: xAxis
        min: 0
        max: 10
        tickCount: 11 // 0부터 10까지 11개의 틱
        labelFormat: "%.0f"
    }

    // Y 축 설정
    ValueAxis {
        id: yAxis
        min: 0
        max: 10
        tickCount: 11
        labelFormat: "%.0f"
    }

    Item {
        Timer {
            id: myTimer
            interval: 100 // 1000 milliseconds = 1 second
            running: true
            repeat: true // Set to true if you want the timer to repeat
            onTriggered: {
                scatter.append(val_X, Math.random());
//                scatter.replace(i,0,Math.random())
                val_X = val_X + 0.1 ;
                val_Y = val_Y + idx ;
                i++;
            }
        }
    }

    Item {
        Timer {
            id: myTimer2
            interval: 4000 // 1000 milliseconds = 1 second
            running: true
            repeat: true // Set to true if you want the timer to repeat
            onTriggered: {
                val_X = 0;
                val_Y = 5;
                idx=1;
                scatter.clear();
            }
        }
    }

    ChartView {
        id:test
//        width:300
//        height:300
        anchors.fill: parent
//        antialiasing: true
        theme:  ChartView.ChartThemeHighContrast
        animationOptions: ChartView.SeriesAnimations
        animationDuration: 100

    }
Component.onCompleted: {
area.upperSeries = scatter;}

}
