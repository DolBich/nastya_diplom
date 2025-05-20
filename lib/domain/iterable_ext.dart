import 'dart:math';

extension IterableRandom<E> on Iterable<E> {
  E randomElement() {
    final random = Random();
    return elementAt(random.nextInt(length));
  }

  E? firstWhereOrNull(bool Function(E) test) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}