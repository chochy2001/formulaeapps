#!/usr/bin/env bun

/**
 * Converts Formulae's recovered legacy diagrams into a single visual set that
 * is safe to show for every locale. Technical notation remains in the image;
 * natural-language labels are deliberately removed so the Flutter UI owns all
 * translated explanatory copy.
 *
 * This is intentionally deterministic. It avoids asking an image model to
 * redraw circuit topology or mathematical diagrams, which could introduce a
 * correctness error. FAQ screenshots are replaced with language-free vector
 * illustrations because a captured interface always contains locale-specific
 * text.
 */
import { execFile as execFileCallback } from 'node:child_process';
import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

import sharp from 'sharp';

const execFile = promisify(execFileCallback);
const scriptDirectory = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.resolve(scriptDirectory, '..', '..');
const imageDirectory = path.join(repositoryRoot, 'landing', 'public', 'imagenes');
const navy = '#27283D';
const ink = '#E8E8F0';
const gold = '#F3A73D';
const red = '#FF6B6B';
const blue = '#6BA9FF';

const mathematicalTokens = new Set([
  'sin',
  'sen',
  'cos',
  'tan',
  'cot',
  'sec',
  'csc',
  'log',
  'ln',
  'lim',
  'max',
  'min',
  'mod',
  'det',
  'arg',
  'rank',
  'grad',
  'div',
  'curl',
]);

// CAPDESIS is a proper-name logo, not translatable instructional copy.
const visualBrandAssets = new Set(['capdesispng.png']);

function svgDocument(body) {
  return Buffer.from(
    [
      '<?xml version="1.0" encoding="UTF-8"?>',
      '<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="768" viewBox="0 0 1024 768">',
      '<defs>',
      '<marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">',
      '<path d="M 0 0 L 10 5 L 0 10 z" fill="',
      ink,
      '"/>',
      '</marker>',
      '</defs>',
      '<rect width="1024" height="768" fill="',
      navy,
      '"/>',
      body,
      '</svg>',
    ].join('')
  );
}

function mathInputSvg(value, accent = red) {
  return svgDocument(
    '<rect x="170" y="220" width="684" height="328" rx="32" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M270 384 H754" stroke="' +
      gold +
      '" stroke-width="8" stroke-linecap="round"/>' +
      '<text x="512" y="420" text-anchor="middle" fill="' +
      accent +
      '" font-family="Arial, Helvetica, sans-serif" font-size="128" font-weight="700">' +
      value +
      '</text>'
  );
}

function fontSizeSvg(multiplier) {
  const size = multiplier === 'small' ? 170 : multiplier === 'large' ? 300 : 230;
  return svgDocument(
    '<circle cx="512" cy="384" r="252" fill="none" stroke="' +
      gold +
      '" stroke-width="14"/>' +
      '<text x="512" y="470" text-anchor="middle" fill="' +
      ink +
      '" font-family="Arial, Helvetica, sans-serif" font-size="' +
      size +
      '" font-weight="700">A</text>' +
      '<path d="M790 286 V482 M694 384 H886" stroke="' +
      blue +
      '" stroke-width="18" stroke-linecap="round"/>'
  );
}

function cropSvg() {
  return svgDocument(
    '<rect x="188" y="194" width="648" height="380" rx="24" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M156 274 H252 M156 274 V370 M868 498 H772 M868 498 V402" stroke="' +
      red +
      '" stroke-width="14" stroke-linecap="round"/>' +
      '<path d="M320 384 H704" stroke="' +
      gold +
      '" stroke-width="14" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      '<text x="512" y="432" text-anchor="middle" fill="' +
      ink +
      '" font-family="Arial, Helvetica, sans-serif" font-size="112">∑</text>'
  );
}

function rootSvg(result) {
  return svgDocument(
    '<path d="M226 454 L328 554 L442 236 H782" fill="none" stroke="' +
      ink +
      '" stroke-width="20" stroke-linecap="round" stroke-linejoin="round"/>' +
      '<text x="593" y="474" text-anchor="middle" fill="' +
      (result ? gold : blue) +
      '" font-family="Arial, Helvetica, sans-serif" font-size="164" font-weight="700">' +
      (result ? '?' : '−1') +
      '</text>'
  );
}

function documentSvg(action) {
  const base =
    '<path d="M314 134 H614 L756 276 V632 H314 Z" fill="none" stroke="' +
    ink +
    '" stroke-width="16" stroke-linejoin="round"/>' +
    '<path d="M614 134 V276 H756" fill="none" stroke="' +
    ink +
    '" stroke-width="16" stroke-linejoin="round"/>';

  if (action === 'eye') {
    return svgDocument(
      base +
        '<path d="M382 432 C454 326 570 326 642 432 C570 538 454 538 382 432 Z" fill="none" stroke="' +
        blue +
        '" stroke-width="18"/>' +
        '<circle cx="512" cy="432" r="38" fill="' +
        blue +
        '"/>'
    );
  }
  if (action === 'more') {
    return svgDocument(
      base +
        '<circle cx="512" cy="348" r="23" fill="' +
        gold +
        '"/><circle cx="512" cy="432" r="23" fill="' +
        gold +
        '"/><circle cx="512" cy="516" r="23" fill="' +
        gold +
        '"/>'
    );
  }
  if (action === 'download') {
    return svgDocument(
      base +
        '<path d="M512 324 V508 M438 440 L512 514 L586 440 M402 558 H622" fill="none" stroke="' +
        gold +
        '" stroke-width="20" stroke-linecap="round" stroke-linejoin="round"/>'
    );
  }
  return svgDocument(
    base +
      '<path d="M406 380 H618 M406 444 H618 M406 508 H564" stroke="' +
      blue +
      '" stroke-width="18" stroke-linecap="round"/>'
  );
}

function wifiSvg(action) {
  if (action === 'toggle') {
    return svgDocument(
      '<rect x="220" y="294" width="584" height="180" rx="90" fill="' +
        blue +
        '"/><circle cx="690" cy="384" r="66" fill="' +
        ink +
        '"/><path d="M256 538 H768" stroke="' +
        gold +
        '" stroke-width="18" stroke-linecap="round"/>'
    );
  }
  if (action === 'play') {
    return svgDocument(
      '<path d="M304 190 H720 V578 H304 Z" fill="none" stroke="' +
        ink +
        '" stroke-width="16"/><path d="M462 290 L650 384 L462 478 Z" fill="' +
        gold +
        '"/><path d="M714 548 L752 586 L824 502" fill="none" stroke="' +
        blue +
        '" stroke-width="18" stroke-linecap="round" stroke-linejoin="round"/>'
    );
  }
  if (action === 'waiting') {
    return svgDocument(
      '<circle cx="512" cy="384" r="172" fill="none" stroke="' +
        ink +
        '" stroke-width="20" stroke-dasharray="64 38"/><path d="M512 384 V260 M512 384 L610 446" stroke="' +
        gold +
        '" stroke-width="18" stroke-linecap="round"/>'
    );
  }
  return svgDocument(
    '<path d="M246 326 C394 178 630 178 778 326 M314 394 C426 282 598 282 710 394 M382 462 C456 388 568 388 642 462" fill="none" stroke="' +
      blue +
      '" stroke-width="24" stroke-linecap="round"/><circle cx="512" cy="538" r="26" fill="' +
      gold +
      '"/>'
  );
}

function symbol(value, x, y, color = ink, size = 34, weight = 600, anchor = 'middle') {
  const escapedValue = String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;');
  return (
    '<text x="' +
    x +
    '" y="' +
    y +
    '" text-anchor="' +
    anchor +
    '" fill="' +
    color +
    '" font-family="Arial, Helvetica, sans-serif" font-size="' +
    size +
    '" font-weight="' +
    weight +
    '">' +
    escapedValue +
    '</text>'
  );
}

function resistor(x, y, length = 170) {
  const step = length / 8;
  const points = Array.from({ length: 9 }, (_, index) => {
    const offsetY = index === 0 || index === 8 ? 0 : index % 2 === 0 ? -22 : 22;
    return x + index * step + ',' + (y + offsetY);
  }).join(' ');
  return (
    '<polyline points="' +
    points +
    '" fill="none" stroke="' +
    ink +
    '" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"/>'
  );
}

