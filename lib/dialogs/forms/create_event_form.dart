import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import '../add_attachments.dart';


//TODO: "Create Another one" Checkbox



class CreateEventForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController sourceController;
  final TextEditingController causeController;
  final TextEditingController impactController;
  final Event event;
  const CreateEventForm({Key? key,required this.nameController ,
    required this.event,required this.sourceController,
    required this.causeController,required this.impactController,
    required this.descriptionController}) : super(key: key);
  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> with AutomaticKeepAliveClientMixin<CreateEventForm>{
  List<Document> documents = [];
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<UploadBloc>(
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
                              children: [
                            SizedBox(
                            height: 20,
                          ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: EventTypeBox(event: widget.event,),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    child: Text(
                                      "Nom",
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
                                        widget.event.name = widget.nameController.value.text;
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
                                      "Type",
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
                              child: EventCategoryBox(event: widget.event,)),
                              //EventTypeBox(event: widget.event,)),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    child: Text(
                                      "Niveau",
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
                                    child: EventLevelBox(event: widget.event,)),
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
                                  child: Attachments(documents: widget.event.documents,
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
                                        onChange: (value){widget.event.description = value;},
                                        hintText:
                                        "Ajoutez plus d'informations...", descriptionController: widget.descriptionController,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Source",
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(width: 5,),
                                        CustomIconButton(icon: Icons.info_outline, message: "Source", onTap: (){})
                                      ],
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
                                        onChange: (value){widget.event.source = value;},
                                        hintText: ""
                                        , descriptionController: widget.sourceController,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Cause",
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(width: 5,),
                                        CustomIconButton(icon: Icons.info_outline, message: "Cause", onTap: (){})
                                      ],
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
                                        onChange: (value){widget.event.cause = value;},
                                        hintText: ""
                                        , descriptionController: widget.causeController,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Impact",
                                          style: TextStyle(
                                              color: text,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(width: 5,),
                                        CustomIconButton(icon: Icons.info_outline, message: "Impact", onTap: (){})
                                      ],
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
                                        onChange: (value){widget.event.impact = value;},
                                        hintText: ""
                                        , descriptionController: widget.impactController,
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

class EventTypeBox extends StatefulWidget {
  final Event event;
  const EventTypeBox({Key? key,required this.event}) : super(key: key);

  @override
  _EventTypeBoxState createState() => _EventTypeBoxState();


}

class _EventTypeBoxState extends State<EventTypeBox> with AutomaticKeepAliveClientMixin<EventTypeBox>{
  EventType selectedType = EventType.Opportunity;


  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<EventType>(
                containerHeight: 40,
                offset: Offset(0, 42),
                child:Row( mainAxisSize: MainAxisSize.min,
                  children: [
                    eventTypeAsObject(selectedType).icon,
                    SizedBox(width: 10,),
                    Text(eventTypeAsObject(selectedType).name ,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      )),
                  ],
                ),
                enabled: true,
                onSelected: (value) {
                  setState(() {
                    selectedType = value;
                  });
                  widget.event.eventType = value;
                },
                itemBuilder: (context) {
                  return EventType.values.map((e) =>
                      CustomListPopupMenuItem(
                        value: e,
                        height: 50,
                        child: SizedBox(
                            width: 460,
                            child: Padding(
                                padding: EdgeInsets
                                    .only(
                                    left: 10),
                                child: Row( mainAxisSize: MainAxisSize.min,
                                  children: [
                                    eventTypeAsObject(e).icon,
                                    SizedBox(width: 10,),
                                    Text(eventTypeAsObject(e).name ,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),)),
                      )).toList();

          });
  }
}


class EventLevelBox extends StatefulWidget {
  final Event event;
  const EventLevelBox({Key? key,required this.event}) : super(key: key);

  @override
  _EventLevelBoxState createState() => _EventLevelBoxState();


}

class _EventLevelBoxState extends State<EventLevelBox> with AutomaticKeepAliveClientMixin<EventLevelBox>{
  EventLevel selectedLevel = EventLevel.low;


  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<EventLevel>(
          containerHeight: 40,
          offset: Offset(0, 42),
          child:Row( mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle , size: 20, color: eventLevelAsObject(widget.event.eventType , selectedLevel).color,) ,
              SizedBox(width: 10,),
              Text(eventLevelAsObject(widget.event.eventType , selectedLevel).name ,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  )),
            ],
          ),
          enabled: true,
          onSelected: (value) {
            setState(() {
              selectedLevel = value;
            });
            widget.event.level = value;
          },
          itemBuilder: (context) {
            return EventLevel.values.map((e) =>
                CustomListPopupMenuItem(
                  value: e,
                  height: 50,
                  child: SizedBox(
                      width: 460,
                      child: Padding(
                        padding: EdgeInsets
                            .only(
                            left: 10),
                        child: Row( mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle , size: 20, color: eventLevelAsObject(widget.event.eventType , e).color,) ,
                            SizedBox(width: 10,),
                            Text(eventLevelAsObject(widget.event.eventType , e).name ,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                )),
                          ],
                        ),)),
                )).toList();

          });
  }
}


class EventCategoryBox extends StatefulWidget {
  final Event event;
  const EventCategoryBox({Key? key,required this.event}) : super(key: key);

  @override
  _EventCategoryBoxState createState() => _EventCategoryBoxState();


}

class _EventCategoryBoxState extends State<EventCategoryBox> with AutomaticKeepAliveClientMixin<EventCategoryBox>{
  EventCategory selectedCategory = EventCategory.category1;


  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<EventCategory>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(categoryAsText(selectedCategory) ,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                )),
        enabled: true,
        onSelected: (value) {
          setState(() {
            selectedCategory = value;
          });
          widget.event.category = value;
        },
        itemBuilder: (context) {
          return EventCategory.values.map((e) =>
              CustomListPopupMenuItem(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                ),
                value: e,
                height: 50,
                child: SizedBox(
                    width: 460,
                    child: Padding(
                      padding: EdgeInsets
                          .only(
                          left: 10),
                      child: Text(categoryAsText(e) ,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                              )),
                      )),
              )).toList();

        });
  }
}