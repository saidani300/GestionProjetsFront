import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/criterion_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

class Criteria extends StatefulWidget {
  final List<Criterion> criteria;

  const Criteria({Key? key, required this.criteria}) : super(key: key);

  @override
  _CriteriaState createState() => _CriteriaState();
}

class _CriteriaState extends State<Criteria>
    with AutomaticKeepAliveClientMixin<Criteria> {
  final abbreviationController = TextEditingController();
  final nameController = TextEditingController();
  var focusNode = FocusNode();
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CriterionBloc>(context);
    super.initState();
    bloc.init(widget.criteria);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
                width: 20,
              ),
              Expanded(
                child: TextField(
                    scrollPadding: EdgeInsets.all(0),
                    cursorWidth: 1.5,
                    focusNode: focusNode,
                    controller: abbreviationController,
                    decoration: InputDecoration(
                      hintText: "Abréviation",
                      border: InputBorder.none,
                    ),
                    style: textStyle_Text_12_500,
                    onChanged: (value) {}),
                flex: 1,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                    cursorWidth: 1.5,
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Désignation",
                      border: InputBorder.none,
                    ),
                    style: textStyle_Text_12_500,
                    onChanged: (value) {}),
                flex: 4,
              ),
              Container(
                width: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container()),
                    CustomIconButton(
                        icon: Icons.add_circle_rounded,
                        message: 'Ajouter',
                        color: active,
                        onTap: () {
                          bloc.addCriterion(
                              widget.criteria,
                              new Criterion(
                                  Random().nextInt(99999),
                                  nameController.value.text,
                                  0,
                                  abbreviationController.value.text));
                          nameController.clear();
                          abbreviationController.clear();
                          focusNode.requestFocus();
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
        SizedBox(
          height: 10,
        ),
        StreamBuilder<List<Criterion>>(
            stream: bloc.criterionStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: (snapshot.hasData)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: results!
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: _buildFolder(widget.criteria, e),
                              ),
                            )
                            .toList(),
                      )
                    : Container(),
              );
            }),
      ],
    );
  }

  Widget _buildFolder(List<Criterion> criteria, Criterion criterion) {
    return TestProxy(
        key: ValueKey(criterion),
        child: new CriterionItem(
          criteria: criteria,
          criterion: criterion,
        ));
  }
}

class CriterionItem extends StatefulWidget {
  final Criterion criterion;
  final List<Criterion> criteria;

  const CriterionItem(
      {Key? key, required this.criterion, required this.criteria})
      : super(key: key);

  @override
  _CriterionItemState createState() => _CriterionItemState();
}

class _CriterionItemState extends State<CriterionItem>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CriterionBloc>(context);

    return FadeTransition(
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
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(widget.criterion.abbreviation,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(widget.criterion.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                          ),
                          flex: 4,
                        ),
                        Container(
                          width: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: Container()),
                              CustomIconButton(
                                  icon: Icons.delete_forever_rounded,
                                  message: 'Supprimer',
                                  color: Colors.redAccent,
                                  onTap: () {
                                    _controller.reverse().whenComplete(() =>
                                        bloc.removeCriterion(
                                            widget.criteria, widget.criterion));
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
                ))));
  }
}
