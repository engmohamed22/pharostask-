import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/size_config.dart';

class CustomSubjectCard extends StatelessWidget {

  bool active;
  String text;

  CustomSubjectCard(this.active, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // initialize media query
    SizeConfig().init(context);

    return Container(
      margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 2),
      width: SizeConfig.safeBlockHorizontal * 27,
      height: SizeConfig.safeBlockVertical * 12,
      decoration: BoxDecoration(
        color: active ? kPrimaryColor : kSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.safeBlockHorizontal * 5)),
      ),
      child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
              color: active ? Colors.white : Colors.black,
            ),
          )
      ),
    );
  }
}
