import QtQuick 2.0
import "."
import "QChart.js"        as Charts
import "QChartGallery.js" as ChartsData

Rectangle {
  property int chart_width: 300;
  property int chart_height: 300;
  property int chart_spacing: 20;
  property int text_height: 80;
  property int row_height: 8;

  color: "#ffffff";
  width: parent.width
  height: parent.height

  ///////////////////////////////////////////////////////////////////
  // 主体：6个图表，数据由QChartGallery.js提供
  ///////////////////////////////////////////////////////////////////
  Grid {
    id: layout;
    x: 0;
    y:0
    width: parent.width;
    height: parent.height - 2*row_height - text_height;
    columns: 3;
    spacing: chart_spacing;

    QChart {
      id: chart_bar;
      width: parent.width;
      height: parent.height;
      chartAnimated: true;
      chartAnimationEasing: Easing.OutBounce;
      chartAnimationDuration: 2000;
      chartData: ChartsData.ChartBarData;
      chartType: Charts.ChartType.BAR;
    }

  }
}