function capacitorSvg(includeField) {
  const charges = [258, 358, 458]
    .map((y) => symbol('+', 322, y, red, 42) + symbol('−', 702, y, blue, 42))
    .join('');
  const field = includeField
    ? [252, 352, 452]
        .map(
          (y) =>
            '<path d="M380 ' +
            y +
            ' H642" stroke="' +
            blue +
            '" stroke-width="8" stroke-linecap="round" marker-end="url(#arrow)"/>'
        )
        .join('') + symbol('E', 512, 222, blue, 40)
    : '';
  const relation = includeField ? 'V = E·d' : 'C = ε₀A/d';
  return svgDocument(
    '<rect x="344" y="176" width="32" height="388" rx="6" fill="' +
      ink +
      '"/><rect x="648" y="176" width="32" height="388" rx="6" fill="' +
      ink +
      '"/><path d="M360 610 H664" stroke="' +
      gold +
      '" stroke-width="6" marker-start="url(#arrow)" marker-end="url(#arrow)"/>' +
      '<path d="M360 588 V630 M664 588 V630" stroke="' +
      gold +
      '" stroke-width="5"/>' +
      symbol('+Q', 322, 140, red, 36) +
      symbol('−Q', 702, 140, blue, 36) +
      symbol('A', 258, 356, gold, 38) +
      symbol('d', 512, 666, gold, 38) +
      charges +
      field +
      symbol(relation, 512, 734, ink, 38)
  );
}

function rcCircuitSvg() {
  return svgDocument(
    '<path d="M192 218 H308 M414 218 H492 M704 218 H812 V550 H192 V450 M192 318 V218" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round" stroke-linejoin="round"/>' +
      '<path d="M308 218 H372 L414 182" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/><circle cx="308" cy="218" r="10" fill="' +
      gold +
      '"/>' +
      resistor(492, 218, 212) +
      '<path d="M142 350 H242 M120 418 H264" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<path d="M812 332 H714 M812 414 H714" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M738 332 V414" stroke="' +
      gold +
      '" stroke-width="4" stroke-dasharray="8 10"/>' +
      '<path d="M450 166 H678" stroke="' +
      red +
      '" stroke-width="8" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('+', 94, 430, red, 36) +
      symbol('−', 94, 360, blue, 36) +
      symbol('V', 142, 302, gold, 36) +
      symbol('S', 358, 160, gold, 36) +
      symbol('R', 598, 170, gold, 36) +
      symbol('C', 864, 386, gold, 36) +
      symbol('+q', 690, 310, red, 34) +
      symbol('−q', 690, 450, blue, 34) +
      symbol('i', 564, 142, red, 38)
  );
}

function rcChargeSvg() {
  return svgDocument(
    '<path d="M204 214 H354 M566 214 H790 V548 H204 V446 M204 322 V214" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round" stroke-linejoin="round"/>' +
      resistor(354, 214, 212) +
      '<path d="M154 352 H254 M132 418 H276" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<path d="M790 328 H694 M790 410 H694" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M718 328 V410" stroke="' +
      gold +
      '" stroke-width="4" stroke-dasharray="8 10"/>' +
      '<path d="M286 166 H660" stroke="' +
      red +
      '" stroke-width="8" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('+', 116, 430, red, 36) +
      symbol('−', 116, 362, blue, 36) +
      symbol('V', 150, 304, gold, 36) +
      symbol('R', 462, 168, gold, 36) +
      symbol('C', 842, 382, gold, 36) +
      symbol('+q', 672, 306, red, 34) +
      symbol('−q', 672, 446, blue, 34) +
      symbol('i', 486, 142, red, 38) +
      symbol('V = iR + q/C', 512, 694, ink, 42)
  );
}

function seriesCircuitSvg() {
  return svgDocument(
    '<path d="M198 206 H304 M496 206 H546 M738 206 H826 V562 H198 V450 M198 318 V206" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round" stroke-linejoin="round"/>' +
      resistor(304, 206, 192) +
      resistor(546, 206, 192) +
      '<path d="M148 350 H248 M126 418 H270" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<path d="M274 148 H754" stroke="' +
      red +
      '" stroke-width="8" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('+', 104, 430, red, 36) +
      symbol('−', 104, 360, blue, 36) +
      symbol('V', 150, 300, gold, 36) +
      symbol('R₁', 400, 158, gold, 36) +
      symbol('R₂', 640, 158, gold, 36) +
      symbol('i', 512, 126, red, 38) +
      symbol('R_eq = R₁ + R₂', 512, 692, ink, 42)
  );
}

function parallelCircuitSvg() {
  const branches = [220, 370, 520]
    .map(
      (y, index) =>
        '<path d="M224 ' +
        y +
        ' H326 M548 ' +
        y +
        ' H800" fill="none" stroke="' +
        ink +
        '" stroke-width="8" stroke-linecap="round"/>' +
        resistor(326, y, 222) +
        symbol('R' + (index + 1), 437, y - 38, gold, 32) +
        symbol('i' + (index + 1), 714, y - 24, red, 28)
    )
    .join('');
  return svgDocument(
    '<path d="M224 170 V570 M800 170 V570 M224 620 H446 M578 620 H800" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      branches +
      '<path d="M446 570 V670 M578 586 V654" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M286 150 H736" stroke="' +
      red +
      '" stroke-width="7" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('+', 426, 700, red, 36) +
      symbol('−', 600, 700, blue, 36) +
      symbol('V', 512, 606, gold, 36) +
      symbol('I', 512, 126, red, 38) +
      symbol('1/R_eq = 1/R₁ + 1/R₂ + 1/R₃', 512, 748, ink, 30)
  );
}

function motorSvg(showCommutator) {
  const commutator = showCommutator
    ? '<path d="M448 590 A66 66 0 0 0 512 656 A66 66 0 0 0 576 590" fill="none" stroke="' +
      gold +
      '" stroke-width="24" stroke-linecap="round"/><path d="M512 590 V656" stroke="' +
      ink +
      '" stroke-width="10"/><rect x="384" y="604" width="52" height="24" rx="5" fill="' +
      ink +
      '"/><rect x="588" y="604" width="52" height="24" rx="5" fill="' +
      ink +
      '"/><path d="M410 634 H462 M562 634 H614" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/>'
    : '<circle cx="512" cy="622" r="56" fill="none" stroke="' +
      gold +
      '" stroke-width="18"/><path d="M458 622 H566" stroke="' +
      ink +
      '" stroke-width="10"/>';
  return svgDocument(
    '<rect x="92" y="166" width="208" height="368" rx="22" fill="' +
      red +
      '" opacity="0.9"/><rect x="724" y="166" width="208" height="368" rx="22" fill="' +
      blue +
      '" opacity="0.9"/>' +
      '<path d="M330 274 H684 M330 384 H684 M330 494 H684" stroke="' +
      ink +
      '" stroke-width="7" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      '<circle cx="512" cy="384" r="156" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/><path d="M416 288 L608 322 L608 480 L416 446 Z" fill="none" stroke="' +
      gold +
      '" stroke-width="15" stroke-linejoin="round"/><path d="M416 288 V446 M608 322 V480" stroke="' +
      red +
      '" stroke-width="12" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      '<path d="M642 510 A178 178 0 0 1 426 540" fill="none" stroke="' +
      gold +
      '" stroke-width="11" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      '<path d="M382 352 H430 M594 416 H642" stroke="' +
      red +
      '" stroke-width="10" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('N', 196, 370, ink, 54, 700) +
      symbol('S', 828, 370, ink, 54, 700) +
      symbol('B', 512, 244, ink, 38) +
      symbol('I', 454, 360, red, 34) +
      symbol('F', 370, 338, red, 34) +
      symbol('F', 654, 442, red, 34) +
      symbol('τ', 548, 554, gold, 42) +
      commutator
  );
}

