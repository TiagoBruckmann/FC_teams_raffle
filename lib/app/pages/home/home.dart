import 'package:fc_teams_drawer/app/core/style/app_images.dart';
import 'package:fc_teams_drawer/app/pages/home/mobx/home.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeMobx _mobx = HomeMobx();

  @override
  void initState() {
    super.initState();
    Session.appEvents.sendScreen("home_page");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mobx.verifyVersion();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            FlutterI18n.translate(context, "pages.home.app_bar"),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric( horizontal: 16 ),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only( bottom: 60 ),
                  child: Image.asset(
                    AppImages.logoPng,
                    height: 200,
                  ),
                ),

                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => _mobx.goToResponse(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.solo"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          message: FlutterI18n.translate(context, "pages.home.solo_help"),
                          triggerMode: TooltipTriggerMode.tap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                            child: Icon(
                              Icons.info_outline,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric( vertical: 20 ),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => _mobx.goToResponse( isSolo: false ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.x1"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          message: FlutterI18n.translate(context, "pages.home.x1_help"),
                          triggerMode: TooltipTriggerMode.tap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                            child: Icon(
                              Icons.info_outline,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                /*
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => _mobx.goToTournament(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.tournament"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          message: FlutterI18n.translate(context, "pages.home.tournament_help"),
                          triggerMode: TooltipTriggerMode.tap,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                            child: Icon(
                              Icons.info_outline,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                */

              ],
            ),
          ),
        ),
      ),
    );
  }
}