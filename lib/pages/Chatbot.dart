import 'package:dio/dio.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final ScrollController _scrollController = ScrollController(); 
  final List<ChatMessage> _message = [];
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.149.84:3000";
  final TextEditingController _textEditingController = TextEditingController();
  void _scrollDown(){
    WidgetsBinding.instance.addPostFrameCallback((_)=> 
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,     
          duration: Duration(milliseconds:750) , curve: Curves.easeOutCirc
        )
    );
  }   
  Future<void> _sentMessage(String message)async{
    print("sent");
    setState(() {
      _message.add(ChatMessage(text:message, isUser: true));
    });  
    try{
      final response = await _dio.post('$baseUrl/ai-bot', data:{
        "prompt":message
      });
      final text = response.data["text"]["content"];
      setState(() {
        _message.add(ChatMessage(text: text, isUser: false));
        _scrollDown();
      });
    }catch(e){
      setState(() {
        _message.add(ChatMessage(text: "Something went wrong", isUser:false));

      });
    }finally{
      _textEditingController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeedf2),    
      appBar: AppBar(
        backgroundColor: const Color(0xFFeeedf2),  
        title: Text("Bot PETIFY"),
      ),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _message.length,
              itemBuilder: (context, index){
                return ChatBubble(message:_message[index]);
              },
            ),
          ),
          Container(
            color:Color(0xFFeeedf2),
            child: Padding(
              padding: EdgeInsets.only(bottom:20, top:5,left:15, right:15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Ask Anything",
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(12),
                          borderSide:BorderSide(
                            color:Color.fromARGB(255,243,33,243),
                            width: 2
                          ),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color:Colors.grey,
                            width:2
                          )
                        )
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: ()=>_sentMessage(_textEditingController.text),
                      icon:Icon(FluentSystemIcons.ic_fluent_send_filled, color:Color.fromARGB(255,243,33,243),)

                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 15,

                          ),
                          alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color: message.isUser?Colors.green[200]:Colors.blue[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: message.isUser ? Radius.circular(25):Radius.zero,
                              bottomRight: message.isUser?Radius.zero : Radius.circular(25),
                            )
                          ),
                          child: message.isUser ? Text(
                             message.text,
                             style:TextStyle(
                               fontSize:16
                             )
                          ):GptMarkdown(
                             message.text,

                              style:TextStyle(
                                  fontSize:16
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

