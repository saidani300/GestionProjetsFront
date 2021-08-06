import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/pick_users_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/dialogs/forms/widgets/user_picker.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';

class Users extends StatefulWidget {
  final List<User> users;
  const Users({Key? key, required this.users}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users>
    with AutomaticKeepAliveClientMixin<Users> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UsersPickBloc>(context);
    super.initState();
    bloc.init(widget.users);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddUser(
          users: widget.users,
        ),
        // SizedBox(height: 10,),
        StreamBuilder<List<User>>(
            stream: bloc.userStream,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: (snapshot.hasData)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: snapshot.data!
                            .map(
                              (e) => _buildFolder(widget.users, e),
                            )
                            .toList(),
                      )
                    : Padding(
                      padding: const EdgeInsets.all(10),
                      child: SpinKitThreeBounce(
                  color: active,
                  size: 15,
                  duration: Duration(milliseconds: 1200),
                ),
                    ),
              );
            }),
      ],
    );
  }

  Widget _buildFolder(List<User> users, User user) {
    return TestProxy(
        key: ValueKey(user),
        child: new UserItem(
          user: user,
          users: users,
        ));
  }
}

class UserItem extends StatefulWidget {
  final User user;
  final List<User> users;

  const UserItem({Key? key, required this.user, required this.users})
      : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem>
    with AutomaticKeepAliveClientMixin<UserItem>, TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    //  _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = BlocProvider.of<UsersPickBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: FadeTransition(
            opacity: _animation,
            child: SizeTransition(
                sizeFactor: _animation,
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          border: Border.all(
                            color: text.withAlpha(50),
                          ),
                        ),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Avatar(
                                      picture: widget.user.avatar,
                                      name: widget.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: Container()),
                                  CustomIconButton(
                                      icon: Icons.close_rounded,
                                      message: 'Supprimer',
                                      color: Colors.redAccent,
                                      onTap: () async {
                                        await _controller.reverse();
                                        bloc.remove(widget.users, widget.user);
                                        userBloc.fetch();
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )))));
  }
}

class AddUser extends StatefulWidget {
  final List<User> users;
  const AddUser({Key? key, required this.users}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser>
    with AutomaticKeepAliveClientMixin<AddUser> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UserBloc>(context);
    super.initState();
    bloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final usersPickBloc = BlocProvider.of<UsersPickBloc>(context);

    super.build(context);
    return StreamBuilder<List<User>>(
        stream: bloc.userStream,
        builder: (context, snapshot) {
          return CustomListPopupMenuButton<User>(
              containerHeight: 50,
              offset: Offset(0, 52),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      SvgPicture.asset(
                        "icons/dashed_circle.svg",
                        color: text,
                        width: 30,
                        height: 30,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: SvgPicture.asset(
                            "icons/user.svg",
                            color: text,
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Ajouter un participant",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )
                  ]),
              enabled: true,
              onSelected: (value) {
                if (!widget.users.contains(value)) {
                  usersPickBloc.add(widget.users, value);
                  bloc.fetch();
                }
              },
              itemBuilder: (context) {
                if (snapshot.hasData) {
                  var results = snapshot.data;
                  return results!.where((element) => !widget.users.contains(element)).map((choice) {
                    return CustomListPopupMenuItem(
                      value: choice,
                      height: 50,
                      child: PopupMenuItem(user: choice,)
                    );
                  }).toList();
                } else
                  return [];
              });
        });
  }
}

class PopupMenuItem extends StatefulWidget {
  final User user;
  const PopupMenuItem({Key? key, required this.user}) : super(key: key);

  @override
  _PopupMenuItemState createState() => _PopupMenuItemState();
}

class _PopupMenuItemState extends State<PopupMenuItem> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEvent event) => setState(() => isHover = true),
      onExit: (PointerEvent event) => setState(() => isHover = false),
      child: SizedBox(
        width: 460,
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Avatar(
                    name: widget.user.name,
                    picture: widget.user.avatar)),
            Text(
              widget.user.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            Expanded(child: Container()),
            Visibility(visible: isHover, child: Icon(Icons.add , color: active, size: 17,)),
            SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}
