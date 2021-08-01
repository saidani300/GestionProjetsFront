import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';

class UserPicker extends StatefulWidget {
  final Function(User value) onChange;

  const UserPicker({Key? key, required this.onChange}) : super(key: key);

  @override
  _UserPickerState createState() => _UserPickerState();
}

class _UserPickerState extends State<UserPicker>
    with AutomaticKeepAliveClientMixin<UserPicker> {
  User user = users.first;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<User>(
        containerHeight: 50,
        offset: Offset(0, 52),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(name: user.name, picture: user.avatar),
              SizedBox(
                width: 10,
              ),
              Text(
                user.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              )
            ]),
        enabled: true,
        onSelected: (value) {
          setState(() {
            user = value;
            widget.onChange(value);
            // widget.projectUser = value;
          });
        },
        itemBuilder: (context) {
          return users.map((User choice) {
            return CustomListPopupMenuItem(
              value: choice,
              height: 50,
              child: SizedBox(
                  width: 460,
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Avatar(
                              name: choice.name, picture: choice.avatar)),
                      Text(
                        choice.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )),
            );
          }).toList();
        });
  }
}
