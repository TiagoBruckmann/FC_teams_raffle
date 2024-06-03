import 'package:fc_teams_drawer/domain/entities/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ResultRaffle extends StatelessWidget {
  final bool isSolo;
  final List<TeamEntity> listTeams;
  const ResultRaffle({ super.key, required this.isSolo, required this.listTeams });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            FlutterI18n.translate(context, "pages.result_raffle.app_bar"),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 10 ),
          child: Column(
            children: [

              Text(
                FlutterI18n.translate(context, "pages.result_raffle.title"),
                style: theme.textTheme.headlineLarge,
              ),

              for ( int i = 0; i < listTeams.length; i++ )
                ListTile(
                  leading: Image.asset(
                    "assets/img/teams/${listTeams[i].logo}.png",
                    height: 40,
                  ),
                  title: Text(
                  ( i > 0 && isSolo )
                    ? FlutterI18n.translate(context, "pages.result_raffle.machine")
                    : FlutterI18n.translate(context, "pages.result_raffle.player${i + 1}"),
                    style: theme.textTheme.displaySmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        listTeams[i].name,
                        style: theme.textTheme.bodyMedium,
                      ),

                      Text(
                        listTeams[i].league,
                        style: theme.textTheme.bodyMedium,
                      ),

                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
