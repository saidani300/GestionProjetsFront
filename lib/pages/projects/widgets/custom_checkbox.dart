import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/check_box_item.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';

//bool isItemChecked = false;
//bool isAllChecked = false;
class CustomCheckBox extends StatefulWidget {
  final CheckBoxItem item;

  const CustomCheckBox({Key? key, required this.item}) : super(key: key);
  @override
  CustomCheckBoxState createState() => new CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  initState() {
    //isItemChecked = widget.item.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: active,
            value: widget.item.value,
            title: Text(
              widget.item.title,
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                widget.item.value = value!;
                checkAll.value = typesList.every((element) => element.value);
              });
            }));
  }
}

class CustomCheckAllBox extends StatefulWidget {
  final CheckBoxItem allItems;

  const CustomCheckAllBox({Key? key, required this.allItems}) : super(key: key);
  @override
  CustomCheckAllBoxState createState() => new CustomCheckAllBoxState();
}

class CustomCheckAllBoxState extends State<CustomCheckAllBox> {
  @override
  initState() {
    // isAllChecked = widget.allItems.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: active,
            value: widget.allItems.value,
            title: Text(
              widget.allItems.title,
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (bool? value) {
              if (value == null) return;
              setState(() {
                widget.allItems.value = value;
                typesList.forEach((type) {
                  type.value = value;
                });
              });
            }));
  }
}
////////Project Learders

class CustomCheckBoxLeader extends StatefulWidget {
  final CheckBoxItemLeader item;

  const CustomCheckBoxLeader({Key? key, required this.item}) : super(key: key);
  @override
  CustomCheckBoxLeaderState createState() => new CustomCheckBoxLeaderState();
}

class CustomCheckBoxLeaderState extends State<CustomCheckBoxLeader> {
  @override
  initState() {
    //isItemChecked = widget.item.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: active,
            value: widget.item.value,
            secondary: Container(
                height: 25,
                width: 25,
                child: CircleAvatar(
                  child: Text(profileInitials(widget.item.name),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                          letterSpacing: 1)),
                  foregroundColor: Colors.white,
                  backgroundColor:
                      colors[int.tryParse(widget.item.profileImage) ?? 0],
                )),
            title: Text(
              widget.item.name,
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                widget.item.value = value!;
                checkAllLeader.value =
                    typesList.every((element) => element.value);
              });
            }));
  }
}

class CustomCheckAllBoxLeader extends StatefulWidget {
  final CheckBoxItemLeader allItems;

  const CustomCheckAllBoxLeader({Key? key, required this.allItems})
      : super(key: key);
  @override
  CustomCheckAllBoxLeaderState createState() =>
      new CustomCheckAllBoxLeaderState();
}

class CustomCheckAllBoxLeaderState extends State<CustomCheckAllBoxLeader> {
  @override
  initState() {
    // isAllChecked = widget.allItems.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: active,
            value: widget.allItems.value,
            title: Text(
              widget.allItems.name,
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (bool? value) {
              if (value == null) return;
              setState(() {
                widget.allItems.value = value;
                LeaderList.forEach((type) {
                  type.value = value;
                });
              });
            }));
  }
}
