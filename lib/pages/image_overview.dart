import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class ImageOverview extends StatefulWidget {
  const ImageOverview({Key? key}) : super(key: key);

  @override
  State<ImageOverview> createState() => _ImageOverviewState();
}

class _ImageOverviewState extends State<ImageOverview> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
        TappableImage(),
      ],
    );
  }
}

class TappableImage extends StatelessWidget {
  const TappableImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.vRouter.to('/images/image'),
      child: Image.asset('assets/male-placeholder-image-768x768.jpeg'),
    );
  }
}