function rightTriangleSvg() {
  return svgDocument(
    '<path d="M228 590 H794 L228 178 Z" fill="none" stroke="' +
      ink +
      '" stroke-width="11" stroke-linecap="round" stroke-linejoin="round"/>' +
      '<path d="M228 538 H280 V590" fill="none" stroke="' +
      gold +
      '" stroke-width="8"/>' +
      '<path d="M684 590 A110 110 0 0 0 707 536" fill="none" stroke="' +
      gold +
      '" stroke-width="7"/>' +
      symbol('a', 176, 388, red, 40) +
      symbol('b', 510, 650, blue, 40) +
      symbol('c', 542, 336, gold, 42) +
      symbol('θ', 700, 558, gold, 42)
  );
}

function parabolaSvg() {
  return svgDocument(
    '<path d="M150 500 H880 M512 700 V100" fill="none" stroke="' +
      ink +
      '" stroke-width="8" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      '<path d="M270 140 Q512 860 754 140" fill="none" stroke="' +
      gold +
      '" stroke-width="12" stroke-linecap="round"/>' +
      '<path d="M220 650 H804" stroke="' +
      blue +
      '" stroke-width="6" stroke-dasharray="16 14"/>' +
      '<circle cx="512" cy="350" r="12" fill="' +
      red +
      '"/><circle cx="512" cy="500" r="12" fill="' +
      ink +
      '"/><path d="M512 500 V350" stroke="' +
      red +
      '" stroke-width="6" marker-start="url(#arrow)" marker-end="url(#arrow)"/>' +
      symbol('x', 902, 516, ink, 34) +
      symbol('y', 536, 116, ink, 34) +
      symbol('F', 546, 342, red, 34) +
      symbol('p', 550, 432, red, 34) +
      symbol('y = x²/(4p)', 512, 92, gold, 38)
  );
}

function pentagonalPrismSvg() {
  return svgDocument(
    '<path d="M266 236 L414 142 L592 216 L614 404 L450 490 L278 404 Z" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linejoin="round"/>' +
      '<path d="M438 330 L586 236 L764 310 L786 498 L622 584 L450 498 Z" fill="none" stroke="' +
      blue +
      '" stroke-width="10" stroke-linejoin="round"/>' +
      '<path d="M266 236 L438 330 M414 142 L586 236 M592 216 L764 310 M614 404 L786 498 M450 490 L622 584 M278 404 L450 498" fill="none" stroke="' +
      gold +
      '" stroke-width="8" stroke-linejoin="round"/>' +
      '<path d="M786 498 V632" stroke="' +
      red +
      '" stroke-width="7" marker-start="url(#arrow)" marker-end="url(#arrow)"/>' +
      symbol('B', 430, 338, gold, 42) +
      symbol('h', 824, 574, red, 42) +
      symbol('V = B·h', 512, 704, ink, 42)
  );
}

function pyramidSvg() {
  return svgDocument(
    '<path d="M512 126 L206 560 L818 560 Z M512 126 V560 M206 560 L512 676 L818 560" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>' +
      '<path d="M512 126 L512 560" stroke="' +
      red +
      '" stroke-width="7" stroke-dasharray="14 12" marker-end="url(#arrow)"/>' +
      '<path d="M512 560 H554 V518" fill="none" stroke="' +
      gold +
      '" stroke-width="7"/>' +
      symbol('h', 548, 354, red, 40) +
      symbol('B', 512, 642, gold, 42) +
      symbol('V = B·h/3', 512, 736, ink, 42)
  );
}

function capacitorResistorSymbolsSvg() {
  return svgDocument(
    '<path d="M108 360 H230 M430 360 H548" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/><rect x="230" y="310" width="200" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M590 360 H698 M742 360 H864 M698 260 V460 M742 260 V460" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      symbol('R', 330, 280, gold, 42) +
      symbol('Ω', 330, 500, gold, 42) +
      symbol('C', 720, 230, blue, 42) +
      symbol('F', 720, 530, blue, 42)
  );
}

function femSymbolSvg() {
  return svgDocument(
    '<path d="M148 384 H424 M600 384 H876 M424 218 V550 M600 278 V490" fill="none" stroke="' +
      ink +
      '" stroke-width="12" stroke-linecap="round"/>' +
      '<path d="M512 516 V248" fill="none" stroke="' +
      red +
      '" stroke-width="9" marker-end="url(#arrow)"/>' +
      symbol('−', 620, 526, blue, 48) +
      symbol('+', 620, 238, red, 48) +
      symbol('ℰ', 512, 648, gold, 64)
  );
}

function coilLoops(x, y, towardRight) {
  const control = towardRight ? x + 86 : x - 86;
  return Array.from({ length: 4 }, (_, index) => {
    const top = y + index * 74;
    const bottom = top + 74;
    return (
      '<path d="M' +
      x +
      ' ' +
      top +
      ' C' +
      control +
      ' ' +
      top +
      ' ' +
      control +
      ' ' +
      bottom +
      ' ' +
      x +
      ' ' +
      bottom +
      '" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>'
    );
  }).join('');
}

function femCircuitSvg() {
  return svgDocument(
    '<path d="M194 208 H394 M630 208 H812 V566 H194 V448 M194 322 V208" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round" stroke-linejoin="round"/>' +
      '<rect x="394" y="158" width="236" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M144 350 H244 M122 420 H266" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M286 152 H718" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('+', 98, 432, red, 42) +
      symbol('−', 98, 360, blue, 42) +
      symbol('ℰ', 146, 296, gold, 44) +
      symbol('R', 512, 142, gold, 42) +
      symbol('I', 512, 128, red, 40)
  );
}

function idealRealFemSvg() {
  return svgDocument(
    '<path d="M94 224 H250 M94 500 H250 M250 224 V500 M448 224 H566 M742 224 H930 M448 500 H566 M742 500 H930 M566 224 V500" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<path d="M172 286 V438 M220 318 V406" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M614 224 H672 M672 224 H696 M696 224 H742" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/><rect x="614" y="174" width="82" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/>' +
      '<path d="M488 286 V438 M536 318 V406" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      symbol('ℰ', 196, 584, gold, 52) +
      symbol('V = ℰ', 196, 660, ink, 40) +
      symbol('r', 654, 152, gold, 34) +
      symbol('ℰ', 512, 584, gold, 52) +
      symbol('V = ℰ − Ir', 700, 660, ink, 40)
  );
}

function resistorSymbolsSvg() {
  return svgDocument(
    '<path d="M92 276 H238 M438 276 H560" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/><rect x="238" y="226" width="200" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      '<path d="M92 492 H218" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      resistor(218, 492, 310) +
      '<path d="M528 492 H674" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M752 342 V440" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/><path d="M704 390 H800" stroke="' +
      blue +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('R', 338, 190, gold, 42) +
      symbol('R', 374, 454, gold, 42) +
      symbol('i', 770, 330, red, 36) +
      symbol('v', 692, 430, blue, 36) +
      symbol('p = vi', 752, 570, ink, 40)
  );
}

function capacitorSymbolsSvg() {
  return svgDocument(
    '<path d="M70 270 H190 M310 270 H420 M190 174 V366 M310 174 V366" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M510 270 H624 M744 270 H870 M624 174 V366 M744 174 A92 96 0 0 0 744 366" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M70 526 H190 M310 526 H420 M190 430 V622 M310 430 V622 M160 594 L340 458" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round" marker-end="url(#arrow)"/>' +
      symbol('C', 250, 144, gold, 38) +
      symbol('+', 608, 144, red, 42) +
      symbol('C', 694, 144, gold, 38) +
      symbol('C', 250, 678, gold, 38)
  );
}

function movingChargeBiotSavartSvg() {
  return svgDocument(
    '<circle cx="310" cy="462" r="48" fill="' +
      red +
      '"/><path d="M366 462 H566" stroke="' +
      red +
      '" stroke-width="10" marker-end="url(#arrow)"/><path d="M348 426 L718 224" stroke="' +
      gold +
      '" stroke-width="8" stroke-dasharray="14 12" marker-end="url(#arrow)"/>' +
      '<circle cx="720" cy="222" r="24" fill="none" stroke="' +
      blue +
      '" stroke-width="8"/><circle cx="720" cy="222" r="7" fill="' +
      blue +
      '"/>' +
      '<path d="M288 402 A78 78 0 0 1 380 354" fill="none" stroke="' +
      ink +
      '" stroke-width="7" marker-end="url(#arrow)"/>' +
      symbol('+q', 310, 474, ink, 30) +
      symbol('v', 470, 446, red, 38) +
      symbol('r', 538, 328, gold, 38) +
      symbol('P', 758, 212, gold, 34) +
      symbol('B', 764, 250, blue, 38) +
      symbol('B = μ₀q(v×r)/(4πr³)', 512, 692, ink, 38)
  );
}

