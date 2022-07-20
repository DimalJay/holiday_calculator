import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialProgressWidget extends StatelessWidget {
  final int min;
  final int max;
  final int value;
  const RadialProgressWidget({
    Key? key,
    this.min = 0,
    required this.max,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            minimum: min.toDouble(),
            maximum: max.toDouble(),
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: Theme.of(context).colorScheme.primary.withAlpha(30),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: value.toDouble(),
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                animationType: AnimationType.ease,
                enableAnimation: true,
                animationDuration: 1000,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.1,
                  angle: 90,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value != 0
                            ? '${value.toStringAsFixed(0)} / ${max.toInt()}'
                            : "No",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(value == 1 ? "Day" : "Days")
                    ],
                  ))
            ])
      ],
    );
  }
}
