import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/authentication/widgets/expanded_button.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Row(children: [
      Expanded(child: Container( child: Row(
        children: [
          Expanded(child: Container( ),flex: 1,),
          Expanded(child: Container(child: Column(children: [
            Expanded(child: Container()),
            Row(children: [ Image.asset(
              "icons/logo_qalitas.png",
              width: 30,
              height: 30,
            )],),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  "Se connecter",
                  style:
                  TextStyle(color: text, fontSize: 23, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Text(
                  "Adresse e-mail",
                  style: TextStyle(
                      color: text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 10,),
            FormTextField(
              hintText: 'user@qalitas.com',
              seText: (String value) {
                // widget.project.name = value;
              },
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  "Mot de passe",
                  style: TextStyle(
                      color: text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 10,),
            FormTextField(
              hintText: '8 caract??res minimum',
              seText: (String value) {
                // widget.project.name = value;
              },
            ),
            SizedBox(height: 10,),
                  Row( mainAxisSize: MainAxisSize.max,
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: SizedBox(
                          width: 15.0,
                          child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: true,
                            onChanged: (value) {
                            },
                            activeColor: active,
                          ),),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          "Se souvenir de moi",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_500,
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(onTap: (){}, focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child:
                      Text(
                        "Mot de passe oubli???",
                        style: TextStyle(
                            color: active,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),),)
                    ],
                  ),
            SizedBox(height: 20,),
            ExpandedButton(
                text: "Se connecter",
                onTap: () {
                }),
            SizedBox(height: 20,),
            Row( mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    "Pas encore inscrit?",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle_Text_12_500,
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(onTap: (){}, focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child:
                  Text(
                    "Cr??er un compte",
                    style: TextStyle(
                        color: active,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),),),
                Expanded(child: Container()),
              ],
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Text(
                  "?? 2021 TIM, Tous droits r??serv??s.",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle_Text_12_500,
                ),
              ],
            ),
            SizedBox(height: 40,)
          ],),) , flex: 5,),
          Expanded(child: Container() ,flex: 1,),
        ],
      ),) , flex: 1,),
      Expanded(child: Column(
        children: [
          Expanded(
            child: Container( color: Colors.red, child: Image.asset(
              "images/2.jpg",
              fit: BoxFit.fill,
            ),),
          ),
        ],
      ) , flex: 1,),
    ],),));
  }
}
