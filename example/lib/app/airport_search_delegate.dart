import 'package:flight_co2_calculator_flutter/airport.dart';
import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/conditions_bloc.dart';
//import 'package:app/airport.dart';
import 'package:flutter/material.dart';

import 'constants/common_data.dart';

class AirportSearchDelegate extends SearchDelegate<Location> {
  AirportSearchDelegate({@required this.airportLookup});
  final AirportLookup airportLookup;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildMatchingSuggestions(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildMatchingSuggestions(context);
  }

  Widget buildMatchingSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    final searched = airportLookup.searchString2(CommonData.subwayData["DATA"], query);
    if (searched.length == 0) {
      return AirportSearchPlaceholder(title: 'No results');
    }

    return ListView.builder(
      itemCount: searched.length,
      itemBuilder: (context, index) {
        return LocationSearchResultTile(
          searched: searched[index],
          searchDelegate: this,
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? <Widget>[
            IconButton(
              tooltip: '지도에서 찾기',
              icon: const Icon(Icons.map),
              onPressed: () {
                print("map!!");
              },
            )
          ]
        : <Widget>[
            IconButton(
              tooltip: '지도에서 찾기',
              icon: const Icon(Icons.map),
              onPressed: () {
                print("map!!");
              },
            ),
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ];
  }
}

class AirportSearchPlaceholder extends StatelessWidget {
  AirportSearchPlaceholder({@required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Text(
        title,
        style: theme.textTheme.headline,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class LocationSearchResultTile extends StatelessWidget {
  const LocationSearchResultTile({@required this.searched, @required this.searchDelegate});

  final Map<String, String> searched;
  final SearchDelegate<Location> searchDelegate;

  @override
  Widget build(BuildContext context) {

    final title = searched["station_nm"] + "역" + " (" + searched["line_nm"] + ")";
    final subtitle = "";
//    final title = '${airport.station_nm}역 (${airport.line_nm})';
//    final subtitle = '${airport.city}, ${airport.country}';
    final ThemeData theme = Theme.of(context);
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: theme.textTheme.body2,
        textAlign: TextAlign.start,
      ),
//      subtitle: Text(
//        subtitle,
//        style: theme.textTheme.body1,
//        textAlign: TextAlign.start,
//      ),
      onTap: () {
        Location location = new Location(searched);
        searchDelegate.close(context, location);
      }
    );
  }
}

class AirportSearchResultTile extends StatelessWidget {
  const AirportSearchResultTile({@required this.airport, @required this.searchDelegate});

  final Airport airport;
  final SearchDelegate<Airport> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final title = '${airport.name} (${airport.iata})';
    final subtitle = '${airport.city}, ${airport.country}';
    final ThemeData theme = Theme.of(context);
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: theme.textTheme.body2,
        textAlign: TextAlign.start,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.body1,
        textAlign: TextAlign.start,
      ),
      onTap: () => searchDelegate.close(context, airport),
    );
  }
}
