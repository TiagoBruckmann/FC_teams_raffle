import 'package:fc_teams_drawer/app/core/widgets/verify_connection.dart';
import 'package:fc_teams_drawer/app/pages/tournament/create/mobx/create_tournament.dart';
import 'package:fc_teams_drawer/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreateTournamentPage extends StatefulWidget {
  const CreateTournamentPage({super.key});

  @override
  State<CreateTournamentPage> createState() => _CreateTournamentPageState();
}

class _CreateTournamentPageState extends State<CreateTournamentPage> {

  final CreateTournamentMobx _mobx = CreateTournamentMobx();

  @override
  void initState() {
    Session.appEvents.sendScreen("create_tournament_page");
    super.initState();
    _mobx.initialSettings();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Observer(
      builder: (context) {

        return VerifyConnection(
          isLoading: _mobx.isLoading,
          loadingMessage: "pages.tournament.create.create",
          keyAppBar: "pages.tournament.app_bar",
          appBarParams: const {"status": ""},
          page: SingleChildScrollView(
            padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 7, vertical: 25 ),
                  child: TextField(
                    controller: _mobx.eventNameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: theme.textTheme.bodyMedium!.apply(fontSizeFactor: 1.2),
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(context, "pages.tournament.create.event_name"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( bottom: 10 ),
                  child: Text(
                    FlutterI18n.translate(context, "pages.tournament.create.qtd_participants"),
                    style: theme.textTheme.bodySmall,
                  ),
                ),

                Card(
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric( horizontal: 16 ),
                    underline: const Padding(padding: EdgeInsets.zero),
                    borderRadius: BorderRadius.circular(5),
                    dropdownColor: theme.colorScheme.secondary,
                    onChanged: ( int? value ) => _mobx.setQtdPlayers(value!),
                    value: _mobx.qtdPlayers,
                    isExpanded: true,
                    menuMaxHeight: 250,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.colorScheme.secondary,
                      size: 24,
                    ),
                    hint: Text(
                      FlutterI18n.translate(context, "pages.tournament.create.qtd_participants"),
                      style: theme.textTheme.bodySmall,
                    ),
                    items: [

                      for ( int i = 3; i < 17; i++ )
                        DropdownMenuItem(
                          value: i,
                          child: Text(
                            "$i",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 15, bottom: 10 ),
                  child: Text(
                    FlutterI18n.translate(context, "pages.tournament.create.qtd_defeats"),
                    style: theme.textTheme.bodySmall,
                  ),
                ),

                Card(
                  child: DropdownButton(
                    padding: const EdgeInsets.symmetric( horizontal: 16 ),
                    underline: const Padding(padding: EdgeInsets.zero),
                    dropdownColor: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5),
                    onChanged: ( int? value ) => _mobx.setQtdDefeats(value!),
                    value: _mobx.qtdDefeats,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.colorScheme.secondary,
                      size: 24,
                    ),
                    hint: Text(
                      FlutterI18n.translate(context, "pages.tournament.create.qtd_defeats"),
                      style: theme.textTheme.bodySmall,
                    ),
                    items: [

                      for ( int i = 1; i < 5; i++ )
                        DropdownMenuItem(
                          value: i,
                          child: Text(
                            "$i",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),

                    ],
                  ),
                ),

                SwitchListTile(
                  value: _mobx.raffleTeams,
                  onChanged: ( bool value ) => _mobx.updRaffleTeams(),
                  activeColor: theme.colorScheme.primary,
                  activeTrackColor: theme.colorScheme.secondary,
                  inactiveThumbColor: theme.colorScheme.primary,
                  inactiveTrackColor: theme.colorScheme.error,
                  trackOutlineColor: WidgetStateColor.resolveWith((states) => theme.colorScheme.primary),
                  title: Text(
                    FlutterI18n.translate(context, "pages.tournament.create.raffle_teams"),
                    style: theme.textTheme.bodySmall,
                  ),
                ),

                for ( int i = 0; i < _mobx.playersController.length; i++ )
                  Padding(
                    padding: const EdgeInsets.symmetric( vertical: 7 ),
                    child: TextField(
                      controller: _mobx.playersController[i],
                      keyboardType: TextInputType.text,
                      textInputAction: ( i + 1 == _mobx.playersController.length )
                          ? TextInputAction.done
                          : TextInputAction.next,
                      style: theme.textTheme.bodyMedium!.apply(fontSizeFactor: 1.2),
                      decoration: InputDecoration(
                        labelText: FlutterI18n.translate(context, "pages.tournament.create.player_name", translationParams: {"position": (i + 1).toString()}),
                      ),
                    ),
                  ),

                Container(
                  padding: const EdgeInsets.only( top: 20 ),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                    ),
                    onPressed: () => _mobx.validateFields(),
                    child: Text(
                      FlutterI18n.translate(context, "btn_generate"),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displayMedium!.apply(
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );

      },
    );
  }
}
