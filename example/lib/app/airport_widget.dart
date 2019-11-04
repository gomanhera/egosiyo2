import 'package:auto_size_text/auto_size_text.dart';
import 'package:flight_co2_calculator_flutter/airport.dart';
import 'package:flight_co2_calculator_flutter_example/app/common_widgets/vertical_spacing.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/conditions_bloc.dart';
import 'package:flight_co2_calculator_flutter_example/blocs/flight_details_bloc.dart';
import 'package:flutter/material.dart';

class SelectedWidget extends StatelessWidget {
  SelectedWidget({this.iconData, this.title, this.selected, this.onPressed});
  /// icon data to use (normally Icons.flight_takeoff or Icons.flight_land)
  final IconData iconData;
  /// Title to show
  final Widget title;
  /// Airport to show
  final Condition selected;
//  final Airport airport;
//  final Map<String, String> airport;
//  final Location location;
//  final Distance distance;

  /// Callback that fires when the user taps on this widget
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    print('@@@@ 1');
    print(selected);
    print(selected.details);

    final selectedDisplayName =
    selected.details.location != null ? selected.details.location.location['station_nm'] + '역 (' + selected.details.location.location['line_nm'] + ')' : 'Select...';

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(iconData),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  VerticalSpacing(height: 4.0),
                  AutoSizeText(
                    selectedDisplayName,
                    style: TextStyle(fontSize: 16.0),
                    minFontSize: 13.0,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(height: 1.0, color: Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
