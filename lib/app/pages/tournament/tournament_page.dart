// imports nativos
import 'package:flutter/material.dart';

// imports globais
import 'package:fc_teams_drawer/session.dart';

// import das telas
import 'package:fc_teams_drawer/app/pages/tournament/mobx/tournament.dart';
import 'package:fc_teams_drawer/app/core/widgets/verify_connection.dart';

// import dos domain
import 'package:fc_teams_drawer/domain/entity/tournament.dart';

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {

  final TournamentMobx _mobx = TournamentMobx();

  @override
  void initState() {
    Session.appEvents.sendScreen("tournament_page");
    super.initState();
    _mobx.getTournaments();
  }

  @override
  void dispose() {
    _mobx.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Observer(
        builder: (context) {

          return VerifyConnection(
            keyAppBar: "pages.tournament.app_bar",
            appBarParams: {"status": "- ${_mobx.filterStatus}"},
            actionWidgets: [
              PopupMenuButton<String>(
                color: theme.colorScheme.background,
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: theme.colorScheme.secondary,
                ),
                onSelected: ( String value ) => _mobx.searchStatus(value),
                itemBuilder: (context){
                  return _mobx.itemsMenu.map((String item){

                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: theme.textTheme.bodySmall,
                      ),
                    );

                  }).toList();
                },
              ),
            ],
            page: RefreshIndicator(
              onRefresh: () => _mobx.refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 10 ),
                itemCount: _mobx.tournamentList.length,
                itemBuilder: ( builder, index ) {

                  TournamentEntity entity = _mobx.tournamentList[index];

                  return Card(
                    child: ListTile(
                      onTap: () => _mobx.openTournament( entity ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                    
                          Text(
                            entity.name,
                            style: theme.textTheme.bodyMedium?.apply(
                              fontWeightDelta: 9,
                            ),
                          ),

                          IconButton(
                            tooltip: FlutterI18n.translate(context, "pages.tournament.${ entity.isActive ? "active_status" : "closed_status" }"),
                            onPressed: () => _mobx.updStatus( entity ),
                            icon: Icon(
                              ( entity.isActive )
                                  ? Icons.block
                                  : Icons.check_circle_outline,
                            ),
                          ),
                    
                        ],
                      ),
                      subtitle: Text(
                        FlutterI18n.translate(context, "pages.tournament.date", translationParams: {"date": entity.date}),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  );

                },
              ),
            ),
            floatingFunction: () => _mobx.goToNewTournament(),
          );

        },
      ),
    );
  }
}
