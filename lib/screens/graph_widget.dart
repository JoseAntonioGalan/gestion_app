// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_typing_uninitialized_variables
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

// ignore: use_key_in_widget_constructors
class GraphWidget extends StatefulWidget {
  final List<double> data;

  const GraphWidget({Key? key, required this.data}) : super(key: key);
  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    // ignore: unused_local_variable
    var time;
    final measures = <String, double>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      // ignore: avoid_function_literals_in_foreach_calls
      selectedDatum.forEach((SeriesDatum seriesDatum) {
        measures[seriesDatum.series.displayName!] = seriesDatum.datum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Series<double, num>> series = [
      Series<double, int>(
          id: "Gasto",
          colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
          data: widget.data,
          domainFn: (value, index) {
            if (index != null) {
              return index;
            } else {
              return 0;
            }
          },
          measureFn: (value, _) => value,
          strokeWidthPxFn: (_, __) => 4)
    ];

    // ignore: duplicate_ignore
    return LineChart(
      series,
      animate: false,
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      // ignore: prefer_const_constructors
      domainAxis: NumericAxisSpec(
        // ignore: prefer_const_literals_to_create_immutables
        tickProviderSpec: StaticNumericTickProviderSpec([
          TickSpec(0, label: '1'),
          TickSpec(4, label: '05'),
          TickSpec(9, label: '10'),
          TickSpec(14, label: '15'),
          TickSpec(19, label: '20'),
          TickSpec(24, label: '25'),
          TickSpec(29, label: '30'),
        ]),
      ),
      primaryMeasureAxis: NumericAxisSpec(
          tickProviderSpec: BasicNumericTickProviderSpec(
        desiredTickCount: 4,
      )),
    );
  }
}
