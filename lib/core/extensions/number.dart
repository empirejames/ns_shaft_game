extension NumX on num {
  bool inRange(num min, num max) => this >= min && this <= max;

  bool between(num min, num max) => this > min && this < max;
}