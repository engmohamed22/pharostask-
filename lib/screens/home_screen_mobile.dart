import 'dart:convert';

import 'package:flutter/material.dart';

import '../utilities/api.dart';
import '../utilities/constants.dart';
import '../utilities/size_config.dart';
import '../widgets/custom_subject_card.dart';
import '../widgets/custom_teacher_card.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  List _items = [];
  List _teachers = [];
  int clickedItem = 0;
  API api = API();
  late var data;

  void updateData(var data) {
    setState(() {
      _items = data["subjects"];
      _teachers = _items[clickedItem]['courses'];
    });
  }

  void getData() async {
    String response = await api.readApiJson();
    data = await json.decode(response);
    updateData(data);
  }

  @override
  void initState() {
    super.initState();
    // read data from json file
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // initialize media query object
    SizeConfig().init(context);

    // check is portrait or landscape
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return MaterialApp(
      home: Scaffold(
        // be aware of notches
        body: SafeArea(
          child: Column(
            children: [
              // title bar
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight:
                            Radius.circular(SizeConfig.safeBlockHorizontal * 5),
                        bottomLeft:
                            Radius.circular(SizeConfig.safeBlockHorizontal * 5),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // vertical space
                      SizedBox(
                        height: isPortrait
                            ? SizeConfig.safeBlockVertical * 10
                            : SizeConfig.safeBlockVertical * 6,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 10),
                        child: Text(
                          "Classes and Groups",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // body
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockVertical * 2,
                      top: SizeConfig.safeBlockVertical * 3),
                  color: kBodyColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // subject horizontal list
                      _items.isNotEmpty
                          ? SizedBox(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // update clicked item
                                        clickedItem = index;
                                        // update teachers list according to clicked subject
                                        updateData(data);
                                      });
                                    },
                                    child: CustomSubjectCard(
                                        clickedItem == index ? true : false,
                                        _items[index]["title"]),
                                  );
                                },
                              ),
                              height: isPortrait
                                  ? SizeConfig.safeBlockVertical * 6
                                  : SizeConfig.safeBlockVertical * 12,
                            )
                          : Container(),

                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 5,
                            bottom: SizeConfig.safeBlockVertical * 1,
                            top: SizeConfig.safeBlockVertical * 5),
                        child: Text(
                          "List of courses",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                          ),
                        ),
                      ),

                      // teacher vertical listview
                      _teachers.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: _teachers.length,
                                itemBuilder: (context, index) {
                                  return CustomTeacherCard(
                                    _teachers[index]["teacher_name"],
                                    _teachers[index]["starting_date"],
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
