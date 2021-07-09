import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/Data/project_details_menu.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/side_menu_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';



class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  double _width = 230;
  bool _isExpanded = true;
  ProjectDetailsMenuItem selectedMenuItem = projectDetailsMenu.first;

  @override
  initState() {
    super.initState();
   // selectedMenuItem = projectDetailsMenu.first;
  }

  _onSelectItem(ProjectDetailsMenuItem menuItem) {
    setState(() {
      selectedMenuItem = menuItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
            width: _width,
            color: Colors.white,
            duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //MEnu Header
                  Container(
                    height: 80,
                  ),

                  //Menu Items
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: projectDetailsMenu
                        .map((e) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: SideMenuItemExpanded(
                          isExpanded: _isExpanded,
                          item: e,
                          onTap: () {
                            _onSelectItem(e);

                          },
                          isActive: e == selectedMenuItem,
                        )))
                        .toList(),
                  ),
                  Expanded(child: Container()),
                 Row(children: [Expanded(child: Container()), CustomIconButton(size: 24, icon: Icons.keyboard_arrow_left_rounded, message: '', enableToolTip: false, onTap: () {
                    if (_isExpanded)
                      _isExpanded = false;
                    else
                      Future.delayed(Duration(milliseconds: 200) , () { setState(() {
                        _isExpanded = true;
                      });} );
                    setState(() { (_width == 230) ? _width = 60.1 : _width=230;
                    });
                  },),SizedBox(width: 20,),],),
                  SizedBox(height: 20,)
                ])

      );
  }
}
