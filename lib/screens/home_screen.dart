import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_activity_monitor/configs/routes/route_manager.dart';
import 'package:github_activity_monitor/notifiers/github_users_notifier.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/widgets/responsive.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _maxUsers = 20;

  final TextEditingController _userLoginController = TextEditingController();

//  final _userReportFormKey = GlobalKey<FormState>();
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//  final List<String> _userList = [];
  late final FocusNode _loginFocusNode;

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

  @override
  void initState() {
    super.initState();
    _loginFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    _userLoginController.dispose();
    super.dispose();
  }

  Widget _buildHomeDesktopView(Size screenSize, BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: application.colorPalette.accentColor,
      textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
          color: application.colorPalette.textColor,
          fontFamily: application.fontFamily,
          fontSize: 30),
    );
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Github PushEvent Monitor",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: application.colorPalette.textColor,
                    fontFamily: application.fontFamily,
                    fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Try adding the Github login names below and then press the submit button",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: application.colorPalette.textColor,
                      fontFamily: application.fontFamily,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _userLoginController,
                  autofocus: true,
                  focusNode: _loginFocusNode,
                  keyboardType: TextInputType.url,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: application.fontFamily,
                        color: application.colorPalette.textColor,
                      ),
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (value) {
                    _addUser(_userLoginController.text);
                    _loginFocusNode.requestFocus();
                  },
                  cursorColor: application.colorPalette.accentColor,
                  decoration: InputDecoration(
                    labelText: "User Login",
                    labelStyle: TextStyle(
                        color: application.colorPalette.textColor!
                            .withOpacity(0.7)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: application.colorPalette.accentColor),
                      borderRadius: BorderRadius.all(
                          Radius.circular(application.buttonRadius)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: application.colorPalette.accentColor),
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
                    errorText: _isMaxUsersExceeded()
                        ? "You can add up to $_maxUsers users."
                        : null,
                    hintText: "Write a login name",
                    hintStyle: TextStyle(
                      fontFamily: application.fontFamily,
                      color:
                          application.colorPalette.textColor!.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: application.colorPalette.secondaryColor,
                    suffixIcon: _userLoginController.text.isNotEmpty &&
                            _userLoginController.text.length > 4
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  application.colorPalette.accentColor,
                              child: IconButton(
                                onPressed: () {
                                  if (mounted) {
                                    _addUser(_userLoginController.text);
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
                  width: 800,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Consumer<GithubUsersNotifier>(
                      builder: (context, value, child) => MasonryGridView.count(
                        shrinkWrap: false,
//                    scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<GithubUsersNotifier>(context,
                                listen: false)
                            .length(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Chip(
                              backgroundColor:
                                  application.colorPalette.accentColor,
                              onDeleted: () {
                                value.removeAt(index);
                              },
                              label: Text(
                                value.users[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color:
                                            application.colorPalette.textColor,
                                        fontFamily: application.fontFamily,
                                        fontSize: 12),
                              ),
                            ),
                          );
                        },
                        crossAxisCount: 5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                    ),
                  )),
              Consumer<GithubUsersNotifier>(
                builder: (context, value, child) {
                  return value.isNotEmpty()
                      ? ElevatedButton(
                          onPressed: () {
                            RouteManager.navigateTo(
                                context: context, route: Routes.report);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: application.colorPalette.accentColor,
                            textStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: application.colorPalette.textColor,
                                    fontFamily: application.fontFamily,
                                    fontSize: 30),
                          ),
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: application.colorPalette.textColor,
                                    fontFamily: application.fontFamily,
                                    fontSize: 18),
                          ))
                      : ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: application.colorPalette.textColor,
                                    fontFamily: application.fontFamily,
                                    fontSize: 30),
                          ),
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: application.colorPalette.textColor,
                                    fontFamily: application.fontFamily,
                                    fontSize: 18),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(String login) {
    setState(() {
      if (Provider.of<GithubUsersNotifier>(context, listen: false).length() <
          _maxUsers) {
        Provider.of<GithubUsersNotifier>(context, listen: false).add(login);
      }
    });
  }

  bool _isMaxUsersExceeded() {
    return Provider.of<GithubUsersNotifier>(context, listen: false).length() >=
        _maxUsers;
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
