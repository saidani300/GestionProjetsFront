import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_type_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

class AddProjectType extends StatefulWidget {
  const AddProjectType({
    Key? key,
  }) : super(key: key);

  @override
  _AddProjectTypeState createState() => _AddProjectTypeState();
}

class _AddProjectTypeState extends State<AddProjectType>
    with AutomaticKeepAliveClientMixin<AddProjectType> {
  bool _isAddTypeClosed = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = BlocProvider.of<ProjectTypeBloc>(context);
    var controller = TextEditingController();
    final styleHint = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              child: Text(
                "Type de projet",
                style: TextStyle(
                    color: text, fontSize: 11.5, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(child: Container()),
            CustomIconButton(
                icon: Icons.add_circle_rounded,
                size: 17,
                message: "Ajouter",
                onTap: () {
                  setState(() {
                    if (_isAddTypeClosed = true) {
                      _isAddTypeClosed = false;
                    }
                  });
                })
          ],
        ),
        AnimatedCrossFade(
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
          firstChild: Container(),
          secondChild: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 42,
                  padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: dividerColor, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: white,
                          child: TextFormField(
                            cursorWidth: 1.5,
                            controller: controller,
                            decoration: InputDecoration(
                                hintStyle: styleHint,
                                hintText: "Nom du type de projet",
                                isDense: true,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            style: TextStyle(
                                color: text,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      CustomIconButton(
                        icon: Icons.highlight_remove_rounded,
                        message: "Annuler",
                        onTap: () {
                          setState(() {
                            _isAddTypeClosed = true;
                          });
                        },
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CustomIconButton(
                          icon: Icons.add_circle_outline_rounded,
                          message: "Ajouter",
                          onTap: () {
                            if (controller.value.text.isNotEmpty) {
                              bloc.add(new ProjectType(Random().nextInt(999999),
                                  controller.value.text));
                              setState(() {
                                _isAddTypeClosed = true;
                              });
                            }
                          },
                          size: 20),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  )),
            ],
          ),
          crossFadeState: _isAddTypeClosed
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
