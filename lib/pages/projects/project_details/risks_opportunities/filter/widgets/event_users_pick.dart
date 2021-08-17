import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/event_filter_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event_filter_data.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';

class EventUsersPicker extends StatefulWidget {
  final double widgetHeight;
  const EventUsersPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _EventUsersPickerState createState() => _EventUsersPickerState();
}

class _EventUsersPickerState extends State<EventUsersPicker> {
  late final eventUserBloc;
  late final filterBloc;

  @override
  void initState() {
    eventUserBloc = BlocProvider.of<UserBloc>(context);
    filterBloc = BlocProvider.of<EventFilterBloc>(context);
    super.initState();
    eventUserBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
        stream: eventUserBloc.userStream,
        builder: (context, snapshot) {
          return CustomListPopupMenuButton(
              containerHeight: widget.widgetHeight,
              offset: Offset(0, 38),
              child: StatusText(filterBloc),
              enabled: true,
              itemBuilder: (context) {
                return (snapshot.hasData)
                ? [
                CustomListPopupMenuItem(
                    value: 1,
                    enabled: false,
                    child: Container(
                        height: 161,
                        width: 250,
                        child: BlocProvider<EventFilterBloc>(
                            bloc: EventFilterBloc(),
                            child: EventUsersListView(snapshot.data! , filterBloc))))
                ]
                : [];
              });
        });
  }
}

class EventUsersListView extends StatefulWidget {
  final List<User> users;
  final EventFilterBloc bloc;
  EventUsersListView(this.users, this.bloc);


  @override
  _EventUsersListViewState createState() => _EventUsersListViewState();
}

class _EventUsersListViewState extends State<EventUsersListView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<EventFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          EventFilter? filter = snapshot.data;
          return snapshot.hasData
              ? Scrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? eq(filter!.users, users)
                            : false,
                        onChanged: (value) {

                          if (eq(filter!.users, users))
                          {
                            eventFilter.users = [];
                            widget.bloc.fetch();
                          }
                          else{
                            eventFilter.users = List.from(users);
                            widget.bloc.fetch();
                          }
                          eventFilter.allUsers = eq(filter.users, users);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Tous',
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    ),
                    onTap: () async {
                      if (eq(filter!.users, users))
                      {
                        eventFilter.users = [];
                        widget.bloc.fetch();
                      }
                      else{
                        eventFilter.users = List.from(users);
                        widget.bloc.fetch();
                      }
                      eventFilter.allUsers = eq(filter.users, users);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  ...widget.users
                      .map((e) => ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? filter!.users.contains(e)
                            : true,
                        onChanged: (value) {
                          eventFilter.users.contains(e)
                              ? widget.bloc.removeUser(e)
                              : widget.bloc.addUser(e);
                          eventFilter.allUsers = eq(filter!.users, users);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Avatar(name: e.name, picture: e.avatar , size: 25,),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            e.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle_Text_12_500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      eventFilter.users.contains(e)
                          ? widget.bloc.removeUser(e)
                          : widget.bloc.addUser(e);
                      eventFilter.allUsers = eq(filter!.users, users);
                    },
                  ))
                      .toList()
                ]),
          )
              : Container();
        });
  }
}


class StatusText extends StatefulWidget {
  final EventFilterBloc bloc;
  StatusText(this.bloc);

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText>{
  String status = "Par défaut";
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    return StreamBuilder<EventFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? !eq(filterSnapshot.data!.users, users) ? "Personnalisé" : "Par défaut" : "Par défaut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}
