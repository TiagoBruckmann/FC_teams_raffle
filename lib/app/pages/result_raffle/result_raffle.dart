import 'package:fc_teams_drawer/domain/entities/team.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ResultRaffle extends StatefulWidget {
  final bool isSolo;
  final List<TeamEntity> listTeams;
  const ResultRaffle({ super.key, required this.isSolo, required this.listTeams });

  @override
  State<ResultRaffle> createState() => _ResultRaffleState();
}

class _ResultRaffleState extends State<ResultRaffle> {

  @override
  void initState() {
    super.initState();

    Session.appEvents.sendScreen(
      "result_raffle_page",
      params: {
        "is_solo": widget.isSolo,
        "list_teams": widget.listTeams.toString(),
      },
    );

  }
  
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

              Padding(
                padding: const EdgeInsets.only( top: 20, bottom: 40),
                child: Text(
                  FlutterI18n.translate(context, "pages.result_raffle.title"),
                  style: theme.textTheme.displaySmall?.apply(
                    letterSpacingDelta: 2.5,
                  ),
                ),
              ),

              for ( int i = 0; i < widget.listTeams.length; i++ )
                Column(
                  children: [

                    ListTile(
                      leading: Image.asset(
                        "assets/img/teams/${widget.listTeams[i].logo}.png",
                        height: 120,
                      ),
                      title: Text(
                        FlutterI18n.translate(context, "pages.result_raffle.${( i > 0 && widget.isSolo )
                            ? "machine"
                            : "player${i + 1}"}",
                        ),
                        style: theme.textTheme.displaySmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric( vertical: 5 ),
                            child: Text(
                              widget.listTeams[i].name,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),

                          Text(
                            FlutterI18n.translate(context, "pages.result_raffle.league", translationParams: {"league": widget.listTeams[i].league}),
                            style: theme.textTheme.bodySmall,
                          ),

                        ],
                      ),
                    ),

                    if ( i < widget.listTeams.length )
                      const Divider(),

                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}
