import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/account_dialog.dart';
import 'package:gestion_projets/dialogs/profile_dialog.dart';
import 'package:gestion_projets/dialogs/support_dialog.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/notification_menu.dart';
import 'package:gestion_projets/widgets/top_nav_menu_item.dart';

import '../locator.dart';

Color notificationsColor = text;
Color supportColor = text;

AppBar topNavigationBar(context) => AppBar(
      toolbarHeight: 55,
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              "icons/logo_qalitas.png",
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
      title: NavigationBarBody(),
      iconTheme: IconThemeData(color: dark),
      elevation: 1,
      backgroundColor: white,
    );

_showPopupMenu(BuildContext context) {
  showMenu<int>(
    context: context,
    position: RelativeRect.fromLTRB(25.0, 58.0, 20.0, 0.0),
    items: [
      PopupMenuItem<int>(
          child: InkWell(
            onTap: (){ profileDialogBox(context);},
            child: Container(
              height: 40,
              child: Row(children: [
                  Text(
                    'Profil',
                    style: textStyle_Text_12_500,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ]),
            ),
            ),
          value: 1),
      PopupMenuItem<int>(
          height: 40,
          child: InkWell(
            onTap: (){accountDialogBox(context);},
            child: Row(children: [
              Text(
                'Paramètres de compte',
                style: textStyle_Text_12_500,
              ),
              SizedBox(
                width: 20,
              )
            ]),
          ),
          value: 2),
      PopupMenuDivider(
        height: 1,
      ),
      PopupMenuItem<int>(
          height: 40,
          child: Row(children: [
            Text(
              'Déconnexion',
              style: textStyle_Text_12_500,
            ),
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
    useRootNavigator: false,
    useSafeArea: false,
    context: context,
    builder: (context) {
      return Center(
        child: SpinKitFadingCube(
          color: white,
          size: 25,
          duration: Duration(milliseconds: 1200),
        ),
      );
    },
  );
}

class NavigationBarBody extends StatefulWidget {
  const NavigationBarBody({Key? key}) : super(key: key);

  @override
  _NavigationBarBodyState createState() => _NavigationBarBodyState();
}

class _NavigationBarBodyState extends State<NavigationBarBody> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Row(children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: topVarMenuItemRoutes.map(
                    (e) => Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TopNavMenuItem(
                            itemName: e.name,
                            onTap: () {
                              if (!menuController.isActive(e.name)) {
                                menuController.changeActiveItemTo(e.name);
                                // navigationController.navigateTo(e.route);
                                locator<NavigationService>()
                                    .navigateTo(e.route);
                                //     Navigator.pushNamed(context, e.route);
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
              value ? supportColor = active : supportColor = text;
            },
            child: IconButton(
                splashRadius: 20,
                splashColor: Colors.transparent,
                hoverColor: active.withOpacity(0.1),
                highlightColor: Colors.transparent,
                iconSize: 20,
                tooltip: 'Support',
                icon: Icon(
                  Icons.support_outlined,
                  color: supportColor,
                ),
                onPressed: () { supportDialogBox(context);}),
          ),
          NotificationMenu(),
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
              value ? setState(() { isHover = true; }):
              setState(() { isHover = false; });
            },
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: isHover ? active : text.withAlpha(150),
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.all(1.5),
                    child: CircleAvatar(
                      child: Text(profileInitials('Saidani Wael'),
                          style: textStyle_icon_size1),
                      foregroundColor: white,
                      backgroundColor: /*Colors.deepPurpleAccent*/ colors[
                          int.tryParse("3") ?? 0],
                      //backgroundImage: AssetImage('images/uiface.jpg'),

                      /* child: Icon(Icons.person_outline, color: active, size: 15,),*/
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Saidani Wael",
                  style: textStyle_Text_13_500,
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: isHover ? active : text.withAlpha(150),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
