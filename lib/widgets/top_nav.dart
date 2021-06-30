import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/widgets/notification_menu.dart';
import 'package:gestion_projets/widgets/top_nav_menu_item.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_text.dart';
import 'notification_item.dart';

var notificationsColor = text.obs;
var supportColor = text.obs;
var settingsColor = text.withOpacity(0.4).obs;

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      toolbarHeight: 55,
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              "icons/logo.png",
              width: 28,
            ),
          ),
        ],
      ),
      title: Container(
        child: Row(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: Row(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: TopVarMenuItemRoutes.map(
                      (e) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TopNavMenuItem(
                              itemName: e.name,
                              onTap: () {
                                if (!menuController.isActive(e.name)) {
                                  menuController.changeActiveItemTo(e.name);
                                  navigationController.navigateTo(e.route);
                                  print(e.route);
                                }
                              })),
                    ).toList(),
                  ),
                ])),
            Expanded(child: Container()),
            InkWell(
              onTap: () {},
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: (value) {
                value ? supportColor.value = active : supportColor.value = text;
              },
              child: Obx(
                () => IconButton(
                    splashRadius: 20,
                    splashColor: Colors.transparent,
                    hoverColor: active.withOpacity(0.1),
                    highlightColor: Colors.transparent,
                    iconSize: 20,
                    tooltip: 'Support',
                    icon: Icon(
                      Icons.support_outlined,
                      color: supportColor.value,
                    ),
                    onPressed: () {}),
              ),
            ),
            NotificationMenu(),
           /* ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: Colors.transparent,
                child: Tooltip(
                  message: 'Notifications',
                  child: InkWell(
                    onTap: () {
                      showDialogBox(context);
                    },
                    hoverColor: active.withOpacity(0.1),
                    onHover: (value) {
                      value
                          ? notificationsColor.value = active
                          : notificationsColor.value = text;
                    },
                    child: Obx(
                      () => Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            child: IconButton(
                              color: Colors.transparent,
                              splashRadius: 20,
                              hoverColor: Colors.transparent,
                              iconSize: 20,
                              //tooltip: 'Notifications',
                              icon: Icon(
                                Icons.notifications,
                                color: notificationsColor.value,
                              ),
                              onPressed: () {
                                showDialogBox(context);
                              },
                            ),
                          ),
                          Positioned(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(
              width: 10,
            ),
            Container(
              width: 1,
              height: 22,
              color: lightText,
            ),
            SizedBox(
              width: 24,
            ),
            InkWell(
                onTap: () {
                  _showPopupMenu(context);
                },
                hoverColor: Colors.transparent,
                onHover: (value) {
                  value
                      ? settingsColor.value = active
                      : settingsColor.value = text.withOpacity(0.4);
                },
                child: Obx(
                  () => Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: settingsColor.value.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(2),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('images/uiface.jpg'),

                            /* child: Icon(Icons.person_outline, color: active, size: 15,),*/
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Saidani Wael",
                        style: TextStyle(
                              color: text,
                              fontSize: 13,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),

                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: settingsColor.value,
                        size: 20,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 1,
      backgroundColor: Colors.white,
    );

//PopupMenu
_showPopupMenu(BuildContext context) {
  showMenu<int>(
    context: context,
    position: RelativeRect.fromLTRB(25.0, 58.0, 20.0, 0.0),
    items: [
      PopupMenuItem<int>(
          height: 40,
          child: Row(children: [
            Text('Profil'),
            SizedBox(
              width: 20,
            )
          ]),
          value: 1),
      PopupMenuItem<int>(
          height: 40,
          child: Row(children: [
            Text('Paramètres de compte'),
            SizedBox(
              width: 20,
            )
          ]),
          value: 2),
      PopupMenuDivider(
        height: 1,
      ),
      PopupMenuItem<int>(
          height: 40,
          child: Row(children: [
            Text('Déconnexion'),
            SizedBox(
              width: 20,
            )
          ]),
          value: 3),
    ],
    elevation: 8.0,
  );
}

showDialogBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      var emailController = TextEditingController();
      var messageController = TextEditingController();
      return Center(
        child: Container(
          height: 50,
          width: 50,
          color: Colors.red,
        ),
      );
    },
  );
}
