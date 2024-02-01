// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;
  bool connected = false;

  SocketService(String url, {VoidCallback? onSocketConnected}) {
    // Initialize your socket with the provided URL
    socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );

    connect();
    onConnect(onConnect: (_) {
      connected = true;
      log("<< --- SOCKET CONNECTED --- >>");
      if (onSocketConnected != null) {
        onSocketConnected();
      }
    });
    onDisconnected(onDisconnect: (_) {
      connected = false;
      log("<< --- SOCKET DISCONNECTED --- >>");
      // ToastPlugin.showToast("Socket disonnected!", 1);
    });
    onConnectError(
      onError: (error) {
        connected = false;
        log("<< --- SOCKET FAILED TO CONNECT --- >> $error");
      },
    );
  }

  void changeSocketUrl(String newUrl) {
    if (!connected) {
      socket?.disconnect();
      socket = IO.io(newUrl);
      connect();
    }
  }

  void connect() {
    if (socket == null) return;
    socket!.connect();
  }

  void disconnect() {
    if (socket == null) return;
    socket!.disconnect();
  }

  void onConnect({required void Function(dynamic) onConnect}) {
    if (socket == null) return;
    socket!.onConnect(onConnect);
  }

  void onConnectError({required void Function(dynamic) onError}) {
    if (socket == null) return;
    socket!.onConnectError(onError);
  }

  void onDisconnected({required void Function(dynamic) onDisconnect}) {
    if (socket == null) return;
    socket!.onDisconnect(onDisconnect);
  }

  void emit({required String event, required dynamic data}) {
    if (socket == null) return;
    socket!.emit(event, data);
  }

  void on({
    required String event,
    required void Function(dynamic) onEvent,
  }) {
    if (socket == null) return;
    socket!.on(event, onEvent);
  }

  void off({
    required String event,
    required void Function(dynamic) onEvent,
  }) {
    if (socket == null) return;
    socket!.off(event, onEvent);
  }
}
