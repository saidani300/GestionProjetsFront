import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';

class PriorityBox extends StatefulWidget {
  final Function(Priority priority) setPriority;

  const PriorityBox({Key? key, required this.setPriority}) : super(key: key);

  @override
  _PriorityBoxState createState() => _PriorityBoxState();
}

class _PriorityBoxState extends State<PriorityBox>
    with AutomaticKeepAliveClientMixin<PriorityBox> {
  Priority priority = Priority.Normal;

  @override
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomListPopupMenuButton<Priority>(
          containerHeight: 40,
          offset: Offset(0, 42),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PriorityIcon(
                  priority: priority,
                ),
                SizedBox(
                  width: 10,
                ),
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
            });
            widget.setPriority(value);
          },
          itemBuilder: (context) {
            return Priority.values.map((Priority choice) {
              return CustomListPopupMenuItem(
                value: choice,
                height: 50,
                child: SizedBox(
                    width: 460,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: PriorityIcon(
                            priority: choice,
                          ),
                        ),
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
