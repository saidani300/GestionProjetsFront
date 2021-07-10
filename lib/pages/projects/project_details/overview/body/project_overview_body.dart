import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/open_close_animated_arrow.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/phase_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';

class ProjectOverviewHeader extends StatelessWidget {
  const ProjectOverviewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.layers_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Développement d'une nouvelle interface utilisateur",
          style: TextStyle(
              color: text,
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
        //OpenCloseArrowButton(isExpanded : false , onTap: (){},),
        Expanded(child: Container()),
        TextButton.icon(
          style: ButtonStyle(
            fixedSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 40)),
            // backgroundColor: MaterialStateProperty.all<Color>(active),
            backgroundColor:
                MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.hovered)) {
                return buttonHover;
              } else {
                return active;
              }
            }),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
          ),
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Créer un projet',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}

class ProjectOverviewBody extends StatefulWidget {
  const ProjectOverviewBody({Key? key}) : super(key: key);

  @override
  _ProjectOverviewBodyState createState() => _ProjectOverviewBodyState();
}

class _ProjectOverviewBodyState extends State<ProjectOverviewBody> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectOverviewHeader(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: lightGrey.withOpacity(0.3), width: 1,),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      // offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(3),
                  color: backgroundColor,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              topRight: Radius.circular(3),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                        color: Colors.white,),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ShowByStatusItems.map(
                            (e) => Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ShowByStatusItem(
                                    itemName: e.name, onTap: () {})),
                          ).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher des projets...',
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.save_alt_rounded,
                            message: 'Exporter',
                            onTap: () {}),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          icon: Icons.filter_alt_outlined,
                          message: 'Filter',
                          onTap: () { },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                  Expanded(child: Container( child: ListView(
                      controller: controller,
                      shrinkWrap: true,
                      children: [
                        PhaseItem(),
                        PhaseItem(),
                      ],
                    ))),

                    //Expanded(child: Container()),
                  ],
                )),
          ),
        )
      ],
    );
  }
}
