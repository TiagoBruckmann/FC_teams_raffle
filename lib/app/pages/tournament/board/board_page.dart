// imports nativos
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/pages/tournament/board/widgets/body_key_tournament.dart';
import 'package:fc_teams_drawer/app/pages/tournament/board/mobx/board.dart';
import 'package:fc_teams_drawer/app/core/widgets/verify_connection.dart';
import 'package:fc_teams_drawer/app/core/db/collections/tournament.dart';

// import dos pacotes
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class BoardPage extends StatefulWidget {
  final TournamentCollection tournament;
  const BoardPage({ super.key, required this.tournament });

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  final BoardMobx _mobx = BoardMobx();

  @override
  void initState() {
    super.initState();
    Session.appEvents.sendScreen("board_page", params: widget.tournament.toMap().toString());
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

                SingleChildScrollView(
                  padding: const EdgeInsets.only( top: 10, bottom: 5 ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      if ( _mobx.qtdSteps == 4 )
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 4 ),
                          child: RawChip(
                            selectedColor: theme.colorScheme.secondary,
                            backgroundColor: theme.colorScheme.surface,
                            selected: _mobx.selectedStep == 1,
                            labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                            onPressed: () => _mobx.selectStep(4),
                            elevation: 3,
                            label: Text(
                              FlutterI18n.translate(context, "pages.tournament.board.4"),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),

                      if ( _mobx.qtdSteps == 3 )
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 4 ),
                          child: RawChip(
                            selectedColor: theme.colorScheme.secondary,
                            backgroundColor: theme.colorScheme.surface,
                            selected: _mobx.selectedStep == 1,
                            labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                            onPressed: () => _mobx.selectStep(3),
                            elevation: 3,
                            label: Text(
                              FlutterI18n.translate(context, "pages.tournament.board.3"),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),

                      if ( _mobx.qtdSteps == 2 )
                        Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 4 ),
                          child: RawChip(
                            selectedColor: theme.colorScheme.secondary,
                            backgroundColor: theme.colorScheme.surface,
                            selected: _mobx.selectedStep == 2,
                            labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                            onPressed: () => _mobx.selectStep(2),
                            elevation: 3,
                            label: Text(
                              FlutterI18n.translate(context, "pages.tournament.board.2"),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 4 ),
                        child: RawChip(
                          selectedColor: theme.colorScheme.secondary,
                          backgroundColor: theme.colorScheme.surface,
                          selected: _mobx.selectedStep == 1,
                          labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                          onPressed: () => _mobx.selectStep(1),
                          elevation: 3,
                          label: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.1"),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

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
                              playerName: entity.player1?.name ?? "",
                              teamLogo: entity.player1?.team ?? "",
                              score: entity.player1Scoreboard,
                              hasWinner: ( entity.winner != null && entity.winner!.trim().isNotEmpty ),
                              function: ( int value ) => _mobx.setGoals(entity, player1ScoreBoard: value),
                            ),
                          ),

                          Expanded(
                            child: BodyKeyTournamentWidget(
                              playerName: entity.player2?.name ?? "Próximo ganhador",
                              teamLogo: entity.player2?.team ?? "",
                              score: entity.player2Scoreboard,
                              hasWinner: ( entity.winner != null && entity.winner!.trim().isNotEmpty ),
                              function: ( int value ) => _mobx.setGoals(entity, player2ScoreBoard: value),
                              // isLoser: entity.player2["defeats"] > 0,
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
