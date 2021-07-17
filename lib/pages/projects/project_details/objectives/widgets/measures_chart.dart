import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/chartData.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class MeasuresChart extends StatefulWidget {
  final BuildContext parentContext;
  const MeasuresChart({Key? key , required this.parentContext}) : super(key: key);

  @override
  _MeasuresChartState createState() => _MeasuresChartState();
}

class _MeasuresChartState extends State<MeasuresChart> {

  String getText(DateTime date) => DateFormat.yMMMM('fr_FR').format(date);


  @override
  void initState() {
    super.initState();
  //  bloc.init();
  }
  @override
  Widget build(BuildContext context) {
   final bloc = BlocProvider.of<ObjectiveBloc>(widget.parentContext);

    return Container( padding: EdgeInsets.symmetric(vertical: 10),
        height: 170,
        child:  StreamBuilder<List<Objective>>(
        stream: bloc.objectiveStream,
        builder: (context, snapshot) {
          print("snapshot " + snapshot.data.toString());
          final results = snapshot.data;
          return (snapshot.hasData) ? SfCartesianChart(
            zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: TextStyle(
                  color: text,
                  fontSize: 11,
                  fontFamily: 'Montserrat',
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
              autoScrollingDelta:8,
            ),
            primaryYAxis: NumericAxis(
                labelFormat: '{value} ' + results!.last.indicators.first.unit,
                labelStyle: TextStyle(
                    color: text,
                    fontSize: 11,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
                maximum: results.last.indicators.first.maxValue,
                minimum: results.last.indicators.first.minValue,
                interval: results.last.indicators.first.maxValue/10,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: _getDefaultColumn(
                results.last.indicators.first.measures.map((e) =>
                  new  ChartData(
                      x: /*getText(e.startDate)+" - " + getText(e.endDate)*/ e.endDate.toString(),
                      y: e.value,
                      pointColor: e.value <results.last.indicators.first.criticalThreshold ? lightRed :text,
                      secondSeriesYValue: 70,)).toList()
            ),
            legend: Legend(isVisible: true, textStyle: TextStyle(
                color: text,
                fontSize: 11,
                fontFamily: 'Montserrat',
                letterSpacing: 0,
                fontWeight: FontWeight.w500),),
            //tooltipBehavior: _tooltipBehavior,
          ) : Container();
        } ));
  }


  List<ColumnSeries<ChartData, String>> _getDefaultColumn(List<ChartData> chartData ) {

    return <ColumnSeries<ChartData, String>>[
      ColumnSeries<ChartData, String>(
        width: 0.8,
        spacing: 0.0,
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.pointColor,
        name: 'Mesure',

        dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(
            color: text,
            fontSize: 11,
            fontFamily: 'Montserrat',
            letterSpacing: 0,
            fontWeight: FontWeight.w500), ),
      ),
      ColumnSeries<ChartData, String>(
        dataSource: chartData,
        width: 0.8,
        spacing:0.0,
        color: lightBlue,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.secondSeriesYValue,
        name: 'Cible',
        dataLabelSettings: DataLabelSettings(isVisible: true , textStyle: TextStyle(
            color: text,
            fontSize: 11,
            fontFamily: 'Montserrat',
            letterSpacing: 0,
            fontWeight: FontWeight.w500), ),

      ),
    ];
  }
}
