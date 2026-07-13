import 'package:flutter/widgets.dart';

/// Adaptive layout breakpoints for Formulae Pro.
///
/// The app is expected to run on phones (compact), tablets / small windows
/// (medium) and web / desktop (expanded). These helpers centralise the width
/// thresholds so every responsive widget makes the same decision.
enum FormulaeBreakpoint { compact, medium, expanded }

/// Below this width the layout is treated as a single narrow column (phone).
const double kCompactMaxWidth = 700;

/// At/above [kCompactMaxWidth] and below this width the layout is "medium"
/// (two column grids, tablet sizing).
const double kMediumMaxWidth = 1100;

/// Width at/above which the persistent navigation switches from a bottom
/// [NavigationBar] to a left navigation rail, and the drawer becomes a
/// permanent sidebar.
const double kExpandedNavWidth = 900;

/// Maximum width the browsing content is allowed to occupy so it does not
/// sprawl edge to edge on ultrawide screens.
const double kMaxContentWidth = 1200;

/// Resolve the [FormulaeBreakpoint] for a raw pixel [width].
FormulaeBreakpoint breakpointForWidth(double width) {
  if (width >= kMediumMaxWidth) return FormulaeBreakpoint.expanded;
  if (width >= kCompactMaxWidth) return FormulaeBreakpoint.medium;
  return FormulaeBreakpoint.compact;
}

/// Number of columns a responsive menu button grid should use for [width].
///
/// 1 column on narrow phones, 2 on tablets/medium windows, 3 on wide desktop.
int menuColumnsForWidth(double width) {
  if (width >= kMediumMaxWidth) return 3;
  if (width >= kCompactMaxWidth) return 2;
  return 1;
}

/// Convenience accessors for the current breakpoint from a [BuildContext].
extension FormulaeBreakpointContext on BuildContext {
  FormulaeBreakpoint get formulaeBreakpoint =>
      breakpointForWidth(MediaQuery.sizeOf(this).width);

  /// True when the viewport is narrow enough to use a bottom navigation bar
  /// and a hidden hamburger drawer instead of a rail + permanent sidebar.
  bool get isCompactWidth => MediaQuery.sizeOf(this).width < kExpandedNavWidth;
}
