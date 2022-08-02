import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TrialOverview extends StatelessWidget {
  TrialOverview({Key? key}) : super(key: key);
  final Trial _trial = Trial.standard();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildRow(_trial),
        _buildRow(_trial)
      ],);
  }}

Widget _buildRow(Trial trial) {
  return ListTile(
    leading: trial.image,
    title: Text(trial.question),
    trailing: SizedBox(
        width: 50,
        child: SfRadialGauge(
            axes:<RadialAxis>[RadialAxis(
              axisLineStyle: (const AxisLineStyle(thickness: 5)),
              canScaleToFit : true,
              showLabels: false,
              showTicks: false,
              annotations: const <GaugeAnnotation>[
                GaugeAnnotation(widget: Text('10'))
              ],
            )]
        )),
  );
}

final Image defaultImage = Image.asset('assets/male-placeholder-image-768x768.jpeg');
const String defaultQuestion = 'the question';

class Trial {
  final Image image;
  final String question;

  Trial(this.image, this.question);

  Trial.standard() :
        image = defaultImage,
        question = defaultQuestion;
}
