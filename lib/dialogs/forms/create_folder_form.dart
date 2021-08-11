import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

//TODO: "Create Another one" Checkbox

class CreateFolderForm extends StatefulWidget {
  final Folder folder;

  const CreateFolderForm({Key? key, required this.folder}) : super(key: key);

  @override
  _CreateFolderFormState createState() => _CreateFolderFormState();
}

class _CreateFolderFormState extends State<CreateFolderForm>
    with AutomaticKeepAliveClientMixin<CreateFolderForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          width: 500,
          constraints: BoxConstraints(maxHeight: 522),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                ),
                Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  child: ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Text(
                              "Nom du dossier",
                              style: TextStyle(
                                  color: text,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FormTextField(
                            initText: widget.folder.name,
                            seText: (String value) {
                              widget.folder.name = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                )
              ]),
        ));
  }
}

class FormHeader extends StatelessWidget {
  const FormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: active,
            ),
            child: SvgPicture.asset(
              "icons/open-folder.svg",
              color: white,
              width: 16,
              height: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer un dossier",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer un dossier',
              onTap: () {})
        ]));
  }
}

class ObjectiveTypeBox extends StatefulWidget {
  final Objective objective;

  const ObjectiveTypeBox({Key? key, required this.objective}) : super(key: key);

  @override
  _ObjectiveTypeBoxState createState() => _ObjectiveTypeBoxState();
}

class _ObjectiveTypeBoxState extends State<ObjectiveTypeBox>
    with AutomaticKeepAliveClientMixin<ObjectiveTypeBox> {
  ObjectiveType selectedType = ObjectiveType.type1;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<ObjectiveType>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(
          objectiveTypeAsText(selectedType),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        enabled: true,
        onSelected: (value) {
          setState(() {
            selectedType = value;
          });
          widget.objective.type = value;
        },
        itemBuilder: (context) {
          return ObjectiveType.values
              .map((e) => CustomListPopupMenuItem(
                    value: e,
                    height: 50,
                    child: SizedBox(
                        width: 460,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            objectiveTypeAsText(e),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        )),
                  ))
              .toList();
        });
  }
}
