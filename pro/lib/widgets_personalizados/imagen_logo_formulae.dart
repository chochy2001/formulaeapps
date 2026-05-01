import 'package:flutter/material.dart';

import 'capdesis_logo_image.dart';

class CapdesisLogo extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final bool showBackground;

  const CapdesisLogo({
    Key? key,
    this.height = 100.0,
    this.width = 100.0,
    this.padding = 10.0,
    this.showBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = buildCapdesisLogoImage();

    if (!showBackground) {
      return SizedBox(
        height: height,
        width: width,
        child: logo,
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: logo,
        ),
      ),
    );
  }
}

class ImagenLogoFormulae extends StatelessWidget {
  const ImagenLogoFormulae({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CapdesisLogo();
  }
}
