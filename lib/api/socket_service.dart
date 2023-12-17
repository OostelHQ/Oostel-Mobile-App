import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class SocketChannel {
  SocketChannel(this._getIOWebSocketChannel) {
    _startConnection();
  }

  final IOWebSocketChannel Function() _getIOWebSocketChannel;

  late IOWebSocketChannel _ioWebSocketChannel;

  WebSocketSink get _sink => _ioWebSocketChannel.sink;

  late Stream<dynamic> _innerStream;

  final _outerStreamSubject = BehaviorSubject<dynamic>();

  Stream<dynamic> get stream => _outerStreamSubject.stream;

  bool _isFirstRestart = false;
  bool _isFollowingRestart = false;
  bool _isManuallyClosed = false;

  void _handleLostConnection() {
    log("Lost Websocket Connection");
    if (_isFirstRestart && !_isFollowingRestart) {
      Future.delayed(const Duration(seconds: 3), () {
        _isFollowingRestart = false;
        _startConnection();
      });
      _isFollowingRestart = true;
    } else {
      _isFirstRestart = true;
      _startConnection();
    }
  }

  void _startConnection() {
    log("Starting Websocket Connection");
    _ioWebSocketChannel = _getIOWebSocketChannel();
    _innerStream = _ioWebSocketChannel.stream;
    log("Websocket Connected");
    _innerStream.listen(
      (event) {
        _isFirstRestart = false;
        _outerStreamSubject.add(event);
      },
      onError: (error) {
        _handleLostConnection();
      },
      onDone: () {
        if (!_isManuallyClosed) {
          _handleLostConnection();
        }
      },
    );
  }

  void sendMessage(dynamic message) => _sink.add(message);

  void close() {
    log("Closed Websocket Connection");
    _isManuallyClosed = true;
    _sink.close(status.goingAway);
  }
}

final StateProvider<SocketChannel> messageSocketProvider = StateProvider(
  (ref) => SocketChannel(
    () => IOWebSocketChannel.connect(
      test,
    ),
  ),
);


String test = 'wss://echo.websocket.events';
String base = 'wss://fyndaapp-001-site1.htempurl.com/hubs/message';

String sendMessageSignal = 'sendMessage', receiveMessageSignal = 'receiveMessage';