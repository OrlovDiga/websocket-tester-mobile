import 'package:flutter/material.dart';

import 'websocket_app.dart';

void main() => runApp(WebsocketApp());

/*
import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

dynamic onConnect(StompClient client, StompFrame frame) {
  client.subscribe(
      destination: '/queue/messages',
      callback: (StompFrame frame) {
        List<dynamic> result = json.decode(frame.body);
        print(result);
      });

  Timer.periodic(Duration(seconds: 10), (_) {
    client.send(
        destination: '/api/chat/endpoints', body: json.encode({'a': 123}));
  });
}

final stompClient = StompClient(
    config: StompConfig(
        url: 'http://localhost:8080/api/chat',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'token': 'bG9sOjE1OTg4OTI0MTIzOTI6OGIyZGRlNzNlNGQxYTkxNWVjN2Y0MmFiMzYwZTJmNzg'},
        webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'}));

void main() {
  stompClient.activate();
}*/
