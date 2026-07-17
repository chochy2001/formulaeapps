import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../constantes/constantes_codigo.dart';

/// Ancho de la banda de desvanecido (en pixeles) usada para insinuar que hay
/// mas contenido a los lados cuando la formula sigue siendo scrolleable.
const double _kFadeWidth = 28.0;

/// Escala minima permitida al reducir una formula para que quepa sin scroll.
/// Por debajo de este piso la formula se volveria ilegible, asi que en su lugar
/// se conserva el scroll horizontal con una pista visual de desvanecido.
const double _kMinScale = 0.65;

/// Llaves de prueba para verificar que modo de presentacion quedo activo.
@visibleForTesting
const Key kAdaptiveFormulaFitKey = ValueKey('adaptive-formula-fit');
@visibleForTesting
const Key kAdaptiveFormulaFadeKey = ValueKey('adaptive-formula-fade-viewport');

typedef _OnSizeChange = void Function(Size size);

/// Presenta una formula LaTeX en pantalla evitando que se recorte en silencio.
///
/// Comportamiento:
/// 1. Mide el ancho intrinseco de la formula contra el ancho disponible.
/// 2. Si cabe: la centra sin scroll ni escalado.
/// 3. Si se pasa un poco: la reduce con [FittedBox] (BoxFit.scaleDown) hasta un
///    piso legible ([_kMinScale]).
/// 4. Si aun con el piso no cabe: conserva scroll horizontal y agrega un
///    desvanecido suave ([ShaderMask]) en los bordes con contenido oculto para
///    que el usuario sepa que puede deslizar.
class AdaptiveFormula extends StatefulWidget {
  final String formulaText;
  final TextStyle textStyle;
  final Color surfaceColor;
  final double minScale;
  final double widthFactor;

  const AdaptiveFormula({
    super.key,
    required this.formulaText,
    this.textStyle = kTextoLatexFormulas,
    this.surfaceColor = kColorFondo,
    this.minScale = _kMinScale,
    this.widthFactor = 0.95,
  });

  @override
  State<AdaptiveFormula> createState() => _AdaptiveFormulaState();
}

class _AdaptiveFormulaState extends State<AdaptiveFormula> {
  Size? _intrinsic;

  Widget _math() => Math.tex(
        widget.formulaText,
        mathStyle: MathStyle.display,
        textStyle: widget.textStyle,
      );

  @override
  void didUpdateWidget(covariant AdaptiveFormula oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.formulaText != widget.formulaText ||
        oldWidget.textStyle != widget.textStyle) {
      _intrinsic = null;
    }
  }

  void _onMeasured(Size size) {
    if (!mounted) return;
    final prev = _intrinsic;
    if (prev != null &&
        (prev.width - size.width).abs() < 0.5 &&
        (prev.height - size.height).abs() < 0.5) {
      return;
    }
    setState(() => _intrinsic = size);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cap = screenWidth * widget.widthFactor;
        final available = constraints.maxWidth.isFinite
            ? math.min(cap, constraints.maxWidth)
            : cap;

        // Copia de medicion: fuera de pantalla y con ancho ilimitado para
        // obtener el ancho intrinseco real de la formula. Colapsa a cero, por
        // lo que no altera el layout visible.
        final measure = Offstage(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _MeasureSize(
              onChange: _onMeasured,
              child: _math(),
            ),
          ),
        );

        final content = _buildContent(available);

        return Stack(
          alignment: Alignment.center,
          children: [content, measure],
        );
      },
    );
  }

  Widget _buildContent(double available) {
    final intrinsic = _intrinsic;

    // Primer frame (sin medida aun): escala hacia abajo para no recortar nunca.
    if (intrinsic == null || intrinsic.width <= 0) {
      return SizedBox(
        width: available,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: _math(),
        ),
      );
    }

    // Cabe: se centra tal cual.
    if (intrinsic.width <= available) {
      return SizedBox(
        key: kAdaptiveFormulaFitKey,
        width: available,
        child: Center(child: _math()),
      );
    }

    // Se pasa poco: reducir con FittedBox se mantiene por encima del piso.
    if (intrinsic.width * widget.minScale <= available) {
      return SizedBox(
        key: kAdaptiveFormulaFitKey,
        width: available,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: _math(),
        ),
      );
    }

    // Demasiado ancha aun al piso: escalar al piso y conservar scroll + fade.
    final scaledWidth = intrinsic.width * widget.minScale;
    final scaledHeight = intrinsic.height * widget.minScale;
    final scaled = SizedBox(
      width: scaledWidth,
      height: scaledHeight,
      child: FittedBox(
        fit: BoxFit.contain,
        child: _math(),
      ),
    );

    return _ScrollableFadingFormula(
      viewportWidth: available,
      contentWidth: scaledWidth,
      surfaceColor: widget.surfaceColor,
      child: scaled,
    );
  }
}

