import 'package:bits_bot/widget/customAppBar.dart';
import 'package:bits_bot/widget/messages.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class AnimatedFABJump extends StatefulWidget {
  @override
  _AnimatedFABJumpState createState() => _AnimatedFABJumpState();
}

class _AnimatedFABJumpState extends State<AnimatedFABJump>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isHovering = false;
  bool isContainerVisible = false;
  final TextEditingController _textMessageCont = TextEditingController();
  late DialogFlowtter dialogFlowtter;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((value) => dialogFlowtter = value);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.repeat(reverse: true);
  }

  void _stopAnimation() {
    _controller.stop();
  }

  void _toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible;
      _stopAnimation();
    });
  }

  void _toggleContainerInVisibility() {
    setState(() {
      isContainerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isContainerVisible)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            right: MediaQuery.of(context).size.height * 0.09,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green, width: 2)),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.3),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.7,
              // color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.68,
                        child: Scaffold(
                          appBar: CustomAppBar(),
                          body: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child:
                                            MessagesScreen(messages: messages))
                                  ],
                                )),
                          ),
                          bottomSheet: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(5, 8, 5, 2),
                            child: TextField(
                              controller: _textMessageCont,
                              // maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Enter your message...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors
                                          .green), // Border color when focused
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  color: Colors.green,
                                  onPressed: () {
                                    userMessage(_textMessageCont.text);
                                    _textMessageCont.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.04,
          right: MediaQuery.of(context).size.height * 0.04,
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                isHovering = true;
                _stopAnimation();
              });
            },
            onExit: (_) {
              setState(() {
                isHovering = false;
                if (!isHovering) {
                  _startAnimation();
                }
              });
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * _animation.value),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _stopAnimation();
                      _toggleContainerVisibility();
                    },
                    child: Image.asset('botlogo.png', width: 40, height: 40),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.02,
          right: MediaQuery.of(context).size.height * 0.04,
          child: Center(
            child: Text(
              "? Ask BITS",
              style: TextStyle(
                color: Colors.green[400],
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  messageResponse(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  userMessage(String userMessage) async {
    if (userMessage.isEmpty) {
      print('please enter some text');
    } else {
      setState(() {
        messageResponse(Message(text: DialogText(text: [userMessage])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: userMessage)));
      if (response.message == null) {
        return;
      } else {
        setState(() {
          messageResponse(response.message!);
        });
      }
    }
  }
}
