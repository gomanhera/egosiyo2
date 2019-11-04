
import 'package:flight_co2_calculator_flutter/airport.dart';

class AirportLookup {
  AirportLookup({this.airports});
  final List<Airport> airports;

  Airport searchIata(String iata) {
    return airports.firstWhere((airport) => airport.iata == iata);
  }

  List<Map<String, String>> searchString2(List<dynamic> subwayList, String query) {
    List<Map<String, String>> result = [];
    for(var i = 0 ; i < subwayList.length ; i++){
      if(subwayList[i]["station_nm"].contains(query)){
        result.add({
          "station_nm" : subwayList[i]["station_nm"],
          "line_nm" : subwayList[i]["line_nm"]
        });
      }
    }
    return result;
  }
  List<Airport> searchString(String string) {
    string = string.toLowerCase();
    final matching = airports.where((airport) {
      final iata = airport.iata ?? '';
      return iata.toLowerCase() == string ||
          airport.name.toLowerCase() == string ||
          airport.city.toLowerCase() == string ||
          airport.country.toLowerCase() == string;
    }).toList();
    // found exact matches
    if (matching.length > 0) {
      return matching;
    }
    // search again with less strict criteria
    return airports.where((airport) {
      final iata = airport.iata ?? '';
      return iata.toLowerCase().contains(string) ||
          airport.name.toLowerCase().contains(string) ||
          airport.city.toLowerCase().contains(string) ||
          airport.country.toLowerCase().contains(string);
    }).toList();
  }
}
