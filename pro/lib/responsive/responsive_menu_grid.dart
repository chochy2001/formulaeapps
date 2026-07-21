import 'package:flutter/material.dart';

import '../widgets_personalizados/botones/botones_menus.dart';
import 'breakpoints.dart';

/// Centres [child] horizontally and caps its width so browsing content does not
/// stretch edge to edge on wide screens.
class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = kMaxContentWidth,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Lays a list of menu buttons out as a responsive grid: a single column on
/// narrow phones, two columns on tablets and three columns on wide desktop /
/// web. The grid is centred and width capped so it does not sprawl.
///
/// The individual buttons keep their own outer margin, so no extra spacing is
/// added between cells; that keeps the narrow single-column layout visually
/// identical to the previous plain [Column].
class ResponsiveMenuGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveMenuGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final double contentWidth = available > kMaxContentWidth
            ? kMaxContentWidth
            : available;
        final int columns = menuColumnsForWidth(contentWidth);
        final double cellWidth = contentWidth / columns;
        return Center(
          child: SizedBox(
            width: contentWidth,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final Widget child in children)
                  SizedBox(width: cellWidth, child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Drop-in replacement for the plain [Column] used by the menu screens.
///
/// Header widgets (logo, section title, spacers) are rendered full width in
/// order, while consecutive [BotonesMenu] buttons are grouped into a
/// [ResponsiveMenuGrid]. This lets every existing menu become a responsive grid
/// by changing a single `Column(` to `MenuColumn(`, without restructuring the
/// screen or breaking the narrow phone layout.
class MenuColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const MenuColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    final List<Widget> buttonBuffer = <Widget>[];

    void flush() {
      if (buttonBuffer.isEmpty) return;
      rows.add(ResponsiveMenuGrid(children: List<Widget>.of(buttonBuffer)));
      buttonBuffer.clear();
    }

    for (final Widget child in children) {
      if (child is BotonesMenu) {
        buttonBuffer.add(child);
      } else {
        flush();
        rows.add(child);
      }
    }
    flush();

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: rows,
    );
  }
}

/// Lays formula / notes blocks out in responsive columns on wide screens while
/// keeping a single column on narrow phones. A single tall formula is never
/// split: each [children] entry stays intact inside its own cell, and wide
/// LaTeX may still scroll horizontally within that cell.
class ResponsiveFormulaColumns extends StatelessWidget {
  final List<Widget> children;
  final double runSpacing;
  final double spacing;

  const ResponsiveFormulaColumns({
    super.key,
    required this.children,
    this.runSpacing = 12,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final double contentWidth = available > kMaxContentWidth
            ? kMaxContentWidth
            : available;
        // Only split into multiple columns once there is comfortable room.
        final int columns = contentWidth >= kMediumMaxWidth
            ? 2
            : (contentWidth >= kCompactMaxWidth ? 2 : 1);
        if (columns == 1) {
          return Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(mainAxisSize: MainAxisSize.min, children: children),
            ),
          );
        }
        final double cellWidth =
            (contentWidth - spacing * (columns - 1)) / columns;
        return Center(
          child: SizedBox(
            width: contentWidth,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: spacing,
              runSpacing: runSpacing,
              children: <Widget>[
                for (final Widget child in children)
                  SizedBox(width: cellWidth, child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}
