import 'dart:html';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:lottie/lottie.dart';

class Attachments extends StatefulWidget {
  final List<Document> documents;

  const Attachments({Key? key, required this.documents}) : super(key: key);

  @override
  _AttachmentsState createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments>
    with AutomaticKeepAliveClientMixin<Attachments> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UploadBloc>(context);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FileDropZone(
          documents: widget.documents,
        ),
        StreamBuilder<List<Document>>(
            stream: bloc.uploadStream,
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
                                padding: const EdgeInsets.only(top: 10),
                                child: _buildFolder(widget.documents, e),
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

  Widget _buildFolder(List<Document> documents, Document document) {
    return TestProxy(
        key: ValueKey(document),
        child: new FileItem(
          document: document,
          documents: documents,
        ));
  }
}

class FileItem extends StatefulWidget {
  final Document document;
  final List<Document> documents;

  const FileItem({Key? key, required this.document, required this.documents})
      : super(key: key);

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem>with AutomaticKeepAliveClientMixin<FileItem>  , TickerProviderStateMixin {
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
    super.build(context);
    final bloc = BlocProvider.of<UploadBloc>(context);

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
                      //color: backgroundColor,
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file_rounded,
                                  size: 15,
                                  color: active,
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
                        ),
                        SizedBox(
                          width: widget.document.isUploaded ? 5 : 10,
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
                                        _controller.reverse().whenComplete(() =>
                                            bloc.removeDocument(
                                                widget.documents,
                                                widget.document));
                                      })
                                  : Container(
                                      height: 30,
                                      width: 30,
                                      child: Stack(children: [
                                        Lottie.asset(
                                          'icons/59912-loading-circle.json',
                                          animate: true,
                                          repeat: true,
                                          height: 30,
                                          width: 30,
                                        ),
                                        Center(
                                            child: Container(
                                                height: 30,
                                                width: 30,
                                                child: CustomIconButton(
                                                    icon: Icons.close_rounded,
                                                    size: 15,
                                                    color: lightRed,
                                                    message: "Annuler",
                                                    onTap: () {
                                                      _controller
                                                          .reverse()
                                                          .whenComplete(() =>
                                                              bloc.removeDocument(
                                                                  widget
                                                                      .documents,
                                                                  widget
                                                                      .document));
                                                    })))
                                      ])),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: widget.document.isUploaded ? 10 : 5,
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}

class FileDropZone extends StatefulWidget {
  final List<Document> documents;

  const FileDropZone({Key? key, required this.documents}) : super(key: key);

  @override
  _FileDropZoneState createState() => _FileDropZoneState();
}

class _FileDropZoneState extends State<FileDropZone>
    with TickerProviderStateMixin {
  late DropzoneViewController controller;
  late final AnimationController _controller;
  late LottieComposition _composition;
  bool highlight = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UploadBloc>(context);
    return DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: [3, 2],
        strokeWidth: 1,
        color: highlight ? active : text.withAlpha(100),
        radius: Radius.circular(2),
        padding: EdgeInsets.all(2),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            child: Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(children: [
                  new Positioned.fill(
                      child: DropzoneView(
                    onDrop: (value) async {
                      FocusManager.instance.primaryFocus!.unfocus();
                      File file = value as File;
                      var bytes;
                      bytes = await compute(controller.getFileData, value);
                      Document document = new Document(
                          new Random().nextInt(9999),
                          file.name,
                          "0",
                          file.name,
                          User(45, "Saidani Wael", "3"),
                          DateTime.now(),
                          file.size,
                          false);
                      await bloc.documentUpload(
                          widget.documents, document, bytes);
                      _controller.reset();
                      setState(() => highlight = false);
                    },
                    onHover: () {
                      _controller
                        ..duration = _composition.duration
                        ..repeat();
                      setState(() => highlight = true);
                    },
                    onLeave: () {
                      _controller.reset();
                      setState(() => highlight = false);
                    },
                    onCreated: (controller) => this.controller = controller,
                  )),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Glisser-déplacer pour ajouter, ou ',
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: 'parcourir',
                                  style: TextStyle(
                                      color: active,
                                      height: 1.5,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      FocusManager.instance.primaryFocus!.unfocus();
                                      final events = await controller.pickFiles(
                                          multiple: true);
                                      if (events.isEmpty) return;
                                      events.forEach((element) {
                                        acceptFile(element, context);
                                      });
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            )));
  }

  Future acceptFile(dynamic value, BuildContext context) async {
    final bloc = BlocProvider.of<UploadBloc>(context);
    File file = value as File;
    var bytes;
    bytes = await compute(controller.getFileData, value);
    Document document = new Document(
        new Random().nextInt(9999),
        file.name,
        "0",
        file.name,
        User(45, "Saidani Wael", "3"),
        DateTime.now(),
        file.size,
        false);
    await bloc.documentUpload(widget.documents, document, bytes);
    _controller.reset();
    setState(() => highlight = false);
  }
}
