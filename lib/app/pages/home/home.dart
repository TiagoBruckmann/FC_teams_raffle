import 'package:fc_teams_drawer/app/core/style/app_images.dart';
import 'package:fc_teams_drawer/app/pages/home/mobx/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final HomeMobx mobx = HomeMobx();
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
                    onPressed: () => mobx.goToResponse( true ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.solo"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          padding: const EdgeInsets.all(4),
                          message: FlutterI18n.translate(context, "pages.home.solo_help"),
                          textStyle: theme.textTheme.bodySmall,
                          preferBelow: true,
                        ),

                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric( vertical: 20 ),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => mobx.goToResponse( false ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.x1"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          padding: const EdgeInsets.all(4),
                          message: FlutterI18n.translate(context, "pages.home.x1_help"),
                          textStyle: theme.textTheme.bodySmall,
                          preferBelow: true,
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => mobx.goToTournament(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          FlutterI18n.translate(context, "pages.home.tournament"),
                          style: theme.textTheme.displaySmall,
                        ),

                        Tooltip(
                          padding: const EdgeInsets.all(4),
                          message: FlutterI18n.translate(context, "pages.home.tournament_help"),
                          textStyle: theme.textTheme.bodySmall,
                          preferBelow: true,
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
