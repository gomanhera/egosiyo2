import 'package:auto_size_text/auto_size_text.dart';
import 'package:flight_co2_calculator_flutter/airport_lookup.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/palette.dart';
import 'package:flight_co2_calculator_flutter_example/app/constants/text_styles.dart';
import 'package:flight_co2_calculator_flutter_example/app/flight_calculation_card.dart';
import 'package:flight_co2_calculator_flutter_example/app/flight_details_card.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/conditions_bloc.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FlightPage extends StatelessWidget {
  FlightPage({this.airportLookup});
  final AirportLookup airportLookup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        backgroundColor: Palette.blueSky,
//        elevation: 2.0,
//        backgroundColor: Colors.white,
        title: Text('이고시요', style: TextStyle(fontFamily: 'Raleway', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20.0)),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final conditionsBloc = Provider.of<ConditionsBloc>(context);
    return StreamBuilder<Condition>(
      stream: conditionsBloc.conditionStream,
      initialData: Condition.initialData(),
      builder: (context, snapshot) {
        return Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//              colors: Colors.white,
////              colors: [
////                Palette.blueSky,
////                Palette.greenLand,
////              ],
//            ),
//          ),
          color: Colors.white,

          padding: const EdgeInsets.all(8.0),
          child: SafeArea(

            child: Column(

              children: <Widget>[
                ConditionsCard(
                  airportLookup: airportLookup,
                  conditions: snapshot.data,
                  conditionsBloc: conditionsBloc,
                ),

//                FlightCalculationCard(
//                  flightCalculationData: snapshot.data.distance,
//                ),
                Expanded(child: Container()),
                Container
                  (
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                  child: Material
                    (
                    elevation: 12.0,
                    color: Palette.blueSky,
                    borderRadius: BorderRadius.circular(4.0),
                    child: InkWell
                      (
                      onTap: () {},
                      child: Padding
                        (
                        padding: EdgeInsets.all(12.0),
                        child: Row
                          (
//                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            Icon(Icons.airplay, color: Colors.white),
                            Padding(padding: EdgeInsets.only(right: 16.0)),
                            Text('내방 경매 시작', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                AutoSizeText(
                  'egosiyo.com',
                  minFontSize: 11.0,
                  maxLines: 1,
                  style: TextStyles.caption,
                ),
                AutoSizeText(
                  'All Right Reserved',
                  minFontSize: 11.0,
                  maxLines: 1,
                  style: TextStyles.caption,
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
