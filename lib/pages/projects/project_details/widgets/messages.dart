import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:lottie/lottie.dart';

import 'multi_options_button.dart';

class NoItems extends StatelessWidget {
  final String icon;
  final String title;
  final String message;
  final String? buttonText;
  const NoItems({Key? key , required this.icon , required this.message , required this.title , required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
         /* SvgPicture.asset(
            icon,
            color: text.withOpacity(0.5),
            width: 30,
            height: 30,
          ),*/
          Container(constraints: BoxConstraints(maxWidth: 400 , maxHeight: 400),  child : Lottie.asset(
            'icons/astronaut.json',
            repeat: true,
            animate: true,
            fit: BoxFit.fill,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: text,
                fontSize: 17,
                letterSpacing: 0,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: text.withOpacity(0.8),
                  fontSize: 12.5,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(visible: buttonText != null, child: MultiOptionsButton(text: buttonText!, onTap: () {  }, isMultiple: false, withIcon: false,)),
          Expanded(child: Container())
        ],
      ),
    ));
  }
}