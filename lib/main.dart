import 'package:bits_bot/widget/animatedFABJump.dart';
import 'package:bits_bot/widget/customAppBar.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyChatHome(),
    );
  }
}

class MyChatHome extends StatefulWidget {
  @override
  _MyChatHomeState createState() => _MyChatHomeState();
}

class _MyChatHomeState extends State<MyChatHome> {
  List<Map<String, dynamic>> messages = [];
  late DialogFlowtter dialogFlowtter;

  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((value) => dialogFlowtter = value);
  }

  void _sendMessage(Message message, [bool isUserMessage = false]) {
    setState(() {
      messages.add({'message': message, 'isUserMessage': isUserMessage});
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                String messageText = messages[index]['message'].text.text[0];
                bool isUserMessage = messages[index]['isUserMessage'];
                
                return isUserMessage
          ? ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    messageText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : ListTile(
              title: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    messageText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _messageController.text.trim();
                    userMessage(message);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  userMessage(String userMessage, [bool isUserMessage = false]) async {
    if (userMessage.isEmpty) {
      print('please enter some text');
    } else {
      if (userMessage.isNotEmpty) {
        _sendMessage(Message(text: DialogText(text: [userMessage])), true);
      }
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: userMessage)));
      if (response.message == null) {
        return;
      } else {
        setState(() {
          _sendMessage(response.message!);
        });
      }
    }
  }
}
