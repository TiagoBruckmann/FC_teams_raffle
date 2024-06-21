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

  @override
  void initState() {
    super.initState();
    Session.appEvents.sendScreen("board_page", params: widget.tournament.toString());
    _mobx.setListKeys(widget.tournament);
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

                const Text(""),

                /*
                SingleChildScrollView(
                  padding: const EdgeInsets.only( top: 10, bottom: 5 ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      for ( int i = _mobx.qtdSteps; i > 0; i++ )
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 4 ),
                          child: RawChip(
                            labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                            onPressed: () => _mobx.selectStep( i ),
                            elevation: 3,
                            label: Text(
                              FlutterI18n.translate(context, "pages.tournament.board.${ i + 1 }"),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
                */

                for ( final entity in _mobx.listKeys )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 20 ),
                        child: Text(
                          FlutterI18n.translate(context, "pages.tournament.board.game_position", translationParams: {"position": entity.position.toString()}),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: BodyKeyTournamentWidget(
                              playerName: entity.player1["name"],
                              teamLogo: entity.player1["team"],
                              score: entity.player1Scoreboard,
                              hasWinner: entity.winner.trim().isNotEmpty,
                              function: ( int value ) => _mobx.setGoals(entity, widget.tournament.customMap(), player1: value),
                            ),
                          ),

                          Expanded(
                            child: BodyKeyTournamentWidget(
                              playerName: entity.player2["name"] ?? "Ganhador do primeiro jogo",
                              teamLogo: entity.player2["team"] ?? "",
                              score: entity.player2Scoreboard,
                              hasWinner: entity.winner.trim().isNotEmpty,
                              function: ( int value ) => _mobx.setGoals(entity, widget.tournament.customMap(), player2: value),
                            ),
                          ),

                        ],
                      ),

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