function circuitNomenclatureSourcesSvg() {
  const coil = Array.from({ length: 4 }, (_, index) => {
    const x = 448 + index * 34;
    return (
      '<path d="M' +
      x +
      ' 478 a17 32 0 0 1 34 0" fill="none" stroke="' +
      ink +
      '" stroke-width="8"/>'
    );
  }).join('');
  return svgDocument(
    '<circle cx="202" cy="248" r="76" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/><path d="M202 186 V310 M164 248 H240" stroke="' +
      red +
      '" stroke-width="8"/>' +
      '<path d="M384 248 H492 M492 248 L560 206" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/><circle cx="384" cy="248" r="10" fill="' +
      gold +
      '"/>' +
      '<path d="M396 478 H448 M584 478 H676" fill="none" stroke="' +
      ink +
      '" stroke-width="10" stroke-linecap="round"/>' +
      coil +
      '<path d="M764 170 H826 M764 506 H826" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/><path d="M826 170 C892 170 892 254 826 254 C892 254 892 338 826 338 C892 338 892 422 826 422 C892 422 892 506 826 506" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/><path d="M720 170 H658 M720 506 H658" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/><path d="M720 170 C654 170 654 254 720 254 C654 254 654 338 720 338 C654 338 654 422 720 422 C654 422 654 506 720 506" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/><path d="M742 150 V526 M804 150 V526" stroke="' +
      blue +
      '" stroke-width="8"/>' +
      symbol('ℰ', 202, 354, gold, 42) +
      symbol('S', 472, 180, gold, 38) +
      symbol('L', 538, 442, gold, 38) +
      symbol('V₁', 626, 144, red, 34) +
      symbol('V₂', 900, 144, blue, 34)
  );
}

function displacementFieldSvg() {
  const dipoles = [284, 408, 532, 656, 780]
    .map(
      (x) =>
        '<circle cx="' +
        x +
        '" cy="328" r="20" fill="' +
        blue +
        '"/><circle cx="' +
        x +
        '" cy="440" r="20" fill="' +
        red +
        '"/>'
    )
    .join('');
  return svgDocument(
    '<rect x="182" y="148" width="660" height="42" rx="8" fill="' +
      ink +
      '"/><rect x="182" y="578" width="660" height="42" rx="8" fill="' +
      ink +
      '"/><rect x="242" y="216" width="540" height="336" rx="12" fill="none" stroke="' +
      gold +
      '" stroke-width="8"/>' +
      dipoles +
      '<path d="M362 230 V522 M512 230 V522 M662 230 V522" stroke="' +
      blue +
      '" stroke-width="8" marker-end="url(#arrow)"/><path d="M422 230 V522" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('+Q', 132, 186, red, 36) +
      symbol('−Q', 884, 616, blue, 36) +
      symbol('D', 350, 282, blue, 34) +
      symbol('E', 500, 282, red, 34) +
      symbol('P', 650, 282, blue, 34) +
      symbol('A', 804, 382, gold, 36) +
      symbol('d', 512, 700, gold, 36)
  );
}

function linearCapacitanceGraphSvg() {
  return svgDocument(
    '<path d="M150 604 H884 M226 674 V128" fill="none" stroke="' +
      ink +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M226 604 L754 184" fill="none" stroke="' +
      gold +
      '" stroke-width="11" stroke-linecap="round"/>' +
      '<path d="M566 604 V334 M226 334 H566" stroke="' +
      blue +
      '" stroke-width="5" stroke-dasharray="12 12"/>' +
      '<circle cx="566" cy="334" r="12" fill="' +
      red +
      '"/>' +
      symbol('V', 902, 622, ink, 38) +
      symbol('Q', 194, 146, ink, 38) +
      symbol('Q = CV', 624, 260, gold, 40) +
      symbol('C = ΔQ/ΔV', 512, 710, ink, 42)
  );
}

function solenoidFormulaSvg() {
  const turns = Array.from({ length: 9 }, (_, index) => {
    const x = 222 + index * 64;
    return (
      '<ellipse cx="' +
      x +
      '" cy="366" rx="38" ry="156" fill="none" stroke="' +
      ink +
      '" stroke-width="8"/>'
    );
  }).join('');
  return svgDocument(
    turns +
      '<path d="M182 366 H816" stroke="' +
      blue +
      '" stroke-width="8" marker-end="url(#arrow)"/><path d="M222 572 H790" stroke="' +
      gold +
      '" stroke-width="6" marker-start="url(#arrow)" marker-end="url(#arrow)"/><ellipse cx="796" cy="366" rx="38" ry="156" fill="none" stroke="' +
      red +
      '" stroke-width="7" stroke-dasharray="12 10"/>' +
      symbol('B', 512, 334, blue, 38) +
      symbol('l', 512, 630, gold, 38) +
      symbol('A', 852, 376, red, 38) +
      symbol('N', 196, 176, gold, 38) +
      symbol('L = μ₀N²A/l', 512, 710, ink, 44)
  );
}

function capacitorCurrentGraphSvg(discharge) {
  const curve = discharge
    ? '<path d="M256 602 C340 576 486 538 794 526" fill="none" stroke="' +
      blue +
      '" stroke-width="11" stroke-linecap="round"/>'
    : '<path d="M256 266 C340 314 486 412 794 492" fill="none" stroke="' +
      red +
      '" stroke-width="11" stroke-linecap="round"/>';
  const formula = discharge ? 'i_C(t) = −V₀e^(−t/RC)/R' : 'i_C(t) = ℰe^(−t/RC)/R';
  return svgDocument(
    '<path d="M178 522 H876 M228 674 V126" fill="none" stroke="' +
      ink +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M248 522 H794" stroke="' +
      gold +
      '" stroke-width="4" stroke-dasharray="12 12"/>' +
      curve +
      symbol('t', 898, 538, ink, 36) +
      symbol('i_C', 196, 146, ink, 36) +
      symbol(formula, 512, 714, ink, 36)
  );
}

function capacitorVoltageGraphSvg(discharge) {
  const curve = discharge
    ? '<path d="M256 228 C372 292 540 436 794 506" fill="none" stroke="' +
      blue +
      '" stroke-width="11" stroke-linecap="round"/>'
    : '<path d="M256 510 C348 384 476 276 794 226" fill="none" stroke="' +
      red +
      '" stroke-width="11" stroke-linecap="round"/>';
  const formula = discharge ? 'V_C(t) = V₀e^(−t/RC)' : 'V_C(t) = ℰ(1 − e^(−t/RC))';
  const marker = discharge ? 'V₀' : 'ℰ';
  return svgDocument(
    '<path d="M178 532 H876 M228 674 V126" fill="none" stroke="' +
      ink +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M248 226 H794" stroke="' +
      gold +
      '" stroke-width="4" stroke-dasharray="12 12"/>' +
      curve +
      symbol('t', 898, 548, ink, 36) +
      symbol('V_C', 188, 146, ink, 36) +
      symbol(marker, 206, 238, gold, 34) +
      symbol(formula, 512, 714, ink, 36)
  );
}

function capacitorEnergySvg() {
  return svgDocument(
    '<rect x="304" y="168" width="34" height="366" rx="6" fill="' +
      ink +
      '"/><rect x="680" y="168" width="34" height="366" rx="6" fill="' +
      ink +
      '"/><path d="M356 264 H658 M356 350 H658 M356 436 H658" stroke="' +
      blue +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M338 588 H680" stroke="' +
      gold +
      '" stroke-width="7" marker-start="url(#arrow)" marker-end="url(#arrow)"/>' +
      symbol('+Q', 278, 132, red, 36) +
      symbol('−Q', 738, 132, blue, 36) +
      symbol('E', 512, 236, blue, 38) +
      symbol('V_C', 512, 652, gold, 38) +
      symbol('U = Q²/(2C) = CV_C²/2 = QV_C/2', 512, 724, ink, 34)
  );
}

