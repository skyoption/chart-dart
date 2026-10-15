import 'dart:math' as math;
import 'dart:ui';

/// Monotone cubic interpolation (Fritsch–Carlson). No overshoot.
Path monotoneCubicPath(List<Offset> p) {
  final path = Path();
  if (p.isEmpty) return path;
  path.moveTo(p[0].dx, p[0].dy);
  if (p.length < 3) {
    for (var i = 1; i < p.length; i++) {
      path.lineTo(p[i].dx, p[i].dy);
    }
    return path;
  }
  final n = p.length;
  final d = List<double>.filled(n - 1, 0);
  for (var i = 0; i < n - 1; i++) {
    final dx = p[i + 1].dx - p[i].dx;
    d[i] = dx == 0 ? 0 : (p[i + 1].dy - p[i].dy) / dx;
  }
  final m = List<double>.filled(n, 0)
    ..[0] = d[0]
    ..[n - 1] = d[n - 2];
  for (var i = 1; i < n - 1; i++) {
    m[i] = d[i - 1] * d[i] <= 0 ? 0 : (d[i - 1] + d[i]) / 2;
  }
  for (var i = 0; i < n - 1; i++) {
    if (d[i] == 0) {
      m[i] = 0;
      m[i + 1] = 0;
      continue;
    }
    final a = m[i] / d[i], b = m[i + 1] / d[i];
    final s = a * a + b * b;
    if (s > 9) {
      final t = 3 / math.sqrt(s);
      m[i] = t * a * d[i];
      m[i + 1] = t * b * d[i];
    }
  }
  for (var i = 0; i < n - 1; i++) {
    final h = (p[i + 1].dx - p[i].dx) / 3;
    path.cubicTo(
      p[i].dx + h,
      p[i].dy + m[i] * h,
      p[i + 1].dx - h,
      p[i + 1].dy - m[i + 1] * h,
      p[i + 1].dx,
      p[i + 1].dy,
    );
  }
  return path;
}

/// When zoomed out (many points per pixel), keep only the min and max y
/// in each bucket of [minDx] px. This removes shimmer and keeps spikes.
List<Offset> decimate(List<Offset> pts, {double minDx = 1.5}) {
  if (pts.length < 3) return pts;
  final out = <Offset>[pts.first];
  var bucketStart = pts.first.dx;
  Offset? lo, hi;
  for (var i = 1; i < pts.length - 1; i++) {
    final p = pts[i];
    if (p.dx - bucketStart >= minDx) {
      if (lo != null && hi != null) {
        out.addAll(lo.dx <= hi.dx ? [lo, hi] : [hi, lo]);
      }
      bucketStart = p.dx;
      lo = hi = null;
    }
    if (lo == null || p.dy > lo.dy) lo = p; // screen y grows downward
    if (hi == null || p.dy < hi.dy) hi = p;
  }
  if (lo != null && hi != null) {
    out.addAll(lo.dx <= hi.dx ? [lo, hi] : [hi, lo]);
  }
  out.add(pts.last);
  return out;
}
