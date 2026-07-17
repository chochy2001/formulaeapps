import 'package:flutter/material.dart';

/// Product identity mark for Formulae Pro.
///
/// Renders the app's own launcher icon (the integral / dy-dx motif) as a
/// rounded chip that reads cleanly on the dark navy surface. It intentionally
/// drops the old white background box that clashed with the navy chrome and it
/// no longer shows the CAPDESIS corporate logo, so a surface now presents a
/// single, coherent product mark instead of a doubled brand.
class ProductMark extends StatelessWidget {
  final double size;

  const ProductMark({
    super.key,
    this.size = 72.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: Image.asset(
        'assets/images/icono_app_nuevo.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

/// Compact product mark used at the top of the section menus. Kept as a thin
/// wrapper so the many existing call sites keep working while the visual is
/// unified through [ProductMark].
class ImagenLogoFormulae extends StatelessWidget {
  final double size;

  const ImagenLogoFormulae({
    super.key,
    this.size = 66.0,
  });

  @override
  Widget build(BuildContext context) {
    return ProductMark(size: size);
  }
}

/// Small, quiet "by Capdesis" credit for the drawer footer. Keeps the corporate
/// attribution present exactly once per surface without competing with the
/// product identity above it.
class CapdesisAttribution extends StatelessWidget {
  const CapdesisAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'by Capdesis',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF8B8CA8),
          fontSize: 12.0,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