function femInternalResistanceSvg() {
  return svgDocument(
    '<rect x="132" y="158" width="392" height="426" rx="20" fill="none" stroke="' +
      blue +
      '" stroke-width="7" stroke-dasharray="16 14"/>' +
      '<path d="M184 252 H274 M430 252 H522 V524 H184 V422 M184 328 V252" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<path d="M138 354 H230 M116 418 H252" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<rect x="274" y="202" width="156" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/>' +
      '<path d="M522 252 H672 M846 252 H904 V524 H522" fill="none" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>' +
      '<rect x="672" y="202" width="174" height="100" rx="8" fill="none" stroke="' +
      ink +
      '" stroke-width="9"/>' +
      '<path d="M236 194 H820" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('+', 94, 430, red, 38) +
      symbol('−', 94, 364, blue, 38) +
      symbol('ℰ', 146, 314, gold, 40) +
      symbol('r', 352, 184, gold, 36) +
      symbol('R', 758, 184, gold, 36) +
      symbol('I', 512, 176, red, 36) +
      symbol('A', 534, 234, gold, 32) +
      symbol('B', 534, 544, gold, 32) +
      symbol('V_AB = ℰ − Ir', 512, 688, ink, 42)
  );
}

function lorentzSvg() {
  const fieldDots = [
    [278, 214],
    [374, 214],
    [278, 310],
    [374, 310],
    [650, 214],
    [746, 214],
    [650, 310],
    [746, 310],
  ]
    .map(
      ([x, y]) =>
        '<circle cx="' +
        x +
        '" cy="' +
        y +
        '" r="14" fill="none" stroke="' +
        blue +
        '" stroke-width="6"/><circle cx="' +
        x +
        '" cy="' +
        y +
        '" r="4" fill="' +
        blue +
        '"/>'
    )
    .join('');
  return svgDocument(
    '<path d="M512 90 V678" stroke="' +
      ink +
      '" stroke-width="5"/>' +
      fieldDots +
      '<circle cx="326" cy="382" r="38" fill="' +
      red +
      '"/><path d="M370 382 H478" stroke="' +
      red +
      '" stroke-width="9" marker-end="url(#arrow)"/><path d="M326 426 V552" stroke="' +
      gold +
      '" stroke-width="9" marker-end="url(#arrow)"/>' +
      '<path d="M616 382 H818" stroke="' +
      ink +
      '" stroke-width="18" stroke-linecap="round"/><path d="M680 344 V420 M742 344 V420" stroke="' +
      red +
      '" stroke-width="9" marker-end="url(#arrow)"/><path d="M716 426 V552" stroke="' +
      gold +
      '" stroke-width="9" marker-end="url(#arrow)"/>' +
      symbol('+q', 326, 394, ink, 28) +
      symbol('v', 432, 368, red, 34) +
      symbol('F', 350, 584, gold, 34) +
      symbol('I', 712, 330, red, 34) +
      symbol('F', 738, 584, gold, 34) +
      symbol('B', 512, 170, blue, 34) +
      symbol('F = qv×B', 276, 688, ink, 38) +
      symbol('F = Iℓ×B', 748, 688, ink, 38)
  );
}

function lenzSvg(approaching) {
  const velocity = approaching
    ? '<path d="M194 252 H356" stroke="' + red + '" stroke-width="9" marker-end="url(#arrow)"/>'
    : '<path d="M356 252 H194" stroke="' + red + '" stroke-width="9" marker-end="url(#arrow)"/>';
  const induced = approaching
    ? '<path d="M796 384 H514" stroke="' + blue + '" stroke-width="9" marker-end="url(#arrow)"/>'
    : '<path d="M514 384 H796" stroke="' + blue + '" stroke-width="9" marker-end="url(#arrow)"/>';
  const rate = approaching ? 'dΦ/dt > 0' : 'dΦ/dt < 0';
  return svgDocument(
    '<rect x="124" y="292" width="168" height="184" rx="18" fill="' +
      red +
      '"/><rect x="292" y="292" width="86" height="184" rx="18" fill="' +
      blue +
      '"/><ellipse cx="690" cy="384" rx="108" ry="184" fill="none" stroke="' +
      ink +
      '" stroke-width="13"/><ellipse cx="690" cy="384" rx="72" ry="148" fill="none" stroke="' +
      gold +
      '" stroke-width="8"/>' +
      velocity +
      '<path d="M392 350 H572" stroke="' +
      gold +
      '" stroke-width="7" marker-end="url(#arrow)"/>' +
      induced +
      '<path d="M774 330 A92 92 0 0 1 774 438" fill="none" stroke="' +
      red +
      '" stroke-width="7" marker-end="url(#arrow)"/>' +
      symbol('N', 336, 396, ink, 46, 700) +
      symbol('S', 206, 396, ink, 46, 700) +
      symbol('v', 274, 230, red, 38) +
      symbol('Φ', 468, 334, gold, 36) +
      symbol('ε = −dΦ/dt', 512, 668, ink, 40) +
      symbol(rate, 512, 722, blue, 34)
  );
}

function dielectricDipolesSvg(polarized) {
  const dipoles = [
    [342, 274, polarized ? 0 : -36],
    [500, 274, polarized ? 0 : 42],
    [658, 274, polarized ? 0 : -58],
    [342, 460, polarized ? 0 : 48],
    [500, 460, polarized ? 0 : -44],
    [658, 460, polarized ? 0 : 30],
  ]
    .map(([x, y, rotation]) => {
      const transform = 'rotate(' + rotation + ' ' + x + ' ' + y + ')';
      return (
        '<g transform="' +
        transform +
        '"><circle cx="' +
        (x - 28) +
        '" cy="' +
        y +
        '" r="24" fill="' +
        blue +
        '"/><circle cx="' +
        (x + 28) +
        '" cy="' +
        y +
        '" r="24" fill="' +
        red +
        '"/></g>'
      );
    })
    .join('');
  const field = polarized
    ? '<path d="M170 210 H854 M170 580 H854" stroke="' +
      gold +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('E', 152, 198, gold, 38) +
      symbol('P', 512, 652, gold, 38)
    : '';
  return svgDocument(
    '<rect x="228" y="176" width="568" height="464" rx="18" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      dipoles +
      field
  );
}

function polarizationSvg() {
  const dipoles = [
    [374, 298],
    [512, 298],
    [650, 298],
    [374, 458],
    [512, 458],
    [650, 458],
  ]
    .map(
      ([x, y]) =>
        '<circle cx="' +
        (x - 26) +
        '" cy="' +
        y +
        '" r="22" fill="' +
        blue +
        '"/><circle cx="' +
        (x + 26) +
        '" cy="' +
        y +
        '" r="22" fill="' +
        red +
        '"/>'
    )
    .join('');
  return svgDocument(
    '<rect x="256" y="184" width="512" height="440" rx="18" fill="none" stroke="' +
      ink +
      '" stroke-width="10"/>' +
      dipoles +
      '<path d="M106 248 H882 M106 560 H882" stroke="' +
      gold +
      '" stroke-width="8" marker-end="url(#arrow)"/><path d="M704 378 H348" stroke="' +
      blue +
      '" stroke-width="8" marker-end="url(#arrow)"/><path d="M348 378 H704" stroke="' +
      red +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M270 236 V572 M754 236 V572" stroke="' +
      ink +
      '" stroke-width="5"/>' +
      symbol('−', 276, 408, blue, 52) +
      symbol('+', 748, 408, red, 52) +
      symbol('E₀', 116, 230, gold, 36) +
      symbol('E_p', 512, 356, blue, 36) +
      symbol('P', 512, 614, red, 36) +
      symbol('E = E₀ + E_p', 512, 708, ink, 40)
  );
}

