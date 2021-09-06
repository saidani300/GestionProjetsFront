import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/notification_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/chartData.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/widgets/notification_item.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:gestion_projets/pages/notifications/data/notification.dart'
    as Model;

//TODO : Add number of projects
//TODO: Change project status tag , it's ugly

class DashboardPageBody extends StatefulWidget {
  @override
  _DashboardPageBodyState createState() => _DashboardPageBodyState();
}

class DashboardPageHeader extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onTap;

  const DashboardPageHeader({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.pie_chart_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Tableau de bord',
          style: TextStyle(
              color: dark,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}

class _DashboardPageBodyState extends State<DashboardPageBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationBloc>(context);
    bloc.init();
    final List<ChartData> projectsData = <ChartData>[
      ChartData(x: 'Terminé', y: 5, text: '', pointColor: lightBlue),
      ChartData(x: 'En cours', y: 12, text: '', pointColor: lightOrange),
    ];
    final List<ChartData> tasksData = <ChartData>[
      ChartData(x: 'Terminé', y: 87, text: '', pointColor: lightBlue),
      ChartData(x: 'En cours', y: 56, text: '', pointColor: lightOrange),
    ];
    final List<ChartData> objectivesData = <ChartData>[
      ChartData(x: 'Atteint', y: 30, text: '', pointColor: lightBlue),
      ChartData(x: 'En cours', y: 33, text: '', pointColor: lightOrange),
    ];
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DashboardPageHeader(
              onTap: () {},
              controller: controller,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Container(
                  child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: lightGrey.withOpacity(0.3),
                                        width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        // offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(3),
                                    color: white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child:
                                          Row( crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(child: Container(),),
                                              _buildDefaultDoughnutChart(
                                                  projectsData ,'17'),
                                              Column(mainAxisSize: MainAxisSize.min, children: [
                                                Text(
                                                  '12',
                                                  style: TextStyle(
                                                      color: lightOrange,
                                                      fontSize: 20,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(
                                                  'En cours',
                                                  style: TextStyle(
                                                      color: dark,
                                                      fontSize: 13,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],),
                                              SizedBox(width: 15,),
                                              Column(mainAxisSize: MainAxisSize.min, children: [
                                                Text(
                                                  '5',
                                                  style: TextStyle(
                                                      color: lightBlue,
                                                      fontSize: 20,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(
                                                  'Termnié',
                                                  style: TextStyle(
                                                      color: dark,
                                                      fontSize: 13,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],),
                                              Expanded(child: Container(),),
                                            ],
                                          ),
                                      ),
                                      Text(
                                        'Projets',
                                        style: TextStyle(
                                            color: dark,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: lightGrey.withOpacity(0.3),
                                        width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        // offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(3),
                                    color: white,
                                  ),
                                      child:
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child:
                                            Row( crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(child: Container(),),
                                                _buildDefaultDoughnutChart(
                                                    tasksData, '143'),
                                                Column(mainAxisSize: MainAxisSize.min, children: [
                                                  Text(
                                                    '56',
                                                    style: TextStyle(
                                                        color: lightOrange,
                                                        fontSize: 20,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'En cours',
                                                    style: TextStyle(
                                                        color: dark,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],),
                                                SizedBox(width: 15,),
                                                Column(mainAxisSize: MainAxisSize.min, children: [
                                                  Text(
                                                    '87',
                                                    style: TextStyle(
                                                        color: lightBlue,
                                                        fontSize: 20,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'Termnié',
                                                    style: TextStyle(
                                                        color: dark,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],),
                                                Expanded(child: Container(),),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Tâches',
                                            style: TextStyle(
                                                color: dark,
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: lightGrey.withOpacity(0.3),
                                        width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        // offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(3),
                                    color: white,
                                  ),
                                      child:
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child:
                                            Row( crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(child: Container(),),
                                                _buildDefaultDoughnutChart(
                                                    objectivesData, '63'),
                                                Column(mainAxisSize: MainAxisSize.min, children: [
                                                  Text(
                                                    '33',
                                                    style: TextStyle(
                                                        color: lightOrange,
                                                        fontSize: 20,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'En cours',
                                                    style: TextStyle(
                                                        color: dark,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],),
                                                SizedBox(width: 15,),
                                                Column(mainAxisSize: MainAxisSize.min, children: [
                                                  Text(
                                                    '30',
                                                    style: TextStyle(
                                                        color: lightBlue,
                                                        fontSize: 20,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'Atteint',
                                                    style: TextStyle(
                                                        color: dark,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],),
                                                Expanded(child: Container(),),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Objectifs',
                                            style: TextStyle(
                                                color: dark,
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: lightGrey.withOpacity(0.3), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5,
                                  // offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(3),
                              color: white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: _buildDefaultDateTimeAxisChart(),
                            ),
                          )),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                height: 150,
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: lightGrey.withOpacity(0.3),
                                          width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.15),
                                          spreadRadius: 0.5,
                                          blurRadius: 0.5,
                                          // offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(3),
                                      color: white,
                                    ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today_rounded,
                                                    size: 18,
                                                    color: text,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Réunions aujourd'hui",
                                                    style: TextStyle(
                                                        color: text,
                                                        fontSize: 13,
                                                        letterSpacing: 0,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                              color: dividerColor,
                                            ),
                                            Expanded(child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Container(child: Column(
                                                children: [
                                                  Row(children: [

                                                    Container(height: 40 , width: 40, decoration: BoxDecoration(shape: BoxShape.circle , color: active.withOpacity(0.07)), child:
                                                    Center(
                                                      child: Text(
                                                        "09:00",
                                                        style: TextStyle(
                                                            color: active,
                                                            fontSize: 11,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      'Retard potentiel pour une tâche',
                                                      style: TextStyle(
                                                          color: dark,
                                                          fontSize: 12,
                                                          letterSpacing: 0,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ],),
                                                  Row(
                                                    children: [
                                                      Expanded(child: Container()),
                                                      Container(
                                                          child: RowSuper(
                                                            children: meetings.first.participants.reversed
                                                                .map((e) => Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    border: Border.all(
                                                                        width: 2, color: white)),
                                                                child: Tooltip(
                                                                  message: e.name,
                                                                  child: Avatar(
                                                                    size: 25,
                                                                      name: e.name, picture: e.avatar),
                                                                )))
                                                                .toList(),
                                                            innerDistance: -10.0,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),),
                                            ))
                                          ],
                                        ),
                                  )),
                                ])),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: lightGrey.withOpacity(0.3),
                                    width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    // offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(3),
                                color: white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 18,
                                          color: text,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Activités récentes',
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 13,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: dividerColor,
                                  ),
                                  StreamBuilder<List<Model.Notification>>(
                                      stream: bloc.notificationStream,
                                      builder: (context, snapshot) {
                                        final results = snapshot.data;
                                        return AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            child: (snapshot.hasData)
                                                ? snapshot.data!.isEmpty
                                                    ? NotificationsItemEmpty()
                                                    : ListView(
                                                        shrinkWrap: true,
                                                        children: results!
                                                            .map((e) =>
                                                                NotificationItem(
                                                                    notification:
                                                                        e,
                                                                    isLast: identical(
                                                                        results
                                                                            .last,
                                                                        e)))
                                                            .toList(),
                                                      )
                                                : Center(
                                                    child: SpinKitFadingCube(
                                                      color: active,
                                                      size: 25,
                                                      duration: Duration(
                                                          milliseconds: 1200),
                                                    ),
                                                  ));
                                      }),
                                  Divider(
                                    height: 1,
                                    color: dividerColor,
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      flex: 2),
                ],
              )),
            )),
          ],
        ));
  }
}

Container _buildDefaultDoughnutChart(List<ChartData> chartData , String totalCount) {
  return Container(height: 100, width: 100,
    child: Stack(children: [
    Center(
    child: Text(
      totalCount,
      style: TextStyle(
          color: dark,
          fontSize: 25,
          letterSpacing: 0,
          fontWeight: FontWeight.w500),
    ),
    ),SfCircularChart(
        title: ChartTitle(text: true ? '' : 'Composition of ocean water'),
        legend: Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
        series: _getDefaultDoughnutSeries(chartData),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    ]),
  );
}

List<DoughnutSeries<ChartData, String>> _getDefaultDoughnutSeries(
    List<ChartData> chartData) {
  return <DoughnutSeries<ChartData, String>>[
    DoughnutSeries<ChartData, String>(
        radius: '80%',
        innerRadius: '85%',
        explode: false,
        explodeOffset: '10%',
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.pointColor,
        dataLabelMapper: (ChartData data, _) => data.text,
        dataLabelSettings: const DataLabelSettings(isVisible: true))
  ];
}

SfCartesianChart _buildDefaultDateTimeAxisChart() {
  TrackballBehavior _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
          format: 'point.x : point.y', borderWidth: 0));
  return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          textStyle: TextStyle(
              color: dark,
              fontSize: 13,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
          text: false ? '' : 'Nombre de tâches terminées par mois 2019 - 2021'),
      primaryXAxis:
          DateTimeAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 23,
        interval: 2,
        labelFormat: r'{value}',
        title: AxisTitle(text: false ? '' : 'Tâches'),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getDefaultDateTimeSeries(),
      trackballBehavior: _trackballBehavior);
}

List<LineSeries<ChartData, DateTime>> _getDefaultDateTimeSeries() {
  final List<ChartData> chartData = <ChartData>[
    ChartData(x: DateTime(2019, 1, 1), yValue: 10),
    ChartData(x: DateTime(2019, 2, 1), yValue: 15),
    ChartData(x: DateTime(2019, 3, 1), yValue: 14),
    ChartData(x: DateTime(2019, 4, 1), yValue: 14),
    ChartData(x: DateTime(2019, 5, 1), yValue: 12),
    ChartData(x: DateTime(2019, 6, 1), yValue: 11),
    ChartData(x: DateTime(2019, 7, 1), yValue: 18),
    ChartData(x: DateTime(2019, 8, 1), yValue: 5),
    ChartData(x: DateTime(2019, 9, 1), yValue: 16),
    ChartData(x: DateTime(2019, 10, 1), yValue: 18),
    ChartData(x: DateTime(2019, 11, 1), yValue: 22),
    ChartData(x: DateTime(2019, 12, 1), yValue: 8),
    ChartData(x: DateTime(2020, 1, 1), yValue: 10),
    ChartData(x: DateTime(2020, 2, 1), yValue: 11),
    ChartData(x: DateTime(2020, 3, 1), yValue: 14),
    ChartData(x: DateTime(2020, 4, 1), yValue: 5),
    ChartData(x: DateTime(2020, 5, 1), yValue: 14),
    ChartData(x: DateTime(2020, 6, 1), yValue: 6),
    ChartData(x: DateTime(2020, 7, 1), yValue: 17),
    ChartData(x: DateTime(2020, 8, 1), yValue: 10),
    ChartData(x: DateTime(2020, 9, 1), yValue: 9),
    ChartData(x: DateTime(2020, 10, 1), yValue: 14),
    ChartData(x: DateTime(2020, 11, 1), yValue: 14),
    ChartData(x: DateTime(2020, 12, 1), yValue: 14),
    ChartData(x: DateTime(2021, 1, 1), yValue: 12),
    ChartData(x: DateTime(2021, 2, 1), yValue: 10),
    ChartData(x: DateTime(2021, 3, 1), yValue: 14),
    ChartData(x: DateTime(2021, 4, 1), yValue: 13),
    ChartData(x: DateTime(2021, 5, 1), yValue: 11),
    ChartData(x: DateTime(2021, 6, 1), yValue: 10),
    ChartData(x: DateTime(2021, 7, 1), yValue: 13),
    ChartData(x: DateTime(2021, 8, 1), yValue: 10),
    ChartData(x: DateTime(2021, 9, 1), yValue: 9),
    ChartData(x: DateTime(2021, 10, 1), yValue: 12),
    ChartData(x: DateTime(2021, 11, 1), yValue: 12),
    ChartData(x: DateTime(2021, 12, 1), yValue: 11),
  ];
  return <LineSeries<ChartData, DateTime>>[
    LineSeries<ChartData, DateTime>(
      dataSource: chartData,
      xValueMapper: (ChartData data, _) => data.x as DateTime,
      yValueMapper: (ChartData data, _) => data.yValue,
      color: active,
    )
  ];
}
