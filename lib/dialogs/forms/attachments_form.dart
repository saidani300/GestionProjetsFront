import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';



class AttachmentsForm extends StatefulWidget {
  final List<Document> documents;

  const AttachmentsForm({Key? key, required this.documents}) : super(key: key);

  @override
  _AttachmentsFormState createState() => _AttachmentsFormState();
}

class _AttachmentsFormState extends State<AttachmentsForm>
    with AutomaticKeepAliveClientMixin<AttachmentsForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
                    width: 500,
                    constraints: BoxConstraints(maxHeight: 522),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormHeader(count: widget.documents.length,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Divider(
                              height: 1,
                              color: dividerColor,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Text('Nom',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textStyle_Text_12_500)),
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
                                              child: Text('Taille',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: textStyle_Text_12_500)),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Container(
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                             ListView(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    children: widget.documents.map((e) => Padding(padding: EdgeInsets.only(left: 20 , right: 20 , bottom: 3), child:
                                    FileItem(document: e,)
                                      ,)).toList()),
                          SizedBox(height: 17,),
                        ]),
    );
  }
}

class FormHeader extends StatelessWidget {
  final int count;
  const FormHeader({Key? key , required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      child: Row(children: [
        Text(
          "Pièces jointes",
          style: TextStyle(
              color: text, fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
        Text(
          " ($count)",
          style: TextStyle(
              color: active, fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
      ]),
    );
  }
}

class FileItem extends StatefulWidget {
  final Document document;

  const FileItem({Key? key, required this.document})
      : super(key: key);

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem>{

  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                    child: Text(formatBytes(widget.document.size, 0),
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                        Container(
                          width: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: Container()),
                              CustomIconButton(
                                  icon: Icons.download_rounded,
                                  message: 'Télécharger',
                                  onTap: () {
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
  }
}