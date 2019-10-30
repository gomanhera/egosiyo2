import 'dart:async';

import 'package:flight_co2_calculator_flutter/airport.dart';
import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flight_co2_calculator_flutter/flight_class.dart';
import 'package:flight_co2_calculator_flutter_example/app/airport_search_delegate.dart';
import 'package:flight_co2_calculator_flutter_example/app/airport_widget.dart';
import 'package:flight_co2_calculator_flutter_example/app/common_widgets/vertical_spacing.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/palette.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/text_styles.dart';
import 'package:flight_co2_calculator_flutter_example/app/segmented_control.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';

class FlightDetailsCard extends StatelessWidget {
  FlightDetailsCard({
    @required this.flightDetails,
    @required this.flightDetailsBloc,
    @required this.airportLookup,
  });
  final FlightDetails flightDetails;
  final FlightDetailsBloc flightDetailsBloc;
  final AirportLookup airportLookup;

  final Map<FlightClass, Widget> flightClassChildren = const <FlightClass, Widget>{
    FlightClass.economy: Text('미니룸'),
    FlightClass.business: Text('샤워룸'),
    FlightClass.first: Text('원룸'),
  };

  final Map<FlightType, Widget> flightTypeChildren = const <FlightType, Widget>{
    FlightType.oneWay: Text('남녀 혼용'),
    FlightType.twoWays: Text('남녀 분리'),
  };

  Future<Airport> _showSearch(BuildContext context) async {
    return await showSearch<Airport>(
        context: context,
        delegate: AirportSearchDelegate(
          airportLookup: airportLookup,
        ));
  }

  void _selectDeparture(BuildContext context) async {
    final departure = await _showSearch(context);
    flightDetailsBloc.updateWith(departure: departure);
  }

  void _selectArrival(BuildContext context) async {
    final arrival = await _showSearch(context);
    flightDetailsBloc.updateWith(arrival: arrival);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      child: Container(

        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalSpacing(),
            AirportWidget(
              iconData: Icons.subway,
              title: Text('기준 장소', style: TextStyles.caption),
              airport: flightDetails.departure,
              onPressed: () => _selectDeparture(context),
            ),
            VerticalSpacing(),
            AirportWidget(
              iconData: Icons.line_style,
              title: Text('거리', style: TextStyles.caption),
              airport: flightDetails.arrival,
              onPressed: () => _selectArrival(context),
            ),
            VerticalSpacing(),
            SegmentedControl<FlightType>(
              header: Text('남녀 구분', style: TextStyles.caption),
              value: flightDetails.flightType,
              children: flightTypeChildren,
              onValueChanged: (flightType) => flightDetailsBloc.updateWith(flightType: flightType),
            ),
            VerticalSpacing(),
            SegmentedControl<FlightClass>(
              header: Text('방 타입', style: TextStyles.caption),
              value: flightDetails.flightClass,
              children: flightClassChildren,
              onValueChanged: (flightClass) => flightDetailsBloc.updateWith(flightClass: flightClass),
            ),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
