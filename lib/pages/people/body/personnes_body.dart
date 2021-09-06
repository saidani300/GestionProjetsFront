import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/dialogs/messages.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/people/widgets/user_item.dart';
import 'package:gestion_projets/pages/projects/filter/widgets/project_order_by.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/filter/project_filter.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';

//TODO : Add number of projects
//TODO: Change add project button, more height and make it global style
//TODO: Change project status tag , it's ugly
//TODO: Select multiple projects
bool _isFilterClosed = true;

class UsersPageBody extends StatefulWidget {
  @override
  _UsersPageBodyState createState() => _UsersPageBodyState();
}

class UsersPageHeader extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onTap;

  const UsersPageHeader({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SvgPicture.asset("icons/Users.svg" , width: 20, height: 20,),
        Icon(
          Icons.group_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Personnes',
          style: TextStyle(
              color: dark,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Container()),
        //TODO : Active Export to files , Add more files types options, fix ugly button and change position.

        //TODO: Fix Button ,ugly too
        MultiOptionsButton(
            text: "Ajouter un membre",
            isMultiple: false,
            onTap: () {

            }),
      ],
    );
  }
}

class _UsersPageBodyState extends State<UsersPageBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UsersPageHeader(
              onTap: () {},
              controller: controller,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: lightGrey.withOpacity(0.3), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          // offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(3),
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: Row(children: [
                              SizedBox(width: 20,),
                              SearchWidget(
                                hintText: 'Rechercher des utilisateurs...',
                                onChanged: (value) {
                                },
                                width: 200,
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: 15,
                              ),
                              CustomIconButton(
                                  icon: Icons.save_alt_rounded,
                                  message: 'Exporter',
                                  onTap: () {
                                  }),
                              SizedBox(
                                width: 15,
                              ),
                              ProjectFilterMenu(),
                              SizedBox(
                                width: 15,
                              ),
                            ])),
                        AnimatedCrossFade(
                          firstCurve: Curves.easeIn,
                          secondCurve: Curves.easeOut,
                          firstChild: Container(),
                          secondChild: Column(children: [
                            Container(
                              height: 1,
                              color: dividerColor,
                            ),
                            /* Filter(apply: () {
                              setState(() {
                                _isFilterClosed = !_isFilterClosed;
                              });
                            }),*/
                          ]),
                          crossFadeState: _isFilterClosed
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 200),
                        ),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        UsersListHeader(),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        Expanded(
                            child: UsersList(
                              parentContext: context,
                              scrollController: controller,
                            )),
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class UsersListHeader extends StatelessWidget {
  const UsersListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Utilisateur",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Rôle",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Adresse e-mail",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Date d'ajout",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Container()),
                ProjectOrderBy(widgetHeight: 30),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class UsersList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const UsersList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UserBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(widget.parentContext);
    return Container(
        child: StreamBuilder<List<User>>(
            stream: bloc.userStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                      ? NoProjects(
                    onTap: () {
                    },)
                      : ListView(
                    key: ValueKey(Random.secure()),
                    controller: widget.scrollController,
                    children:
                    results.map((e) => _buildItem(e)).toList(),
                  )
                      : Center(
                    child: SpinKitFadingCube(
                      color: active,
                      size: 25,
                      duration: Duration(milliseconds: 1200),
                    ),
                  ));
            }));
  }

  Widget _buildItem(User user) {
    return TestProxy(
        key: ValueKey(user),
        child: new UserItem(
          user: user,
        ));
  }
}
