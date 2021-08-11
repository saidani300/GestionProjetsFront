import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/BLoC/pick_users_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/add_user.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/dialogs/forms/widgets/time_picker.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';

import 'widgets/add_attachments.dart';

//TODO: "Create Another one" Checkbox

class CreateMeetingForm extends StatefulWidget {
  final Meeting meeting;

  const CreateMeetingForm({Key? key, required this.meeting}) : super(key: key);

  @override
  _CreateMeetingFormState createState() => _CreateMeetingFormState();
}

class _CreateMeetingFormState extends State<CreateMeetingForm>
    with AutomaticKeepAliveClientMixin<CreateMeetingForm> {
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
        child: BlocProvider<UsersPickBloc>(
            bloc: UsersPickBloc(),
            child: BlocProvider<UserBloc>(
                bloc: UserBloc(),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Divider(
                                height: 1,
                                color: dividerColor,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Scrollbar(
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Text(
                                              "Titre",
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: FormTextField(
                                            seText: (String value) {
                                              widget.meeting.name = value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Text(
                                              "Date",
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: DatePickerWidget(
                                            height: 40,
                                            setDate: (DateTime date) {
                                              widget.meeting.date = date;
                                            },
                                            initDate: widget.meeting.date,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Text(
                                              "Heure",
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TimePickerWidget(
                                            height: 40,
                                            setTime: (TimeOfDay time) {
                                              widget.meeting.time =
                                                  time.format(context);
                                            },
                                            initTime:
                                                TimeOfDay(hour: 8, minute: 0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Text(
                                              "Participants",
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Users(
                                              users:
                                                  widget.meeting.participants),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Attachments(
                                            documents: widget.meeting.documents,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Text(
                                              "Commentaire",
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                              child: MultiLinesTextFieldWidget(
                                            onChange: (value) {
                                              widget.meeting.comment = value;
                                            },
                                            hintText:
                                                "Ajouter un commentaire à cette réunion...",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Divider(
                                height: 1,
                                color: dividerColor,
                              ),
                            )
                          ]),
                    )))));
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
              "icons/Project_menu_icons/calendar_icon_filled.svg",
              color: white,
              width: 16,
              height: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer une réunion",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer une réunion',
              onTap: () {})
        ]));
  }
}