/// Formula scrolleable horizontalmente con desvanecido en los bordes que tienen
/// contenido oculto. El desvanecido se actualiza al hacer scroll mediante un
/// [ScrollController] con listener.
class _ScrollableFadingFormula extends StatefulWidget {
  final double viewportWidth;
  final double contentWidth;
  final Color surfaceColor;
  final Widget child;

  const _ScrollableFadingFormula({
    required this.viewportWidth,
    required this.contentWidth,
    required this.surfaceColor,
    required this.child,
  });

  @override
  State<_ScrollableFadingFormula> createState() =>
      _ScrollableFadingFormulaState();
}

class _ScrollableFadingFormulaState extends State<_ScrollableFadingFormula> {
  final ScrollController _controller = ScrollController();
  late bool _canScrollLeft;
  late bool _canScrollRight;

  @override
  void initState() {
    super.initState();
    _canScrollLeft = false;
    _canScrollRight = widget.contentWidth > widget.viewportWidth + 0.5;
    _controller.addListener(_updateEdges);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateEdges());
  }

  @override
  void didUpdateWidget(covariant _ScrollableFadingFormula oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contentWidth != widget.contentWidth ||
        oldWidget.viewportWidth != widget.viewportWidth) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateEdges());
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateEdges);
    _controller.dispose();
    super.dispose();
  }

  void _updateEdges() {
    if (!mounted || !_controller.hasClients) return;
    final position = _controller.position;
    final canLeft = position.pixels > position.minScrollExtent + 0.5;
    final canRight = position.pixels < position.maxScrollExtent - 0.5;
    if (canLeft != _canScrollLeft || canRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  LinearGradient _fadeGradient() {
    final fraction = widget.viewportWidth <= 0
        ? 0.0
        : (_kFadeWidth / widget.viewportWidth).clamp(0.0, 0.45);
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        _canScrollLeft ? Colors.transparent : Colors.white,
        Colors.white,
        Colors.white,
        _canScrollRight ? Colors.transparent : Colors.white,
      ],
      stops: [0.0, fraction, 1.0 - fraction, 1.0],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scroller = SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: widget.child,
    );

    return SizedBox(
      key: kAdaptiveFormulaFadeKey,
      width: widget.viewportWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (rect) => _fadeGradient().createShader(rect),
            blendMode: BlendMode.dstIn,
            child: scroller,
          ),
          if (_canScrollLeft)
            const Positioned(
              left: 2,
              top: 0,
              bottom: 0,
              child: _ChevronHint(icon: Icons.chevron_left),
            ),
          if (_canScrollRight)
            const Positioned(
              right: 2,
              top: 0,
              bottom: 0,
              child: _ChevronHint(icon: Icons.chevron_right),
            ),
        ],
      ),
    );
  }
}

/// Pista de chevron sutil que refuerza la insinuacion de "hay mas, desliza".
class _ChevronHint extends StatelessWidget {
  final IconData icon;

  const _ChevronHint({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Icon(
          icon,
          size: 20.0,
          color: kColorAmarilloCapdesis.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}

/// Reporta el tamano medido de su hijo mediante [onChange] tras cada layout.
class _MeasureSize extends SingleChildRenderObjectWidget {
  final _OnSizeChange onChange;

  const _MeasureSize({
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _MeasureSizeRenderObject(onChange);

  @override
  void updateRenderObject(
    BuildContext context,
    _MeasureSizeRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  Size? _oldSize;
  _OnSizeChange onChange;

  _MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();
    final newSize = child?.size ?? Size.zero;
    if (_oldSize == newSize) return;
    _oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
  }
}
