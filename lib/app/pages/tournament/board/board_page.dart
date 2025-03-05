// imports nativos
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/pages/tournament/board/widgets/body_key_tournament.dart';
import 'package:fc_teams_drawer/app/pages/tournament/board/mobx/board.dart';
import 'package:fc_teams_drawer/app/core/widgets/verify_connection.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class BoardPage extends StatefulWidget {
  final TournamentEntity tournament;
  const BoardPage({ super.key, required this.tournament });

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  final BoardMobx _mobx = BoardMobx();

  final _nextWinner = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_winner");
  final _nextLoser = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.next_loser");
  final _champion = FlutterI18n.translate(Session.globalContext.currentContext!, "pages.tournament.player.champion");

  @override
  void initState() {
    super.initState();
    Session.appEvents.sendScreen("board_page", params: widget.tournament.toString());
    _mobx.init(widget.tournament);
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return VerifyConnection(
      keyAppBar: "pages.tournament.app_bar",
      appBarParams: const {"status": ""},
      page: Observer(
        builder: (context) {

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric( horizontal: 5, vertical: 10 ),
            child: Column(
              children: [

                for ( final entity in _mobx.listMatches )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      if ( entity.player2.contains(_champion) ) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: BodyKeyTournamentWidget(
                                playerName: entity.player1,
                                teamLogo: entity.logoTeam1,
                                score: entity.score1,
                                hasWinner: true,
                                hasChampion: true,
                                function: ( int value ) => _mobx.setGoals(entity, score1: value),
                              ),
                            ),

                          ],
                        ),
                      ] else ...[

                        Padding(
                          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 20 ),
                          child: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.game_position", translationParams: {"position": entity.round.toString()}),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: BodyKeyTournamentWidget(
                                playerName: entity.player1,
                                teamLogo: entity.logoTeam1,
                                score: entity.score1,
                                hasWinner: ( entity.winner.trim().isNotEmpty || entity.player2.contains(_nextWinner) || entity.player2.contains(_nextLoser) ),
                                function: ( int value ) => _mobx.setGoals(entity, score1: value),
                              ),
                            ),

                            Expanded(
                              child: BodyKeyTournamentWidget(
                                playerName: entity.player2,
                                teamLogo: entity.logoTeam2,
                                score: entity.score2,
                                hasWinner: ( entity.winner.trim().isNotEmpty ),
                                function: ( int value ) => _mobx.setGoals(entity, score2: value),
                                // isLoser: entity.player2["defeats"] > 0,
                              ),
                            ),

                          ],
                        ),
                      ],

                      const Divider(
                        height: 30,
                        thickness: 2,
                      ),

                    ],
                  ),

              ],
            ),
          );

        },
      ),
    );
  }
}
