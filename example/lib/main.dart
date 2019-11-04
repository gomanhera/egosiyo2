import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flutter/material.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/common_data.dart';
import 'app/class/common_http.dart';
import 'app/main_page.dart';

void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
  var data = new MyHttp().post(
    domain: '115.84.165.224',
    path: '/bigfile/iot/sheet/json/download.do',
    method: 'post',
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    },
    json:{
      "srvType": "S",
      "infId": "OA-118",
      "serviceKind": "1",
      "pageNo": "2",
      "gridTotalCnt": "127",
      "ssUserId": "SAMPLE_VIEW",
      "strWhere": "",
      "strOrderby": "",
      "ftr_LINE_NUM": "1",
      "filterCol": "필터선택",
      "txtFilter": ""
    }
  );
  data.then((data) => CommonData.setSubwayData(data));

  runApp(MyApp(airportLookup: AirportLookup()));
}

class MyApp extends StatelessWidget {
  MyApp({this.airportLookup});
  final AirportLookup airportLookup;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight CO2 calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(airportLookup: airportLookup)
//      Provider<FlightDetailsBloc>(
//        builder: (context) => FlightDetailsBloc(),
//        dispose: (context, bloc) => bloc.dispose(),
//        child: MainPage(airportLookup: airportLookup),
//        child: FlightPage(airportLookup: airportLookup),
//      ),
    );
  }
}
