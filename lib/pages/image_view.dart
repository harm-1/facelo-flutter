import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImageView extends StatelessWidget {
  ImageView({Key? key}) : super(key: key);
  final Trial _trial = Trial.standard();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0), 
          margin: const EdgeInsets.all(20.0),
          child: Image.asset('assets/male-placeholder-image-768x768.jpeg'),
        ),
        _buildRow(_trial),
        _buildRow(_trial),
        _buildRow(_trial),
        _buildRow(_trial),
        _buildRow(_trial),
        _buildRow(_trial)
      ],);
        // Image.asset('assets/male-placeholder-image-768x768.jpeg'),
  }
}


Widget _buildRow(Trial trial) {
  return ListTile(
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
