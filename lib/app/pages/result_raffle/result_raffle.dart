import 'package:fc_teams_drawer/app/pages/result_raffle/mobx/result_raffle.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ResultRaffle extends StatefulWidget {
  final bool isSolo;
  const ResultRaffle({ super.key, required this.isSolo });

  @override
  State<ResultRaffle> createState() => _ResultRaffleState();
}

class _ResultRaffleState extends State<ResultRaffle> {

  final _mobx = ResultRaffleMobx();

  @override
  void initState() {
    _mobx.getTeams();

    super.initState();

    Session.appEvents.sendScreen(
      "result_raffle_page",
      params: {
        "is_solo": widget.isSolo.toString(),
      }.toString(),
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
        body: Observer(
          builder: (context) {

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 10 ),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only( top: 20, bottom: 40 ),
                    child: Text(
                      FlutterI18n.translate(context, "pages.result_raffle.title"),
                      style: theme.textTheme.displaySmall?.apply(
                        letterSpacingDelta: 2.5,
                      ),
                    ),
                  ),

                  for ( int i = 0; i < _mobx.teamsList.length; i++ )
                    Column(
                      children: [

                        ListTile(
                          leading: Stack(
                            children: [

                              Image.asset(
                                "assets/img/teams/chelsea.png",
                                color: Colors.transparent,
                              ),

                              Image.asset(
                                "assets/img/teams/${_mobx.teamsList[i].logo}.png",
                                errorBuilder: ( builder, exception, stackTrace ) {

                                  Session.appEvents.sharedErrorEvent("load_image_error", exception.toString());
                                  Session.crash.onError("load_image_error", error: exception, stackTrace: stackTrace);

                                  return Shimmer(
                                    duration: const Duration(seconds: 5),
                                    color: Colors.grey[50]!,
                                    colorOpacity: 0.3,
                                    enabled: true,
                                    direction: const ShimmerDirection.fromLTRB(),
                                    child: Image.asset(
                                      "assets/img/teams/chelsea.png",
                                      color: Colors.grey.shade400,
                                    ),
                                  );

                                },
                              ),

                            ],
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
                                  "${_mobx.teamsList[i].name} - ${_mobx.teamsList[i].score} PTS",
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),

                              Text(
                                FlutterI18n.translate(context, "pages.result_raffle.league", translationParams: {"league": _mobx.teamsList[i].league}),
                                style: theme.textTheme.bodySmall,
                              ),

                            ],
                          ),
                        ),

                        if ( i + 1 < _mobx.teamsList.length )
                          const Divider(),

                      ],
                    ),

                  Padding(
                    padding: const EdgeInsets.only( top: 50 ),
                    child: Text(
                      FlutterI18n.translate(context, "pages.result_raffle.obs"),
                      style: theme.textTheme.bodySmall?.apply(
                        letterSpacingDelta: 2.5,
                      ),
                    ),
                  ),

                ],
              ),
            );

          },
        ),
      ),
    );
  }
}
