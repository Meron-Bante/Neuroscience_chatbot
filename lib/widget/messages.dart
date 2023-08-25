import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        String messageText = widget.messages[index]['message'].text.text[0];

        if (messageText.isEmpty) {
          messageText = "Say hi to start a conversation";
        }

        return Row(
          mainAxisAlignment: widget.messages[index]['isUserMessage']
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    widget.messages[index]['isUserMessage'] ? 20 : 0,
                  ),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(
                    widget.messages[index]['isUserMessage'] ? 0 : 20,
                  ),
                  topLeft: Radius.circular(
                    widget.messages[index]['isUserMessage'] ? 20 : 0,
                  ),
                ),
                color: widget.messages[index]['isUserMessage']
                    ? Colors.green
                    : Colors.grey[700],
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: SingleChildScrollView(
                child: Text(
                  messageText,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
