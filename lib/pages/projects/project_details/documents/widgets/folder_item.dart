import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/document_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

class FolderItem extends StatefulWidget {
  final Function() onTap;
  final Folder folder;

  const FolderItem({Key? key, required this.folder, required this.onTap})
      : super(key: key);

  @override
  _FolderItemState createState() => _FolderItemState();
}

class _FolderItemState extends State<FolderItem>
    with AutomaticKeepAliveClientMixin<FolderItem>, TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isHover = false;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
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
                    onTap: () {},
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onHover: (value) {
                      value
                          ? setState(() => isHover = true)
                          : setState(() => isHover = false);
                    },
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
                                    "icons/open-folder.svg",
                                    color: active,
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Text(widget.folder.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                      child: Text(
                                          '(${widget.folder.documents.length})',
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_active_12_600)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Visibility(
                                      visible: isHover,
                                      child: CustomIconButton(
                                        onTap: () {},
                                        message: 'Modifier',
                                        icon: Icons.edit_rounded,
                                        size: 13,
                                      ))
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          // ActionsMenu(),
                          SizedBox(
                            width: 10,
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
                                      deleteDialogBox(
                                          context,
                                          () => _controller
                                              .reverse()
                                              .whenComplete(() => bloc
                                                  .removeFolder(widget.folder)),
                                          DeleteType.folder,
                                          widget.folder.name);
                                      //showDialogBox(context, onTap);
                                    }),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.folder.documents.isNotEmpty
                      ? Divider(
                          height: 1,
                          color: dividerColor,
                        )
                      : Container(),
                  // Container(height: 60,)
                ]))));
  }
}
