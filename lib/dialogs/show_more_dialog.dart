import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

showMoreDialogBox(BuildContext context,String title , String textToShow) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        content: Container(
          width: 500,
          constraints: BoxConstraints(maxHeight: 522),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 12.5),
                  child: Row(children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: text, fontSize: 12, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                ),
                SizedBox(height: 20,),
                ListView(
                  shrinkWrap: true,
                  children :[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: SelectableText(
                          textToShow,
                          textAlign: TextAlign.justify,
                          style :TextStyle(
                              color: text, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                    )),
                  ]
                ),
                SizedBox(height: 20,),
              ]),
        ),
      );
    },
  );
}