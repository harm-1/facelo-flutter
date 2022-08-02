import 'package:flutter/material.dart';

class Vote extends StatelessWidget {
  const Vote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/male-placeholder-image-768x768.jpeg'),
            ),),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/male-placeholder-image-768x768.jpeg'),
            ),),
        ],
    );
  }
}




