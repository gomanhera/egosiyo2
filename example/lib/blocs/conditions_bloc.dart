import 'dart:async';
import 'package:rxdart/rxdart.dart';

enum RoomType {
  mini, shower, one, any
}

enum SexSeparation {
  together, seperated, any
}

class Location {
  final Map<String, String> location;

  Location(this.location);
}
class Distance {
  final Map<String, String> distance;

  Distance(this.distance);
}
/// Model for the ConditionDetailCard
class ConditionDetail {
  ConditionDetail({
    this.location,
    this.distance,
    this.roomType = RoomType.any,
    this.sexSeperation = SexSeparation.any,
  });
  final Location location;
  final Distance distance;
  final RoomType roomType;
  final SexSeparation sexSeperation;

  ConditionDetail copyWith(
      {Location location,
        Distance distance,
        RoomType roomType,
        SexSeparation sexSeperation}) {
    return ConditionDetail(
      location: location ?? this.location,
      distance: distance ?? this.distance,
      roomType: roomType ?? this.roomType,
      sexSeperation: sexSeperation ?? this.sexSeperation,
    );
  }
}

/// Model for the ConditionCalculationCard
class ConditionData {
  ConditionData({this.distanceKm, this.co2e});
  final double distanceKm;
  final double co2e;

  String get distanceFormatted {
    return distanceKm != null ? '${distanceKm.roundToDouble().toInt()} km' : '';
  }

  String get co2eFormatted {
//    if (co2e != null) {
//      double tonnes = co2e / 1000.0;
//      final formatter = NumberFormat.decimalPattern();
//      return '${formatter.format(tonnes)} t';
//    }
    return '';
  }

  /// factory method to calculate the distance and co2 from the condition details
  factory ConditionData.fromDetails(ConditionDetail conditionDetails) {
    double distanceKm;
    double co2e;
    Location location = conditionDetails.location;
    Distance distance = conditionDetails.distance;
//    if (location != null && distance != null) {
//      double multiplier =
//      conditionDetails.sexSeperation == SexSeparation.any ? 1.0 : 2.0;
//      distanceKm = DistanceCalculator.distanceInKmBetween(
//          location.location, distance.location);
//      distanceKm = CO2Calculator.correctedDistanceKm(distanceKm);
//      co2e =
//          CO2Calculator.calculateCO2e(distanceKm, conditionDetails.roomType) *
//              multiplier;
//    }
    return ConditionData(distanceKm: distanceKm, co2e: co2e);
  }
}



/// Model for the ConditionPage
class Condition {
  Condition({this.details, this.data});
  final ConditionDetail details;
  final ConditionData data;

  /// Initial empty data to be used as the seed value for the stream
  factory Condition.initialData() {
    return Condition(
      details: ConditionDetail(),
      data: ConditionData(),
    );
  }

  Condition copyWith({
    Location location,
    Distance distance,
    RoomType roomType,
    SexSeparation sexSeperation,
  }) {
    // get existing details and update
    ConditionDetail conditionDetails = details.copyWith(
      location: location,
      distance: distance,
      roomType: roomType,
      sexSeperation: sexSeperation,
    );
    // calculate corresponding data
    ConditionData conditionData = ConditionData.fromDetails(conditionDetails);
    // return new object
    return Condition(
      details: conditionDetails,
      data: conditionData,
    );
  }
}

/// Bloc used by the ConditionPage
class ConditionsBloc {
  BehaviorSubject _conditionSubject =
      BehaviorSubject<Condition>.seeded(Condition.initialData());
  Stream<Condition> get conditionStream => _conditionSubject.controller.stream;

  void updateWith({
    Location location,
    Distance distance,
    RoomType roomType,
    SexSeparation sexSeperation,
  }) {
    // get new value by updating existing one
    Condition newValue = _conditionSubject.value.copyWith(
      location: location,
      distance: distance,
      roomType: roomType,
      sexSeperation: sexSeperation,
    );
    // add back to the stream
    _conditionSubject.add(newValue);
  }

  dispose() {
    _conditionSubject.close();
  }
}