function windingPolaritySvg(mode) {
  const parallel = mode.startsWith('parallel');
  const additive = mode.endsWith('additive');
  const leftDotY = 210;
  const rightDotY = additive ? 210 : 506;
  const formula = parallel
    ? additive
      ? 'L_AB = (L₁L₂ − M²)/(L₁ + L₂ − 2M)'
      : 'L_AB = (L₁L₂ − M²)/(L₁ + L₂ + 2M)'
    : 'L_AB = L₁ + L₂ − 2M';
  const rails = parallel
    ? '<path d="M130 170 H894 M130 546 H894" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>'
    : '<path d="M130 210 H326 M326 506 H698 M698 210 H894" stroke="' +
      ink +
      '" stroke-width="9" stroke-linecap="round"/>';
  return svgDocument(
    rails +
      coilLoops(326, 210, true) +
      coilLoops(698, 210, false) +
      '<path d="M472 174 V546 M552 174 V546" stroke="' +
      blue +
      '" stroke-width="10"/>' +
      '<circle cx="326" cy="' +
      leftDotY +
      '" r="12" fill="' +
      gold +
      '"/><circle cx="698" cy="' +
      rightDotY +
      '" r="12" fill="' +
      gold +
      '"/>' +
      '<path d="M214 220 H302 M810 220 H722" stroke="' +
      red +
      '" stroke-width="7" marker-end="url(#arrow)"/>' +
      '<path d="M420 384 H604" stroke="' +
      (additive ? red : blue) +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      symbol('L₁', 286, 600, gold, 36) +
      symbol('L₂', 738, 600, gold, 36) +
      symbol(parallel ? 'i₁' : 'i', 222, 192, red, 30) +
      symbol(parallel ? 'i₂' : 'Φ', 804, 192, red, 30) +
      symbol('M', 512, 158, blue, 36) +
      symbol(formula, 512, 702, ink, 32)
  );
}

function chargeCarriersSvg() {
  const electrons = [
    [320, 310],
    [440, 398],
    [560, 286],
    [680, 448],
    [746, 346],
  ]
    .map(
      ([x, y]) =>
        '<circle cx="' +
        x +
        '" cy="' +
        y +
        '" r="24" fill="' +
        blue +
        '"/>' +
        symbol('−', x, y + 12, ink, 28)
    )
    .join('');
  return svgDocument(
    '<rect x="152" y="202" width="720" height="338" rx="168" fill="none" stroke="' +
      ink +
      '" stroke-width="12"/>' +
      electrons +
      '<path d="M180 134 H842" stroke="' +
      gold +
      '" stroke-width="9" marker-end="url(#arrow)"/><path d="M182 614 H840" stroke="' +
      red +
      '" stroke-width="9" marker-end="url(#arrow)"/><path d="M700 494 H376" stroke="' +
      blue +
      '" stroke-width="7" marker-end="url(#arrow)"/>' +
      symbol('E', 164, 120, gold, 38) +
      symbol('I', 854, 628, red, 38) +
      symbol('v_d', 540, 482, blue, 36) +
      symbol('I = n|q|Av_d', 512, 704, ink, 42)
  );
}

function resistorCharacteristicSvg() {
  return svgDocument(
    '<path d="M150 604 H884 M226 674 V128" fill="none" stroke="' +
      ink +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M226 604 L686 222" fill="none" stroke="' +
      gold +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M226 604 C450 588 646 462 788 174" fill="none" stroke="' +
      red +
      '" stroke-width="10" stroke-linecap="round"/>' +
      symbol('V', 902, 622, ink, 38) +
      symbol('I', 194, 146, ink, 38) +
      symbol('I = V/R', 496, 252, gold, 36) +
      symbol('dI/dV ≠ k', 680, 500, red, 34)
  );
}

function currentWaveformsSvg() {
  const sinePoints = Array.from({ length: 81 }, (_, index) => {
    const x = 570 + index * 3.6;
    const y = 380 - Math.sin((index / 80) * Math.PI * 4) * 120;
    return (index === 0 ? 'M' : 'L') + x.toFixed(1) + ' ' + y.toFixed(1);
  }).join(' ');
  return svgDocument(
    '<path d="M90 526 H452 M152 648 V148 M570 526 H934 M632 648 V148" fill="none" stroke="' +
      ink +
      '" stroke-width="8" marker-end="url(#arrow)"/>' +
      '<path d="M170 300 H420" stroke="' +
      red +
      '" stroke-width="10" stroke-linecap="round"/><path d="' +
      sinePoints +
      '" fill="none" stroke="' +
      blue +
      '" stroke-width="10" stroke-linecap="round"/>' +
      '<path d="M704 560 H848" stroke="' +
      gold +
      '" stroke-width="6" marker-start="url(#arrow)" marker-end="url(#arrow)"/><path d="M806 380 V260" stroke="' +
      gold +
      '" stroke-width="6" marker-start="url(#arrow)" marker-end="url(#arrow)"/>' +
      symbol('i', 122, 170, ink, 34) +
      symbol('t', 464, 542, ink, 34) +
      symbol('i', 602, 170, ink, 34) +
      symbol('t', 946, 542, ink, 34) +
      symbol('i(t) = I₀', 270, 706, ink, 38) +
      symbol('i(t) = Î sin(2πt/T)', 752, 706, ink, 38) +
      symbol('T', 776, 594, gold, 32) +
      symbol('Î', 826, 252, gold, 32)
  );
}

function truthTableSvg(headers, rows) {
  const columns = headers.length;
  const rowCount = rows.length + 1;
  const tableWidth = columns === 2 ? 560 : 760;
  const tableHeight = rowCount === 3 ? 420 : 560;
  const left = (1024 - tableWidth) / 2;
  const top = (768 - tableHeight) / 2;
  const columnWidth = tableWidth / columns;
  const rowHeight = tableHeight / rowCount;
  const verticals = Array.from({ length: columns + 1 }, (_, index) => {
    const x = left + index * columnWidth;
    return (
      '<path d="M' +
      x +
      ' ' +
      top +
      ' V' +
      (top + tableHeight) +
      '" stroke="' +
      ink +
      '" stroke-width="8"/>'
    );
  }).join('');
  const horizontals = Array.from({ length: rowCount + 1 }, (_, index) => {
    const y = top + index * rowHeight;
    return (
      '<path d="M' +
      left +
      ' ' +
      y +
      ' H' +
      (left + tableWidth) +
      '" stroke="' +
      ink +
      '" stroke-width="8"/>'
    );
  }).join('');
  const headerText = headers
    .map((header, column) => {
      const x = left + columnWidth * (column + 0.5);
      return (
        '<text x="' +
        x +
        '" y="' +
        (top + rowHeight * 0.66) +
        '" text-anchor="middle" fill="' +
        gold +
        '" font-family="Arial, Helvetica, sans-serif" font-size="58" font-weight="700">' +
        header +
        '</text>'
      );
    })
    .join('');
  const bodyText = rows
    .flatMap((row, rowIndex) =>
      row.map((value, column) => {
        const x = left + columnWidth * (column + 0.5);
        const y = top + rowHeight * (rowIndex + 1.66);
        return (
          '<text x="' +
          x +
          '" y="' +
          y +
          '" text-anchor="middle" fill="' +
          ink +
          '" font-family="Arial, Helvetica, sans-serif" font-size="64" font-weight="700">' +
          value +
          '</text>'
        );
      })
    )
    .join('');
  return svgDocument(
    '<rect x="' +
      left +
      '" y="' +
      top +
      '" width="' +
      tableWidth +
      '" height="' +
      tableHeight +
      '" rx="20" fill="none" stroke="' +
      blue +
      '" stroke-width="12"/>' +
      verticals +
      horizontals +
      headerText +
      bodyText
  );
}

