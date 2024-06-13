// imports nativos
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/pages/tournament/board/mobx/board.dart';
import 'package:fc_teams_drawer/app/core/widgets/verify_connection.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// import dos pacotes
import 'package:flutter_mobx/flutter_mobx.dart';

class BoardPage extends StatefulWidget {
  final Map<String, dynamic> json;
  const BoardPage({ super.key, required this.json });

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  final BoardMobx _mobx = BoardMobx();

  @override
  void initState() {
    Session.appEvents.sendScreen("board_page");
    _mobx.getKeys(widget.json);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: VerifyConnection(
        keyAppBar: "pages.tournament.app_bar",
        appBarParams: const {"status": ""},
        page: SingleChildScrollView(
          padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 10 ),
          child: Observer(
            builder: (context) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        RawChip(
                          labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                          onPressed: () => _mobx.selectOctaves(),
                          elevation: 3,
                          label: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.octaves"),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                        RawChip(
                          labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                          onPressed: () => _mobx.selectQuarter(),
                          elevation: 3,
                          label: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.quarter"),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                        RawChip(
                          labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                          onPressed: () => _mobx.selectSemi(),
                          elevation: 3,
                          label: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.semi"),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                        RawChip(
                          labelPadding: const EdgeInsets.symmetric( horizontal: 3, vertical: 2 ),
                          onPressed: () => _mobx.selectFinal(),
                          elevation: 3,
                          label: Text(
                            FlutterI18n.translate(context, "pages.tournament.board.final"),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              );

            },
          ),
        ),
      ),
    );
  }
}
