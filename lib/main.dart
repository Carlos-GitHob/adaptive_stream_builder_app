import 'package:flutter/material.dart';
import 'package:adaptive_stream_builder_app/widgets/stream_adaptive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Stream ListView',
      home: MessageScreen(),
    );
  }
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _messageStream = AdaptiveStream();

  @override
  void initState() {
    super.initState();
    _messageStream.startMessages();
  }

  @override
  void dispose() {
    _messageStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Stream'),
        backgroundColor: Colors.lightBlue,
      ),
      body: StreamBuilder<String>(
        stream: _messageStream.messageStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            final message = snapshot.data!;
            return buidMessage(message);
          } else {
            return const Text(
              "Error! No hay datos",
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          }
        },
      ),
    );
  }

  Widget buidMessage(String message) {
    return ListView.builder(
        itemCount: message.length,
        itemBuilder: (BuildContext context, int index) {
          final mesg = message[index];
          return SizedBox(
            child: ListTile(
              title: Text(mesg, style:const TextStyle(fontWeight: FontWeight.bold),)
            ),
          );
        });
  }
}