function trigTableSvg() {
  const columns = ['θ', '0°', '30°', '45°', '60°', '90°'];
  const rows = [
    ['sin θ', '0', '1/2', '√2/2', '√3/2', '1'],
    ['cos θ', '1', '√3/2', '√2/2', '1/2', '0'],
    ['tan θ', '0', '1/√3', '1', '√3', '−'],
    ['cot θ', '−', '√3', '1', '1/√3', '0'],
    ['sec θ', '1', '2/√3', '√2', '2', '−'],
    ['csc θ', '−', '2', '√2', '2/√3', '1'],
  ];
  const left = 92;
  const top = 112;
  const width = 840;
  const height = 544;
  const columnWidth = width / columns.length;
  const rowHeight = height / (rows.length + 1);
  const verticals = Array.from({ length: columns.length + 1 }, (_, index) => {
    const x = left + index * columnWidth;
    return (
      '<path d="M' +
      x +
      ' ' +
      top +
      ' V' +
      (top + height) +
      '" stroke="' +
      blue +
      '" stroke-width="4"/>'
    );
  }).join('');
  const horizontals = Array.from({ length: rows.length + 2 }, (_, index) => {
    const y = top + index * rowHeight;
    return (
      '<path d="M' +
      left +
      ' ' +
      y +
      ' H' +
      (left + width) +
      '" stroke="' +
      blue +
      '" stroke-width="4"/>'
    );
  }).join('');
  const headerText = columns
    .map((value, index) => {
      const x = left + columnWidth * (index + 0.5);
      return (
        '<text x="' +
        x +
        '" y="' +
        (top + rowHeight * 0.68) +
        '" text-anchor="middle" fill="' +
        gold +
        '" font-family="Arial, Helvetica, sans-serif" font-size="30" font-weight="700">' +
        value +
        '</text>'
      );
    })
    .join('');
  const bodyText = rows
    .flatMap((row, rowIndex) =>
      row.map((value, columnIndex) => {
        const x = left + columnWidth * (columnIndex + 0.5);
        const y = top + rowHeight * (rowIndex + 1.68);
        return (
          '<text x="' +
          x +
          '" y="' +
          y +
          '" text-anchor="middle" fill="' +
          ink +
          '" font-family="Arial, Helvetica, sans-serif" font-size="27" font-weight="600">' +
          value +
          '</text>'
        );
      })
    )
    .join('');
  return svgDocument(
    '<rect x="' +
      left +
      '" y="' +
      top +
      '" width="' +
      width +
      '" height="' +
      height +
      '" rx="20" fill="none" stroke="' +
      blue +
      '" stroke-width="8"/>' +
      verticals +
      horizontals +
      headerText +
      bodyText
  );
}

const generatedVisuals = new Map([
  ['agregar_tarea.png', () => mathInputSvg('+', gold)],
  [
    'formulas_favoritas.png',
    () =>
      svgDocument(
        '<path d="M512 166 L578 314 L740 330 L618 436 L654 596 L512 516 L370 596 L406 436 L284 330 L446 314 Z" fill="' +
          gold +
          '" stroke="' +
          ink +
          '" stroke-width="12" stroke-linejoin="round"/>'
      ),
  ],
  [
    'carrito_comprar.png',
    () =>
      svgDocument(
        '<path d="M224 214 H306 L374 508 H700 L764 306 H342" fill="none" stroke="' +
          ink +
          '" stroke-width="20" stroke-linecap="round" stroke-linejoin="round"/><path d="M390 398 H726" fill="none" stroke="' +
          gold +
          '" stroke-width="14"/><circle cx="438" cy="594" r="34" fill="' +
          blue +
          '"/><circle cx="654" cy="594" r="34" fill="' +
          blue +
          '"/>'
      ),
  ],
  ['electricidad_y_magnetismo/capacitor_1.png', () => capacitorSvg(false)],
  ['electricidad_y_magnetismo/capacitor_2.png', () => capacitorSvg(true)],
  [
    'electricidad_y_magnetismo/corriente_en_el_capacitor.png',
    () => capacitorCurrentGraphSvg(false),
  ],
  [
    'electricidad_y_magnetismo/corriente_en_el_capacitor_1.png',
    () => capacitorCurrentGraphSvg(true),
  ],
  [
    'electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor.png',
    () => capacitorVoltageGraphSvg(false),
  ],
  [
    'electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor_1.png',
    () => capacitorVoltageGraphSvg(true),
  ],
  ['electricidad_y_magnetismo/energia_y_capacitancia.png', capacitorEnergySvg],
  ['electricidad_y_magnetismo/elementos_capacitor_y_resistor.png', capacitorResistorSymbolsSvg],
  ['electricidad_y_magnetismo/elementos_fem.png', femSymbolSvg],
  ['electricidad_y_magnetismo/fem_ideal_y_real.png', idealRealFemSvg],
  ['electricidad_y_magnetismo/fem_aspectos_relevantes.png', femInternalResistanceSvg],
  ['electricidad_y_magnetismo/fuente_de_fuerza_electromotriz_fem.png', femCircuitSvg],
  ['electricidad_y_magnetismo/fuerza_de_lorentz.png', lorentzSvg],
  ['electricidad_y_magnetismo/grafica_capacitancia.png', linearCapacitanceGraphSvg],
  ['electricidad_y_magnetismo/inductancia_propia_de_un_solenoide.png', solenoidFormulaSvg],
  ['electricidad_y_magnetismo/ley_de_biot_savart_1.png', movingChargeBiotSavartSvg],
  ['electricidad_y_magnetismo/ley_de_lenz_1.png', () => lenzSvg(true)],
  ['electricidad_y_magnetismo/ley_de_lenz_2.png', () => lenzSvg(false)],
  ['electricidad_y_magnetismo/nomenclatura_basica_1.png', capacitorResistorSymbolsSvg],
  ['electricidad_y_magnetismo/nomenclatura_basica_2.png', circuitNomenclatureSourcesSvg],
  ['electricidad_y_magnetismo/no_polarizado.png', () => dielectricDipolesSvg(false)],
  ['electricidad_y_magnetismo/polarizado.png', () => dielectricDipolesSvg(true)],
  ['electricidad_y_magnetismo/polarizacion.png', polarizationSvg],
  [
    'electricidad_y_magnetismo/polaridad_devanado_2.png',
    () => windingPolaritySvg('series-opposing'),
  ],
  [
    'electricidad_y_magnetismo/polaridad_devanado_paralelo_1.png',
    () => windingPolaritySvg('parallel-additive'),
  ],
  [
    'electricidad_y_magnetismo/polaridad_devanado_paralelo_2.png',
    () => windingPolaritySvg('parallel-opposing'),
  ],
  ['electricidad_y_magnetismo/portadores_de_carga_libre.png', chargeCarriersSvg],
  ['electricidad_y_magnetismo/representacion_de_los_vectores_electricos.png', displacementFieldSvg],
  ['electricidad_y_magnetismo/resistor_lineal_y_no_lineal.png', resistorCharacteristicSvg],
  ['electricidad_y_magnetismo/resistor_simbologia_basica.png', resistorSymbolsSvg],
  ['electricidad_y_magnetismo/simbologia_capacitores.png', capacitorSymbolsSvg],
  ['electricidad_y_magnetismo/tipos_de_corriente_electrica.png', currentWaveformsSvg],
  ['electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo.png', rcCircuitSvg],
  ['electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_1.png', rcChargeSvg],
  ['electricidad_y_magnetismo/conexion_en_paralelo_resistor.png', parallelCircuitSvg],
  ['electricidad_y_magnetismo/conexion_en_serie_resistor.png', seriesCircuitSvg],
  ['electricidad_y_magnetismo/motor_de_corriente_directa.png', () => motorSvg(false)],
  ['electricidad_y_magnetismo/motor_de_corriente_directa_1.png', () => motorSvg(true)],
  ['geometria/parabola_con_vertice_en_el_origen.png', parabolaSvg],
  ['geometria/volumen_de_cuerpos_geometricos/piramide.png', pyramidSvg],
  ['geometria/volumen_de_cuerpos_geometricos/prisma_pentagonal.png', pentagonalPrismSvg],
  ['preguntas_frecuentes/entrada_negativa/entrada_con_negativo.png', () => mathInputSvg('−1')],
  ['preguntas_frecuentes/entrada_negativa/entrada_con_punto.png', () => mathInputSvg('1·5', blue)],
  ['preguntas_frecuentes/entrada_negativa/entrada_sin_nada.png', () => mathInputSvg('1', gold)],
  ['preguntas_frecuentes/formula_cortada/font_size.png', () => fontSizeSvg('normal')],
  ['preguntas_frecuentes/formula_cortada/font_size_cambiar.png', () => fontSizeSvg('large')],
  ['preguntas_frecuentes/formula_cortada/font_size_terminado.png', () => fontSizeSvg('small')],
  ['preguntas_frecuentes/formula_cortada/formula_cortada.png', cropSvg],
  ['preguntas_frecuentes/formula_cortada/menu_display.png', () => documentSvg('more')],
  ['preguntas_frecuentes/nan/raices.png', () => rootSvg(false)],
  ['preguntas_frecuentes/nan/resultado_nan.png', () => rootSvg(true)],
  ['preguntas_frecuentes/pdf/botones.png', () => documentSvg('eye')],
  ['preguntas_frecuentes/pdf/opciones_pdf.png', () => documentSvg('download')],
  ['preguntas_frecuentes/pdf/opcionespdf.jpg', () => documentSvg('download')],
  ['preguntas_frecuentes/pdf/tres_puntos.png', () => documentSvg('more')],
  ['preguntas_frecuentes/pdf/trespuntos.jpg', () => documentSvg('more')],
  ['preguntas_frecuentes/wifi/conexion_1.png', () => wifiSvg('connection')],
  ['preguntas_frecuentes/wifi/conexion_2.png', () => wifiSvg('toggle')],
  ['preguntas_frecuentes/wifi/conexion_3.png', () => wifiSvg('waiting')],
  ['preguntas_frecuentes/wifi/conexion_4.png', () => wifiSvg('play')],
  ['funciones_trigonometricas_angulos_notables.png', trigTableSvg],
  [
    'matematicas_discretas/bicondicional.png',
    () =>
      truthTableSvg(
        ['p', 'q', 'p ↔ q'],
        [
          ['0', '0', '1'],
          ['0', '1', '0'],
          ['1', '0', '0'],
          ['1', '1', '1'],
        ]
      ),
  ],
  [
    'matematicas_discretas/condicional.png',
    () =>
      truthTableSvg(
        ['p', 'q', 'p → q'],
        [
          ['0', '0', '1'],
          ['0', '1', '1'],
          ['1', '0', '0'],
          ['1', '1', '1'],
        ]
      ),
  ],
  [
    'matematicas_discretas/conjuncion.png',
    () =>
      truthTableSvg(
        ['p', 'q', 'p ∧ q'],
        [
          ['0', '0', '0'],
          ['0', '1', '0'],
          ['1', '0', '0'],
          ['1', '1', '1'],
        ]
      ),
  ],
  [
    'matematicas_discretas/negacion.png',
    () =>
      truthTableSvg(
        ['p', '¬p'],
        [
          ['0', '1'],
          ['1', '0'],
        ]
      ),
  ],
  [
    'matematicas_discretas/tabla_de_verdad_disyuncion_1.png',
    () =>
      truthTableSvg(
        ['p', 'q', 'p ∨ q'],
        [
          ['0', '0', '0'],
          ['0', '1', '1'],
          ['1', '0', '1'],
          ['1', '1', '1'],
        ]
      ),
  ],
  [
    'matematicas_discretas/tabla_de_verdad_disyuncion2.png',
    () =>
      truthTableSvg(
        ['p', 'q', 'p ⊕ q'],
        [
          ['0', '0', '0'],
          ['0', '1', '1'],
          ['1', '0', '1'],
          ['1', '1', '0'],
        ]
      ),
  ],
  ['triangulo_rectangulo.png', rightTriangleSvg],
]);

