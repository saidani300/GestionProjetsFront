import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/notification_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/messages.dart';
import 'package:gestion_projets/pages/activities/widgets/activity_item.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/notifications/data/notification.dart'
as Model;
//TODO : Add number of projects
//TODO: Change add project button, more height and make it global style
//TODO: Change project status tag , it's ugly
//TODO: Select multiple projects

class ActivitiesPageBody extends StatefulWidget {
  @override
  _ActivitiesPageBodyState createState() => _ActivitiesPageBodyState();
}

class ActivitiesPageHeader extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onTap;

  const ActivitiesPageHeader({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SvgPicture.asset("icons/Activities.svg" , width: 20, height: 20,),
        Icon(
          Icons.access_time_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Activités',
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

class _ActivitiesPageBodyState extends State<ActivitiesPageBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ActivitiesPageHeader(
              onTap: () {},
              controller: controller,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [
                                SizedBox(width: 20,),
                                Icon(Icons.access_time_rounded ,size: 18,),
                                SizedBox(width: 10,),
                                Text("Aujourd'hui",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_500)
                              ]),
                            )),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        Expanded(
                            child: ActivitiesList(
                              parentContext: context,
                              scrollController: controller,
                            )),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [
                                SizedBox(width: 20,),
                                Icon(Icons.access_time_rounded ,size: 18,),
                                SizedBox(width: 10,),
                                Text("Hier",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_500)
                              ]),
                            )),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        Expanded(
                            child: ActivitiesList(
                              parentContext: context,
                              scrollController: controller,
                            )),
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}

class ActivitiesList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const ActivitiesList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<NotificationBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationBloc>(widget.parentContext);
    return Container(
        child: StreamBuilder<List<Model.Notification>>(
            stream: bloc.notificationStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                      ? NoProjects(
                    onTap: () {
                    },)
                      : ListView(
                    key: ValueKey(Random.secure()),
                    controller: widget.scrollController,
                    children:
                    results.map((e) => _buildItem(e)).toList(),
                  )
                      : Center(
                    child: SpinKitFadingCube(
                      color: active,
                      size: 25,
                      duration: Duration(milliseconds: 1200),
                    ),
                  ));
            }));
  }

  Widget _buildItem(Model.Notification activity) {
    return TestProxy(
        key: ValueKey(activity),
        child: new ActivityItem(
          activity: activity,
        ));
  }
}
