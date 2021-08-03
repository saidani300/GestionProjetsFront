import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/notification_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:get/get.dart';
import 'package:gestion_projets/pages/notifications/data/notification.dart'
    as Model;

import 'notification_item.dart';

//TODO: Fix NotificationMenu , Create new custom dropdownMenu
//var
var notificationsColor = text.obs;
bool newNotifications = true;
bool isEmpty = false;

class NotificationMenu extends StatelessWidget {
  const NotificationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
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
                color: text),
          ),
        ),
        child: Tooltip(
          message: 'Notifications',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Material(
              color: Colors.transparent,
              child: PopupMenuButton(
                  padding: EdgeInsets.all(0),
                  elevation: 5,
                  offset: Offset(0, 50),
                  tooltip: 'Notifications',
                  child: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.notifications,
                              color: notificationsColor.value,
                              size: 20,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: newNotifications,
                          child: Positioned(
                            top: 10,
                            right: 12,
                            child: Container(
                              width: 5,
                              height: 5,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context) {
                    return listItems(context);
                  }),
            ),
          ),
        ));
  }
}

List<PopupMenuEntry<Object>> listItems(BuildContext context) {
  final bloc = BlocProvider.of<NotificationBloc>(context);
  bloc.init();
  return [
    PopupMenuItem(
      enabled: false,
      value: 0,
      height: 60,
      child: StreamBuilder<List<Model.Notification>>(
      stream: bloc.notificationStream,
      builder: (context, snapshot) {
    return (snapshot.hasData)
          ? NotificationsMenuHeader(isEmpty:snapshot.data!.isEmpty): NotificationsMenuHeader(isEmpty: true,);})
    ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
            padding: EdgeInsets.all(0),
            value: 1,
            enabled: false,
            child: Container(
              width: 380,
              constraints: BoxConstraints(maxHeight: 300),
              child: StreamBuilder<List<Model.Notification>>(
                  stream: bloc.notificationStream,
                  builder: (context, snapshot) {
                    final results = snapshot.data;
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: (snapshot.hasData)
                            ? snapshot.data!.isEmpty
                                ? NotificationsItemEmpty()
                                : ListView(
                                    shrinkWrap: true,
                                    children: results!
                                        .map((e) =>
                                            NotificationItem(notification: e , isLast :identical(results.last,e) ))
                                        .toList(),
                                  )
                            : Center(
                                child: SpinKitFadingCube(
                                  color: active,
                                  size: 25,
                                  duration: Duration(milliseconds: 1200),
                                ),
                              ));
                  }),
            ),
          ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
      enabled: false,
      value: 4,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(child: Container()),
            if (!isEmpty)
              new NotificationsButton(
                buttonText: 'Plus',
                withIcon: true,
                buttonIcon: Icons.keyboard_arrow_right, onTap: () {  },
              ),
            Expanded(child: Container()),
          ],
        ),
      ),
    ),
  ];
}

class NotificationsMenuHeader extends StatelessWidget {
  final bool isEmpty;
  const NotificationsMenuHeader({Key? key , required this.isEmpty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Notifications',
          style: textStyle_Text_13_500,
        ),
        Expanded(child: Container()),
        if (!isEmpty) new NotificationsButton(buttonText: 'Effacer tout', onTap: () {
          deleteDialogBox(context, (){ bloc.removeAll();}, DeleteType.notification, "Les notifications");}, ),
      ],
    );
  }
}

class NotificationsButton extends StatefulWidget {
  final String buttonText;
  final bool withIcon;
  final IconData buttonIcon;
  final Function() onTap;
  NotificationsButton(
      {Key? key,
      required this.buttonText,
      this.withIcon = false,
      this.buttonIcon = Icons.keyboard_arrow_right,required this.onTap})
      : super(key: key);

  @override
  _NotificationsButtonState createState() => _NotificationsButtonState();
}

class _NotificationsButtonState extends State<NotificationsButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: () {
          widget.onTap();
        },
        hoverColor: Colors.transparent,
        onHover: (value) {
          value
              ? setState(() { isHover = true; }):
          setState(() { isHover = false; });//notificationsButtonColor.value = active.withOpacity(0.8);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.buttonText,
              style: TextStyle(
                  color: isHover ? active : active.withOpacity(0.8),
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            if (widget.withIcon)
              Icon(
                widget.buttonIcon,
                color: isHover ? active : active.withOpacity(0.8),
                size: 16,
              ),
          ]),
        );
  }
}
