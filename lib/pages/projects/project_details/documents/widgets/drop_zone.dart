import 'dart:html';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/service/upload.dart';
import 'package:lottie/lottie.dart';



class FileDropZone extends StatefulWidget {
  const FileDropZone({Key? key}) : super(key: key);

  @override
  _FileDropZoneState createState() => _FileDropZoneState();
}

class _FileDropZoneState extends State<FileDropZone> with TickerProviderStateMixin{
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
    final bloc = BlocProvider.of<DocumentBloc>(context);
    return
         DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: [3,2],
            strokeWidth: 1,
            color:highlight? active : text.withOpacity(0.4),
            radius: Radius.circular(2),
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              child:
                  Container(
                child : Padding( padding: EdgeInsets.all(10) , child : Stack(
                  children: [
                new Positioned.fill(
                child:  DropzoneView(onDrop: (value) async {
                  File file = value as File;
                  var  bytes;
                bytes = await compute(controller.getFileData,value);
               // print(bytes);
                 Document document =  new Document(new Random().nextInt(9999), file.name, "0", file.name, users.last, DateTime.now(), file.size, false);
                await  bloc.documentUpload(document, bytes);

                _controller.reset();
                setState(()=> highlight = false);},

                  onHover:() {
                  _controller..duration = _composition.duration..repeat();
                  setState(()=> highlight = true);
                  },
                  onLeave: () {

                   _controller.reset();
                   setState(()=> highlight = false);
                  },
                  onCreated: (controller) => this.controller = controller,
                   )),
                    Row(mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'icons/upload-mainColor.json',
                    controller: _controller,
                    repeat: true,
                    height: 60,
                    width: 60,
                    onLoaded: (composition) {
                     _composition = composition;
                    },
                  ),

                  SizedBox(width: 20,),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Glisser-déplacer pour ajouter',
                            style: TextStyle(
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' ,faites glisser des fichiers depuis vote appareil ou ',
                            style: TextStyle(
                              height: 1.5,
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: 'parcourir',
                            style: TextStyle(
                                color: active,
                                height: 1.5,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = () async {
                              final events = await controller.pickFiles( multiple: true);
                              if(events.isEmpty) return;
                              events.forEach((element) {acceptFile(element , context);});
                            },
                          ),
                          TextSpan(
                            text: ",  puis insérez-les ici pour les ajouter aux documents.",
                            style: TextStyle(
                                color: text,
                                height: 1.5,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                )
              ]),

          ),


    )));
  }

  Future acceptFile(dynamic value , BuildContext context) async {
    final bloc = BlocProvider.of<DocumentBloc>(context);
    File file = value as File;
    var bytes;
    bytes = await compute(controller.getFileData, value);
    Document document =  new Document(new Random().nextInt(9999), file.name, "0", file.name, users.last, DateTime.now(), file.size, false);
    await  bloc.documentUpload(document, bytes);
    _controller.reset();
    setState(() => highlight = false);
  }
}
