import 'dart:math';
import 'dart:ui';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/widgets/document_item.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/widgets/drop_zone.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/widgets/folder_item.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

class DocumentsHeader extends StatelessWidget {
  final ScrollController scrollController;

  const DocumentsHeader({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DocumentBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().projectGoBack();
          },
          child: Text("Projets", style: textStyle_active_12_600),
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Développement d'une nouvelle interface utilisateur",
            style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Documents", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Documents",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Ajouter un dossier",
          isMultiple: false,
          onTap: () {
            bloc.addFolder(
                new Folder(new Random().nextInt(99999), "Dossier", []));

            if (scrollController.hasClients)
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 300),
              );
          },
        ),
      ],
    );
  }
}

class DocumentsBody extends StatefulWidget {
  const DocumentsBody({Key? key}) : super(key: key);

  @override
  _DocumentsBodyState createState() => _DocumentsBodyState();
}

class _DocumentsBodyState extends State<DocumentsBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DocumentsHeader(scrollController: scrollController),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: lightGrey.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                  ),
                ],
                borderRadius: BorderRadius.circular(3),
                color: white,
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    color: white,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    SearchWidget(
                      hintText: 'Recherche des documents...',
                      onChanged: (value) {},
                      width: 190,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(child: Container()),

                    SizedBox(
                      width: 15,
                    ),
                    CustomIconButton(
                        icon: Icons.save_alt_rounded,
                        message: 'Exporter',
                        onTap: () {
                          /*  bloc.fetch();*/
                        }),
                    SizedBox(
                      width: 15,
                    ),
                    CustomIconButton(
                      icon: Icons.filter_alt_outlined,
                      message: 'Filter',
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ]),
                ),
                Divider(
                  height: 1,
                  color: dividerColor,
                ),
                DocumentsListHeader(),
              ]),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20), child: FileDropZone()),
        Divider(
          height: 1,
          color: dividerColor,
        ),
        Expanded(
            child: DocumentsList(
          parentContext: context,
          scrollController: scrollController,
        )),
        Divider(
          height: 1,
          color: dividerColor,
        ),
      ],
    );
  }
}

class DocumentsList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const DocumentsList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _DocumentsListState createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DocumentBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Folder>>(
            stream: bloc.documentStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.length == 1 &&
                              results.first.documents.isEmpty)
                          //TODO:Change empty list widget
                          ? NoItems(
                              icon: "icons/no-phase.svg",
                              message:
                                  "Il n'y a aucun document à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en ajouter un nouveau.",
                              title: "Aucun document trouvé",
                              buttonText: "Ajouter")
                          : DragAndDropLists(
                              contentsWhenEmpty: Container(),
                              key: ValueKey(Random.secure()),
                              scrollController: widget.scrollController,
                              lastListTargetSize: 0,
                              listPadding: EdgeInsets.only(bottom: 30),
                              listInnerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              children: results
                                  .skipWhile((element) => (element.id == 1 &&
                                      element.documents.isEmpty))
                                  .map(buildList)
                                  .toList(),
                              itemDivider: Divider(
                                  thickness: 1, height: 1, color: dividerColor),
                              lastItemTargetHeight: 10,
                              itemDecorationWhileDragging: BoxDecoration(
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                              ),
                              onItemReorder: onItemReorder,
                              onListReorder:
                                  (int oldListIndex, int newListIndex) {},
                              // listDragHandle: buildDragHandle(isList: true),
                              itemDragHandle: buildDragHandle(),
                            )
                      : Center(
                          child: SpinKitFadingCube(
                            color: active,
                            size: 25,
                            duration: Duration(milliseconds: 1200),
                          ),
                        ));
            }));
  }

  void onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    if (!identical(oldListIndex, newListIndex))
      bloc.replaceAt(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      onLeft: true,
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(left: 4),
        child: Icon(
          Icons.drag_indicator_rounded,
          color: color,
          size: 17,
        ),
      ),
    );
  }

  DragAndDropList buildList(Folder folder) => DragAndDropList(
        contentsWhenEmpty:
            Divider(thickness: 1, height: 1, color: dividerColor),
        header: folder.id != 1 ? _buildFolder(folder) : null,
        decoration: BoxDecoration(
          border: Border.all(
            color: lightGrey.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0.5,
              blurRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.circular(3),
          color: white,
        ),
        children: folder.documents
            .map((item) => DragAndDropItem(
                  child: _buildItem(item, folder),
                ))
            .toList(),
      );

  Widget _buildFolder(Folder folder) {
    return TestProxy(
        key: ValueKey(folder),
        child: new FolderItem(
          onTap: () {},
          folder: folder,
        ));
  }

  Widget _buildItem(Document document, Folder folder) {
    return TestProxy(
        key: ValueKey(document),
        child: new DocumentItem(
          onTap: () {},
          document: document,
          folder: folder,
        ));
  }
}

class DocumentsListHeader extends StatelessWidget {
  const DocumentsListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
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
                  Flexible(
                      child: Text("Nom",
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
                      child: Text("Taille",
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
                      child: Text("Date d'ajout",
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
                      child: Text("Ajouté par",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
