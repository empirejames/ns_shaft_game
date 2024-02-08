import 'dart:math' as math;

/// a ~ b and c ~ d has intersection
bool hasIntersection(num a, num b, num c, num d) {
  if (a > b || c > d) {
    throw Exception('Invalid input');
  }
  return a <= d && b >= c;
}

/// get intersection overlap value
num getIntersectionOverlap(num a, num b, num c, num d) {
  if (a > b || c > d) {
    throw Exception('Invalid input');
  }
  return math.min(b, d) - math.max(a, c);
}
