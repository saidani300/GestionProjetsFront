import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/project_type_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../add_attachments.dart';


//TODO: "Create Another one" Checkbox



class CreateProjectForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  final Project project;
  const CreateProjectForm({Key? key,required this.nameController , required this.project,required this.descriptionController}) : super(key: key);
  @override
  _CreateProjectFormState createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> with AutomaticKeepAliveClientMixin<CreateProjectForm>{
  List<Document> documents = [];
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);


    return BlocProvider<ProjectTypeBloc>(
        bloc: ProjectTypeBloc(),
    child: BlocProvider<UploadBloc>(
        bloc: UploadBloc(),
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
                Expanded(
                  child: Center(
                    child:
                        Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,

                          child: ListView(shrinkWrap: true,
                              controller: scrollController,
                              // mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Nom du projet",
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
                              child: Container(
                                height: 40,
                                child: TextFormField(
                                  // initialValue: projectName,
                                  cursorWidth: 1.5,
                                  controller: widget.nameController,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(3)),
                                        borderSide: BorderSide(
                                            color: text.withAlpha(50),
                                            width: 1.2),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(3)),
                                        borderSide: const BorderSide(
                                            color: active, width: 1.2),
                                      )),
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  onChanged: (value) {
                                    widget.project.name = widget.nameController.value.text;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Type de projet",
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
                            ProjectTypeBox(project : widget.project),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  Row(mainAxisSize: MainAxisSize.max, children: [
                                Expanded(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date de début",
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DatePickerWidget(
                                          height: 40, project: widget.project, id:1
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: 20,
                                ),

                                Expanded(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date de fin",
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        new DatePickerWidget(
                                          height: 40, project: widget.project, id: 2,
                                        ),
                                      ]),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Chef d'équipe",
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
                              child: UserPicker(project: widget.project,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Priorité",
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
                           PriorityBox(project: widget.project,),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Pièces jointes",
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
                              child: Attachments(documents: widget.project.documents,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Description",
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
                              child: Container(
                                  child: MultiLinesTextFieldWidget(
                                    onChange: (value){},
                                hintText:
                                    "Ajoutez plus d'informations a ce projet...", descriptionController: widget.descriptionController,

                              )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                )
              ]),
        )));
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
            child: Icon(
              Icons.layers_rounded,
              size: 20,
              color: white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer un projet",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer un projet',
              onTap: () {})
        ]));
  }
}

class ProjectTypeBox extends StatefulWidget {
  final Project project;
  const ProjectTypeBox({Key? key,required this.project}) : super(key: key);

  @override
  _ProjectTypeBoxState createState() => _ProjectTypeBoxState();


}

class _ProjectTypeBoxState extends State<ProjectTypeBox> with AutomaticKeepAliveClientMixin<ProjectTypeBox>{

  late final bloc;
  ProjectType? selectedType = projectTypesList.first;

  @override
  void initState() {
    bloc = BlocProvider.of<ProjectTypeBloc>(context);
    super.initState();
    bloc.init();
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<List<ProjectType>>(
          stream: bloc.projectTypeStream,
          builder: (context, snapshot) {
            List<ProjectType>? results = snapshot.data;
            return CustomListPopupMenuButton<
                    ProjectType>(
                    containerHeight: 40,
                    offset: Offset(0, 42),
                    child: (snapshot.hasData)
                        ? Text(
                     snapshot.data!.isNotEmpty ? selectedType!.name : "",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ) : Container(),
                    enabled: true,
                    onSelected: (value) {
                      setState(() {
                        selectedType = value;
                      });
                      widget.project.type = value;
                    },
                    itemBuilder: (context) {
                      return (snapshot.hasData)
                          ?  results!.map((e) =>
                          CustomListPopupMenuItem(
                            value: e,
                            height: 50,
                            child: SizedBox(
                                width: 460,
                                child: Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          e.name,
                                          style:
                                          TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontFamily:
                                            'Montserrat',
                                            fontSize: 12,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        CustomIconButton(icon: Icons.close_rounded, message: "Supprimer", size: 15, color: lightRed, onTap: (){
                                          bloc.remove(e);
                                          if(selectedType == e)
                                            {
                                              setState(() {
                                                selectedType = results.first;
                                              });
                                            }
                                          Navigator.pop(context);
                                        }),
                                        SizedBox(width: 15,)
                                      ],
                                    ))),
                          )).toList() : [];
                    });
          }),
    );
  }
}


class PriorityBox extends StatefulWidget {
  final Project project;
  const PriorityBox({Key? key , required this.project}) : super(key: key);

  @override
  _PriorityBoxState createState() => _PriorityBoxState();
}

class _PriorityBoxState extends State<PriorityBox> {
  Priority priority = Priority.Normal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomListPopupMenuButton<Priority>(
          containerHeight: 40,
          offset: Offset(0, 42),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                PriorityIcon(priority: priority,),
                SizedBox(width: 10,),
                Text(
                  priorityAsText(priority),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                )
              ]),
          enabled: true,
          onSelected: (value) {
            setState(() {
              priority = value;
              widget.project.priority = value;
            });
          },
          itemBuilder: (context) {
            return Priority.values
                .map((Priority choice) {
              return CustomListPopupMenuItem(
                value: choice,
                height: 50,
                child: SizedBox(
                    width: 460,
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: PriorityIcon(priority: choice,),),
                        Text(
                          priorityAsText(choice),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )),
              );
            }).toList();
          }),
    );
  }


}

class UserPicker extends StatefulWidget {
  final Project project;
  const UserPicker({Key? key , required this.project}) : super(key: key);

  @override
  _UserPickerState createState() => _UserPickerState();
}

class _UserPickerState extends State<UserPicker> {
  User user = users.first;

  @override
  Widget build(BuildContext context) {
    return CustomListPopupMenuButton<User>(
        containerHeight: 50,
        offset: Offset(0, 52),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.center,
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
            widget.project.teamLeader = value;
          });
        },
        itemBuilder: (context) {
          return users.map(
                  (User choice) {
                return CustomListPopupMenuItem(
                  value: choice,
                  height: 50,
                  child: SizedBox(
                      width: 460,
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Avatar(name: choice.name, picture: choice.avatar)),
                          Text(
                            choice.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
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

class DatePickerWidget extends StatefulWidget {
  final Project project;
  final int id;
  final double height;
  DatePickerWidget(
      {Key? key,
        required this.height,
        required this.project,
        required this.id})
      : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

bool isHover = false;

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime date;

  String getDateAsText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

  @override
  void initState() {
    date = widget.project.id == 1 ? widget.project.startDate : widget.project.endDate;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return InkWell(
        enableFeedback: false,
        canRequestFocus: false,
        excludeFromSemantics: true,
        onTap: () => pickDate(context),
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHover: (value) {
          value
              ? setState(() {
            isHover = true;
          })
              : setState(() {
            isHover = false;
          });
        },
        child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: isHover ? active : text.withOpacity(0.35), width: 1.4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: Text(
                          getDateAsText(date),
                          style: TextStyle(
                              color: text,
                              fontSize: 12.5,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                        ))),
                Container(
                    width: 34,
                    child: Icon(
                      Icons.date_range_rounded,
                      color: active,
                      size: 18,
                    )),
              ],
            )));}

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (newDate == null)
    {return;}
    else {
      setState(() => date = newDate);
      widget.id==1 ?widget.project.startDate = newDate : widget.project.endDate = newDate;
    }
  }
}