const manualMasks = new Map([
  [
    'electricidad_y_magnetismo/regla_de_la_mano_derecha.png',
    [{ left: 196, top: 218, right: 540, bottom: 346 }],
  ],
]);

function normalizedToken(value) {
  return value
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
}

function isNaturalLanguageWord(value) {
  if (!/^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+$/.test(value)) return false;
  const token = normalizedToken(value);
  return token.length >= 3 && !mathematicalTokens.has(token);
}

function parseTsv(tsv) {
  const lines = new Map();
  for (const row of tsv.trim().split(/\r?\n/).slice(1)) {
    const columns = row.split('\t');
    if (columns.length < 12 || columns[0] !== '5') continue;
    const confidence = Number(columns[10]);
    const text = columns.slice(11).join('\t').trim();
    if (confidence < 45 || !isNaturalLanguageWord(text)) continue;

    const left = Number(columns[6]);
    const top = Number(columns[7]);
    const width = Number(columns[8]);
    const height = Number(columns[9]);
    if (![left, top, width, height].every(Number.isFinite)) continue;

    const key = columns.slice(1, 5).join('/');
    const existing = lines.get(key);
    const box = { left, top, right: left + width, bottom: top + height };
    if (!existing) {
      lines.set(key, box);
      continue;
    }
    existing.left = Math.min(existing.left, box.left);
    existing.top = Math.min(existing.top, box.top);
    existing.right = Math.max(existing.right, box.right);
    existing.bottom = Math.max(existing.bottom, box.bottom);
  }
  return [...lines.values()];
}

function maskSvg(boxes) {
  const rectangles = boxes
    .map((box) => {
      const x = Math.max(0, box.left - 18);
      const y = Math.max(0, box.top - 14);
      const width = Math.min(1024 - x, box.right - box.left + 36);
      const height = Math.min(768 - y, box.bottom - box.top + 28);
      return (
        '<rect x="' +
        x +
        '" y="' +
        y +
        '" width="' +
        width +
        '" height="' +
        height +
        '" rx="8" fill="' +
        navy +
        '"/>'
      );
    })
    .join('');
  return Buffer.from(
    '<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="768">' + rectangles + '</svg>'
  );
}

async function writeImage(filePath, image) {
  const extension = path.extname(filePath).toLowerCase();
  const writer = sharp(image).flatten({ background: navy });
  if (extension === '.jpg') {
    await writer.jpeg({ quality: 94, mozjpeg: true }).toFile(filePath);
    return;
  }
  await writer.png({ compressionLevel: 9, palette: false }).toFile(filePath);
}

async function replaceWithGeneratedVisual(relativePath, filePath) {
  const generator = generatedVisuals.get(relativePath);
  if (!generator) return false;
  await writeImage(filePath, generator());
  return true;
}

async function maskNaturalLanguage(relativePath, filePath, includeManualMasks = true) {
  if (visualBrandAssets.has(relativePath)) return 0;
  const result = await execFile('tesseract', [filePath, 'stdout', '--psm', '11', 'tsv'], {
    maxBuffer: 16 * 1024 * 1024,
  });
  const boxes = [
    ...parseTsv(result.stdout),
    ...(includeManualMasks ? (manualMasks.get(relativePath) ?? []) : []),
  ];
  if (boxes.length === 0) return 0;

  const extension = path.extname(filePath).toLowerCase();
  const output = sharp(filePath)
    .composite([{ input: maskSvg(boxes), top: 0, left: 0 }])
    .flatten({ background: navy });
  const buffer =
    extension === '.jpg'
      ? await output.jpeg({ quality: 94, mozjpeg: true }).toBuffer()
      : await output.png({ compressionLevel: 9, palette: false }).toBuffer();
  await sharp(buffer).toFile(filePath);
  return boxes.length;
}

async function listImages(directory) {
  const entries = await fs.readdir(directory, { withFileTypes: true });
  const images = [];
  for (const entry of entries) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      images.push(...(await listImages(entryPath)));
      continue;
    }
    if (entry.isFile() && /\.(png|jpg)$/i.test(entry.name)) images.push(entryPath);
  }
  return images;
}

try {
  await execFile('tesseract', ['--version'], { maxBuffer: 1024 * 1024 });
} catch {
  throw new Error(
    'Language-neutral image rebuilding requires Tesseract OCR. Install Tesseract and retry.'
  );
}

const maximumMaskPasses = 6;
const files = await listImages(imageDirectory);
const report = { scanned: files.length, generated: 0, maskedLines: 0, unchanged: 0 };

for (const filePath of files) {
  const relativePath = path.relative(imageDirectory, filePath).split(path.sep).join('/');
  if (await replaceWithGeneratedVisual(relativePath, filePath)) {
    report.generated += 1;
    continue;
  }
  let masked = 0;
  for (let pass = 0; pass < maximumMaskPasses; pass += 1) {
    const maskedThisPass = await maskNaturalLanguage(relativePath, filePath, pass === 0);
    masked += maskedThisPass;
    if (maskedThisPass === 0) break;
  }
  report.maskedLines += masked;
  if (masked === 0) report.unchanged += 1;
}

console.log(JSON.stringify(report, null, 2));
