import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/widgets/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _userLoginController = TextEditingController();
  final _userReportFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> userList = [];

  String? _string;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildHomeDesktopView(screenSize, context),
//      mediumScreen: _buildHomeTabletView(screenSize, context),
//      smallScreen: _buildHomeMobileView(screenSize, context),
    );
  }

  Widget _buildHomeDesktopView(Size screenSize, BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Form(
              key: _userReportFormKey,
              child: TextFormField(
                controller: _userLoginController,
                autofocus: false,
                keyboardType: TextInputType.url,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontFamily: application.fontFamily,
                      color: application.colorPalette.textColor,
                    ),
                onChanged: (_) => setState(() {}),
                onFieldSubmitted: _addUser,
                cursorColor: application.colorPalette.accentColor,
                decoration: InputDecoration(
                  labelText: "User Login",
                  labelStyle: TextStyle(
                      color:
                          application.colorPalette.textColor!.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: application.colorPalette.accentColor),
                    borderRadius: BorderRadius.all(
                        Radius.circular(application.buttonRadius)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: application.colorPalette.accentColor),
                    borderRadius: BorderRadius.all(
                        Radius.circular(application.buttonRadius)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(application.buttonRadius)),
                  ),
                  errorStyle: TextStyle(
                    fontFamily: application.fontFamily,
                    color: Colors.red,
                  ),
                  errorMaxLines: 1,
                  hintText: "Write a login name",
                  hintStyle: TextStyle(
                    fontFamily: application.fontFamily,
                    color: application.colorPalette.textColor!.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: application.colorPalette.secondaryColor,
                  suffixIcon: _userLoginController.text.isNotEmpty &&
                          _userLoginController.text.length > 4
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            backgroundColor:
                                application.colorPalette.accentColor,
                            child: IconButton(
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    userList.add(_userLoginController.text);
                                  });
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
                height: screenSize.height / 3,
                child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Chip(
                        backgroundColor: Colors.red,
                        onDeleted: () {
                          if (mounted) {
                            setState(() {
                              userList.removeAt(index);
                            });
                          }
                        },
                        label: Text(userList[index]));
                  },
                )),
            SizedBox(
              height: screenSize.height / 3,
              child: SingleChildScrollView(
                child: Text(
                  _string ?? "loading...",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: application.colorPalette.textColor,
                      fontFamily: application.fontFamily,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addUser(String login) {
    userList.add(login);
  }

//  void _fetchReportForUser(String login) {
//    StringBuffer sb = StringBuffer();
//    RestProvider.githubService.getUserActivity(login).then((reportSummary) {
//      for (var report in reportSummary) {
//        sb.writeln(report.user);
//        for (var bucketList in report.buckets.values) {
//          sb.writeln("==========================================");
//          sb.writeln(bucketList.type.name);
//          sb.writeln("==========================================");
//          for (var bucket in bucketList.buckets.values) {
//            sb.writeln("******************************************");
//            sb.writeln(bucket.name);
//            sb.writeln("******************************************");
//            for (var event in bucket.events.values) {
//              sb.writeln(event.toString());
//            }
//          }
//        }
//      }
//      if (mounted) {
//        setState(() {
//          _string = sb.toString();
//        });
//      }
//    });
//  }
}
