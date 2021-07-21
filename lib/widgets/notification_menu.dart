import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/widgets/top_nav.dart';
import 'package:get/get.dart';

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
            textTheme: TextTheme(),
            hoverColor: active.withOpacity(0.03),
            dividerTheme: DividerThemeData(
              thickness: 0.5,
              space: 0,
            )),
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
                  // splashRadius: 20,
                  // hoverColor: active.withOpacity(0.1),
                  // iconSize: 20,
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
//Items
                  itemBuilder: (context) {
                    return listItems(context);
                  }),
            ),
          ),
        ));
  }
}

List<PopupMenuEntry<Object>> listItems(BuildContext context) {
  List<PopupMenuEntry<Object>> list = [];
  list.add(
    PopupMenuItem(
      enabled: false,
      value: 0,
      height: 60,
      child: NotificationsMenuHeader(),
    ),
  );
  list.add(
    PopupMenuDivider(
      height: 0.5,
    ),
  );
  if (!isEmpty) {
    list.add(
      PopupMenuItem(
        value: 1,
        child: NotificationItem(),
      ),
    );
    list.add(
      PopupMenuDivider(
        height: 0.5,
      ),
    );
    list.add(
      PopupMenuItem(
        value: 2,
        child: NotificationItem(),
      ),
    );
    list.add(
      PopupMenuDivider(
        height: 0.5,
      ),
    );
    list.add(
      PopupMenuItem(
        value: 3,
        child: NotificationItem(),
      ),
    );
  } else {
    list.add(
      PopupMenuItem(
        value: 3,
        enabled: false,
        child: NotificationsItemEmpty(),
      ),
    );
  }
  list.add(
    PopupMenuDivider(
      height: 0.5,
    ),
  );
  list.add(
    PopupMenuItem(
      enabled: false,
      value: 4,
      height: 40,
      child: Row(
        children: [
          Expanded(child: Container()),
          if (!isEmpty)
            new NotificationsButton(
              buttonText: 'Plus',
              withIcon: true,
              buttonIcon: Icons.keyboard_arrow_right,
            ),
          Expanded(child: Container()),
        ],
      ),
    ),
  );
  return list;
}

class NotificationsMenuHeader extends StatelessWidget {
  const NotificationsMenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Notifications',
          style: textStyle_Text_14_500,
        ),
        Expanded(child: Container()),
        if (!isEmpty) new NotificationsButton(buttonText: 'Effacer tout'),
      ],
    );
  }
}

class NotificationsButton extends StatelessWidget {
  var notificationsButtonColor = active.withOpacity(0.8).obs;
  final String buttonText;
  final bool withIcon;
  final IconData buttonIcon;

  NotificationsButton(
      {Key? key,
      required this.buttonText,
      this.withIcon = false,
      this.buttonIcon = Icons.keyboard_arrow_right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialogBox(context);
        },
        hoverColor: Colors.transparent,
        onHover: (value) {
          value
              ? notificationsButtonColor.value = active
              : notificationsButtonColor.value = active.withOpacity(0.8);
        },
        child: Obx(
          () => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              buttonText,
              style: TextStyle(
                  color: notificationsButtonColor.value,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            if (withIcon)
              Icon(
                buttonIcon,
                color: notificationsButtonColor.value,
                size: 16,
              ),
          ]),
        ));
  }
}
