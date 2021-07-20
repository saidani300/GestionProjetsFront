import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project_details_menu.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/side_menu_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/project_icon.dart';

import '../../../../locator.dart';

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
        color: white,
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //MEnu Header
              Container(
                  child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      width: 60,
                      child: Center(
                          child: ProjectIcon(
                        name: 'D',
                      )),
                    ),
                    Positioned(
                      top: 42,
                      left: 33,
                      child: Container(
                          width: 22,
                          height: 22,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: lightBlue, shape: BoxShape.circle),
                              child: Icon(
                                Icons.check_rounded,
                                color: white,
                                size: 12,
                              ))),
                    ),
                  ],
                ),
              )),
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
                            if(selectedMenuItem != e) {
                              _onSelectItem(e);

                              locator<NavigationService>()
                                  .projectDetailsNavigateTo(e.page);
                            }
                          },
                          isActive: e == selectedMenuItem,
                        )))
                    .toList(),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(child: Container()),
                  CustomIconButton(
                    size: 24,
                    icon: Icons.keyboard_arrow_left_rounded,
                    message: '',
                    enableToolTip: false,
                    onTap: () {
                      if (_isExpanded)
                        _isExpanded = false;
                      else
                        Future.delayed(Duration(milliseconds: 200), () {
                          setState(() {
                            _isExpanded = true;
                          });
                        });
                      setState(() {
                        (_width == 230) ? _width = 60.1 : _width = 230;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ]));
  }
}
