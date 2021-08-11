import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/chartData.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeasuresChart extends StatefulWidget {
  final Indicator indicator;
  final BuildContext parentContext;

  const MeasuresChart(
      {Key? key, required this.parentContext, required this.indicator})
      : super(key: key);

  @override
  _MeasuresChartState createState() => _MeasuresChartState();
}

class _MeasuresChartState extends State<MeasuresChart> {
  String getText(DateTime date) => DateFormat.yMMMM('fr_FR').format(date);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(widget.parentContext);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 170,
        child: StreamBuilder<List<Objective>>(
            stream: bloc.objectiveStream,
            builder: (context, snapshot) {
              return (snapshot.hasData)
                  ? SfCartesianChart(
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
                        autoScrollingDelta: 8,
                      ),
                      primaryYAxis: NumericAxis(
                          labelFormat: '{value} ' + widget.indicator.unit,
                          labelStyle: TextStyle(
                              color: text,
                              fontSize: 11,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                          maximum: widget.indicator.maxValue,
                          minimum: widget.indicator.minValue,
                          interval: widget.indicator.maxValue / 10,
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0)),
                      series:
                          _getDefaultColumn(widget.indicator.measures.reversed
                              .map((e) => new ChartData(
                                    x: DateFormat('dd/M/yy')
                                            .format(e.startDate) +
                                        " - " +
                                        DateFormat('dd/M/yy').format(e.endDate),
                                    y: e.value,
                                    pointColor: e.value <
                                            widget.indicator.criticalThreshold
                                        ? lightRed
                                        : text,
                                    secondSeriesYValue:
                                        widget.indicator.criticalThreshold,
                                  ))
                              .toList()),
                      legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(
                            color: text,
                            fontSize: 11,
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      ),
                      //tooltipBehavior: _tooltipBehavior,
                    )
                  : Container();
            }));
  }

  List<ColumnSeries<ChartData, String>> _getDefaultColumn(
      List<ChartData> chartData) {
    return <ColumnSeries<ChartData, String>>[
      ColumnSeries<ChartData, String>(
        width: 0.8,
        spacing: 0.0,
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.pointColor,
        name: 'Mesure',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
              color: text,
              fontSize: 11,
              fontFamily: 'Montserrat',
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
      ),
      ColumnSeries<ChartData, String>(
        dataSource: chartData,
        width: 0.8,
        spacing: 0.0,
        color: lightBlue,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.secondSeriesYValue,
        name: 'Cible',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
              color: text,
              fontSize: 11,
              fontFamily: 'Montserrat',
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
      ),
    ];
  }
}
