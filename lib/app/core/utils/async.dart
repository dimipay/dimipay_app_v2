import 'dart:async';

Future<T> anySuccess<T>(Iterable<Future<T>> futures) {
  var completer = Completer<T>.sync();
  int errorCount = 0;
  void onValue(T value) {
    if (!completer.isCompleted) {
      completer.complete(value);
    }
  }

  void onError(Object error, StackTrace stack) {
    if (!completer.isCompleted) {
      errorCount++;

      if (errorCount == futures.length) {
        completer.completeError(error, stack);
      }
    }
  }

  for (final future in futures) {
    future.then(onValue, onError: onError);
  }
  return completer.future;
}
