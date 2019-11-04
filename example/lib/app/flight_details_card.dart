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
import 'package:flight_co2_calculator_flutter_example/blocs/conditions_bloc.dart';
//import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';

class ConditionsCard extends StatelessWidget {
  ConditionsCard({
    @required this.conditions,
    @required this.airportLookup,
    @required this.conditionsBloc,
  });
  final Condition conditions;
  final ConditionsBloc conditionsBloc;
  final AirportLookup airportLookup;

  final Map<RoomType, Widget> roomTypeChildren = const <RoomType, Widget>{
    RoomType.mini: Text('미니룸'),
    RoomType.shower: Text('샤워룸'),
    RoomType.one: Text('원룸'),
    RoomType.any: Text('무관')
  };

  final Map<SexSeparation, Widget> sexSeperationChildren = const <SexSeparation, Widget>{
    SexSeparation.together:Text('남녀 혼용'),
    SexSeparation.seperated:Text('남녀 분리'),
    SexSeparation.any:Text('무관')
  };

  Future<Location> _showLocationSearch(BuildContext context) async {
    return await showSearch<Location>(
        context: context,
        delegate: AirportSearchDelegate(
          airportLookup: airportLookup,
        ));
  }
//  Future<Distance> _showDistanceSearch(BuildContext context) async {
//    return await showSearch<Distance>(
//        context: context,
//        delegate: AirportSearchDelegate(
//          airportLookup: airportLookup,
//        ));
//  }

  void _selectLocation(BuildContext context) async {
    final Location location = await _showLocationSearch(context);
    conditionsBloc.updateWith(
        location: location
    );
  }
//  void _selectDistance(BuildContext context) async {
//    final Distance distance = await _showDistanceSearch(context);
//    conditionsBloc.updateWith(
//        distance: distance
//    );
//  }

//  void _selectDistance(BuildContext context) async {
//    final arrival = await _showSearch(context);
//    distanceBloc.updateWith2(
//        subway_nm: arrival["subway_nm"],
//        line_nm: arrival["line_nm"]
//    );
////    flightDetailsBloc.updateWith(arrival: arrival);
//  }

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
            SelectedWidget(
              iconData: Icons.subway,
              title: Text('기준 장소', style: TextStyles.caption),
              selected: conditions,
              onPressed: () => _selectLocation(context),
            ),
            VerticalSpacing(),
//            SelectedWidget(
//              iconData: Icons.line_style,
//              title: Text('거리', style: TextStyles.caption),
//              selected: conditions,
//              onPressed: () => _selectDistance(context),
//            ),
//            VerticalSpacing(),
            SegmentedControl<SexSeparation>(
              header: Text('남녀 구분', style: TextStyles.caption),
              value: conditions.details.sexSeperation,
              children: sexSeperationChildren,
              onValueChanged: (sexSeperation) => conditionsBloc.updateWith(sexSeperation: sexSeperation),
            ),
            VerticalSpacing(),
            SegmentedControl<RoomType>(
              header: Text('방 타입', style: TextStyles.caption),
              value: conditions.details.roomType,
              children: roomTypeChildren,
              onValueChanged: (roomType) => conditionsBloc.updateWith(roomType: roomType),
            ),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }
}


