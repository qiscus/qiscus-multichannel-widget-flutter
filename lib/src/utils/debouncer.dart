import 'dart:async';

class Debouncer {
  Debouncer(this.millis);

  final int millis;
  Timer? _timer;

  void run(void Function() cb) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: millis), cb);
  }

  void dispose() {
    _timer?.cancel();
  }
}
