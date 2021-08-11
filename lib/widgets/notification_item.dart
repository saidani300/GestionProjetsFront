import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/notifications/data/notification.dart' as Model;
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:timeago/timeago.dart' as timeAgo;
class NotificationItem extends StatelessWidget {
  final Model.Notification notification;
  final bool isLast;
  const NotificationItem({Key? key , required this.notification , this.isLast = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: active.withOpacity(0.015),
    onTap: () async {
      Navigator.pop(context);
    },
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    child: Container(
      child: Column(children: [
        SizedBox(height: 15,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15,),
            Avatar(name: notification.user.name, picture: notification.user.avatar,),
            SizedBox(
              width: 15,
            ),
            notificationText(notification),
            SizedBox(width: 15,),
          ],
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 15,),
            Expanded(
              child: Container(),
            ),
            Text(
                'Il y a ' + timeAgo.format(notification.date, locale: 'en_short'),
              style: TextStyle(
                  color: text.withOpacity(0.8),
                  fontSize: 11,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 15,),
          ],
        ),
        SizedBox(height: 15,),
       isLast ? Container() : Divider(height: 1, color: dividerColor,)
      ]),
    ));
  }
}

Widget notificationText(Model.Notification notification) => Flexible(
  child:   Container(
        child: 
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: notification.user.name,
                    style: TextStyle(
                        height: 1.5,
                        color: text,
                        fontSize: 11.5,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: notification.text,
                    style: TextStyle(
                        height: 1.5,
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: notification.itemName ,
                    style: TextStyle(
                        height: 1.5,
                        fontSize: 11.5,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              style: textStyle_Text_12_500,
              textAlign: TextAlign.left,
            ),
      ),
);

class NotificationsItemEmpty extends StatelessWidget {
  const NotificationsItemEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "icons/no_notifications.svg",
                color: text.withAlpha(120),
                width: 40,
                height: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Aucune notification',
                style: textStyle_Text_13_500,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Vous n'avez aucune notification, toute nouvelle notification sera affichée ici.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.5,
                      color: text.withOpacity(0.8),
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
      ),
    );
  }
}
