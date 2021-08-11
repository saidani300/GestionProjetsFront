import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/task_filter_bloc.dart';
import 'package:gestion_projets/BLoC/task_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/helpers/buttons.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/filter/widgets/task_date_filter_check.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/filter/widgets/task_priorities_pick.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/filter/widgets/task_users_pick.dart';

class TaskFilterMenu extends StatefulWidget {
  const TaskFilterMenu({Key? key}) : super(key: key);

  @override
  _TaskFilterMenuState createState() => _TaskFilterMenuState();
}

class _TaskFilterMenuState extends State<TaskFilterMenu> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskFilterBloc>(
        bloc: TaskFilterBloc(),
        child: Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: active.withOpacity(0.03),
              dividerTheme: DividerThemeData(
                thickness: 0.5,
                space: 0,
              ),
              popupMenuTheme: PopupMenuThemeData(
                textStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            child: Tooltip(
              message: 'Filtre',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Material(
                  color: Colors.transparent,
                  child: PopupMenuButton(
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      offset: Offset(0, 38),
                      child: MouseRegion(
                        onEnter: (PointerEvent event) => setState(() => isHover = true),
                        onExit: (PointerEvent event) => setState(() => isHover = false),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: isHover ? active : text.withOpacity(0.7),
                          size: 17,
                        ),
                      ),
                      itemBuilder: (context) {
                        return listItems(context);
                      }),
                ),
              ),
            )));
  }
}

List<PopupMenuEntry<Object>> listItems(BuildContext context) {
  final bloc = BlocProvider.of<TaskBloc>(context);
  final filterBloc = BlocProvider.of<TaskFilterBloc>(context);
  final double widgetHeight = 35;
  return [
    PopupMenuItem(
      enabled: false,
      padding: EdgeInsets.all(0),
      value: 0,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Filtre",
                style: textStyle_Text_12_500,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
      padding: EdgeInsets.all(0),
      enabled: false,
      value: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Affecter à",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocProvider<TaskFilterBloc>(
                  bloc: TaskFilterBloc(),
                  child: BlocProvider<UserBloc>(
                      bloc: UserBloc(),
                      child:
                      Container(width: 250, child: TaskUsersPicker(widgetHeight: widgetHeight,)))),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Priorités",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocProvider<TaskFilterBloc>(
                  bloc: TaskFilterBloc(),
                  child: Container(width: 250, child: TaskPrioritiesPicker(widgetHeight: widgetHeight,))),
              BlocProvider<TaskFilterBloc>(
                  bloc: TaskFilterBloc(), child: TaskDateFilterCheck()),
              Row(
                children: [
                  Text(
                    "Date de début",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerWidget(
                textSize: 11,
                setDate: (DateTime date) {
                  taskFilter.startDate = date;
                },
                initDate: taskFilter.startDate,
                height: widgetHeight,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Date de fin",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerWidget(
                textSize: 11,
                setDate: (DateTime date) {
                  taskFilter.endDate = date;
                },
                initDate: taskFilter.endDate,
                height: widgetHeight,
              )
            ],
          ),
        ),
      ),
    ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
      enabled: false,
      padding: EdgeInsets.all(0),
      value: 4,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Container()),
              FilterOutlinedButton(
                onTap: () {
                  taskFilter = TaskFilter(
                      true,
                      true,
                      false,
                      List.from(Priority.values),
                      List.from(users),
                      DateTime(DateTime.now().year - 1, DateTime.now().month,
                          DateTime.now().day),
                      DateTime(DateTime.now().year + 1, DateTime.now().month,
                          DateTime.now().day) , null ,"");
                  bloc.fetch();
                  Navigator.pop(context);
                },
                text: 'Effacer tout',
              ),
              SizedBox(
                width: 10,
              ),
              FilterButton(
                  text: 'Appliquer',
                  onTap: () {
                    bloc.fetch();
                  }),
            ],
          ),
        ),
      ),
    ),
  ];
}
