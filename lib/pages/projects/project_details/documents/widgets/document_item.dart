import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../locator.dart';

class DocumentItem extends StatefulWidget {
  final Function() onTap;
  final Document document;
  final Folder folder;
  const DocumentItem(
      {Key? key,
      required this.document,
      required this.folder,
      required this.onTap})
      : super(key: key);

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem>
    with AutomaticKeepAliveClientMixin<DocumentItem>, TickerProviderStateMixin {
  String getDateAsText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DocumentBloc>(context);
    super.build(context);
    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child: Column(children: [
                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () async {
                      print("tapped");
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "icons/document.svg",
                                    color: active,
                                    width: 17,
                                    height: 17,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Text(widget.document.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(formatBytes(widget.document.size,2),
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(getDateAsText(widget.document.creationDate),
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Avatar(
                                      picture: widget.document.user.avatar,
                                      name: widget.document.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.document.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            flex: 2,
                          ),
                          // ActionsMenu(),
                          SizedBox(
                            width:widget.document.isUploaded
                                ? 10 : 20,
                          ),
                          Container(
                            width: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: Container()),
                                widget.document.isUploaded
                                    ? CustomIconButton(
                                        icon: Icons.delete_forever_rounded,
                                        message: 'Supprimer',
                                        color: Colors.redAccent,
                                        onTap: () {
                                          deleteDialogBox(context,() => _controller.reverse().whenComplete(() => bloc.removeDocument(widget.folder, widget.document)), DeleteType.file ,widget.document.name);
                                          //showDialogBox(context, onTap);
                                        })
                                    : Container(
                                  height: 40,
                                  width: 40,
                                      child: Stack(
                                        children :[ Lottie.asset(
                                  'icons/59912-loading-circle.json',
                                  animate: true,
                                  repeat: true,
                                  height: 40,
                                  width: 40,
                                ),
                                        Center(child: Container( height: 40,
                                            width: 40,
                                            child: CustomIconButton(icon: Icons.close_rounded, color: lightRed, message: "Annuler", onTap: (){_controller.reverse().whenComplete(() => bloc.removeDocument(widget.folder, widget.document));})))
                                        ]
                                      ),
                                    ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: widget.document.isUploaded
                                ? 20 :10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 60,)
                ]))));
  }
}
