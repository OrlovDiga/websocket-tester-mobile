import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagePage extends StatefulWidget {
  //Map<String, dynamic> header = {'token': 'bG9sOjE1OTg3ODY4MDI2ODA6ODI1ZjE5YzM5MWUxOGIzZWY0OWIzYTk5MzRmMDI3Yzc'};
  final WebSocketChannel chanelOne = IOWebSocketChannel.connect(
    Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
    headers: {'token': 'bG9sOjE1OTg5NjM0ODAyMTg6MDlkZmNlYzdkNzQzNDY4YmFhYjU2ZTUyMjA0MDgyM2Q'}
  );

  final WebSocketChannel chanelTwo = IOWebSocketChannel.connect(
      Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
      headers: {'token': 'dXNlcjoxNTk4OTYzNDk3Njk3OjgwMzJkZWM1M2VlYjkwMmMyNGFiZmM3Yjg5ZTk3MmJj'}
  );

  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
 }

class _MessagePageState extends State<MessagePage> {
  TextEditingController _controllerOne = TextEditingController();
  TextEditingController _controllerTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Websocket Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controllerOne,
                decoration: InputDecoration(labelText: 'Send a message to chanelTwo'),
              ),
            ),
            Form(
              child: TextFormField(
                controller: _controllerTwo,
                decoration: InputDecoration(labelText: 'Send a message to chanelOne'),
              ),
            ),
            StreamBuilder(
              stream: widget.chanelOne.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            ),
            StreamBuilder(
              stream: widget.chanelTwo.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controllerOne.text.isNotEmpty) {
      print("Adding message: ${_controllerOne.text}");
      widget.chanelOne.sink.add(_controllerOne.text);
    } else if (_controllerTwo.text.isNotEmpty) {
      print("Adding message: ${_controllerTwo.text}");
      widget.chanelTwo.sink.add(_controllerTwo.text);
    }
  }

  @override
  void dispose() {
    widget.chanelOne.sink.close();
    widget.chanelTwo.sink.close();
    super.dispose();
  }
}