import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_type_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/buttons.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

class SupportForm extends StatefulWidget {

  const SupportForm({Key? key,}) : super(key: key);

  @override
  _SupportFormState createState() => _SupportFormState();
}

class _SupportFormState extends State<SupportForm>
    with AutomaticKeepAliveClientMixin<SupportForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Container(
                    width: 500,
                    constraints: BoxConstraints(maxHeight: 522),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormHeader(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Divider(
                              height: 1,
                              color: dividerColor,
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                                isAlwaysShown: true,
                                controller: scrollController,
                                child: ListView(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Container(
                                          child: Text(
                                            "Besoin d'aide?",
                                            style: TextStyle(
                                                color: active,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Container(
                                          child: Text(
                                            "Rechercher le problème",
                                            style: TextStyle(
                                                color: text,
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: FormTextField(
                                          seText: (String value) {
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Problème non résolu? ",
                                                style: TextStyle(
                                                    color: text,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            Text(
                                              "Créer un ticket maintenant.",
                                              style: TextStyle(
                                                  color: active,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.chat_outlined , size: 25,),
                                            SizedBox(height: 10,),
                                            Text(
                                              "Créer un ticket",
                                              style: TextStyle(
                                                  color: text,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Envoyez maintenant une description détaillée de votre problème au service d'assistance.",
                                              style: TextStyle(
                                                  color: text,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 10,),
                                            DialogButton(
                                                text: 'Créer',
                                                onTap: () {
                                                }),
                                          ],
                                        ),

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.phone_enabled_rounded , size: 25,),
                                            SizedBox(height: 10,),
                                            Text(
                                              "Appelez-nous",
                                              style: TextStyle(
                                                  color: text,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Problème urgent? n'attendez pas, appelez-nous maintenant sur 72000000.",
                                              style: TextStyle(
                                                  color: text,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),

                                      ),
                                    ]),
                              ),
                            ),
                        ]),
                  )
    );
  }
}

class FormHeader extends StatelessWidget {
  const FormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: active,
          ),
          child: Icon(
            Icons.support_outlined,
            size: 20,
            color: white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Support",
          style:
          TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          width: 6,
        ),
        CustomIconButton(
            icon: Icons.info_outline, message: 'Support', onTap: () {})
      ]),
    );
  }
}