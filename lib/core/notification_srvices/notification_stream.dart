import 'dart:async';

class NotificationStream {
  static final _controller = StreamController<Map<String, dynamic>>.broadcast();

  static Stream<Map<String, dynamic>> get stream => _controller.stream;

  static void notify(Map<String, dynamic> data) {
    _controller.add(data);
  }
}
