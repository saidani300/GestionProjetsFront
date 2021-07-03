import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(children :[ Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            child: CircleAvatar(
              backgroundColor: Colors.white70,
              backgroundImage: AssetImage('images/uiface.jpg'),
            ),
          ),
          SizedBox(width: 15,),
          NotificationText(),

        ],
      ),
        Row (mainAxisAlignment: MainAxisAlignment.end, children:  [Expanded(child: Container(),),Text(
          'il y a 1h ',
          style:TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 11,
              letterSpacing: 0,
              fontWeight: FontWeight.w400),

        ),
        ],)
      ]),
    );
  }
}

Widget NotificationText() => Container(
      constraints: new BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Saidani wael ',
                  style: TextStyle(
                      height: 1.5,
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600),

                ),
                TextSpan(
                  text: 'a créé une nouvelle tâche ',
                  style: TextStyle(
                      height: 1.5,
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),

                ),
                TextSpan(
                  text: 'Add new module.',
                  style: TextStyle(
                    height: 1.5,
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600),

                ),

              ],
            ),
          ),


        ],
      ),
    );

class NotificationsItemEmpty extends StatelessWidget {
  const NotificationsItemEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 345 , height: 273,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset("images/notification.svg" , width: 35, height: 35,),
      SizedBox(height: 20,),
      Text(
        'Aucune notification',
        style: TextStyle(
              color: active,
              fontSize: 13,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),

      ),
      SizedBox(height: 15,),
      Container(padding: EdgeInsets.symmetric(horizontal: 15), child:
      Text(
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
    ]),);
  }
}
