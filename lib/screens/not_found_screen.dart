import 'package:flutter/material.dart';
import 'package:github_activity_monitor/util/application.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotFoundScreenState createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height:
          MediaQuery.of(context).size.height - application.appBarSmallHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Page Not Found!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontFamily: application.fontFamily,
                  color: application.colorPalette.textColor,
                ),
          ),
        ],
      ),
    );
  }
}
