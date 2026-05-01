// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

const String _capdesisLogoViewType = 'capdesis-logo-img';
bool _capdesisLogoRegistered = false;

void _registerCapdesisLogoFactory() {
  if (_capdesisLogoRegistered) {
    return;
  }

  ui_web.platformViewRegistry.registerViewFactory(
    _capdesisLogoViewType,
    (int viewId) =>
        html.ImageElement(src: '/assets/assets/images/capdesis_logo.png')
          ..alt = 'CAPDESIS'
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'contain'
          ..style.display = 'block',
  );
  _capdesisLogoRegistered = true;
}

Widget buildCapdesisLogoImage() {
  _registerCapdesisLogoFactory();
  return const HtmlElementView(viewType: _capdesisLogoViewType);
}
