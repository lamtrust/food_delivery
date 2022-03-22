import 'dart:math';

/// Instance of [Random] for use in generating
/// random numbers
final _random = Random();

/// Get Random
///
/// Get a random number between [min] and [max]
/// as specified by parameters
/// Returns [int]
///
int getRandom(int min, int max) {
  return min + _random.nextInt(max - min);
}
