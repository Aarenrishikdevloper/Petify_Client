import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/models/feedbackmodel.dart';
import 'package:mobile/provider/feedbackProvider.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final ScrollController _scrollController =ScrollController();
  final TextEditingController _feedbackController = TextEditingController();
  void _scrolldown(){
    WidgetsBinding.instance.addPostFrameCallback((_)=>
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds:700),
          curve: Curves.easeOutCirc
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeedf2),
      appBar: AppBar(
        title: const Text("your Feedbacks"),
        backgroundColor: const Color(0xFFeeedf2),
      ),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Lottie.asset("assets/animations/feedback.json"),
              )
            ],
          ),
          Text(
              "Share your thoughts with us",
               style:TextStyle(fontSize:18)
          ),
          Consumer<Feedbackprovider>(
             builder: (context,provider,child){
               return Expanded(
                  child: ListView.builder(
                     controller: _scrollController,
                     itemCount: provider.feedback.length,
                     itemBuilder: (context, index){
                       Feedbackmodel feedback = provider.feedback[index];
                       return FeedbackBuddle(
                         feedback:feedback.feedback ,
                         feedbackId: feedback.id!,
                         time: feedback.time,
                         onDelte: (){
                           provider.deletefeedback(feedback.id!);
                         },

                       );
                     },
                  ),
               );
             },
          ),
         Consumer<Feedbackprovider>(
           builder: (context,provider, child){
             return   Container(
                 color:Color(0xFFeeedf2),
                 child:Padding(
                   padding:EdgeInsets.only(
                     bottom:20,top:5,left:15,right:15,

                   ) ,
                   child: Row(
                     children: [
                       Expanded(
                         child: TextField(

                           decoration: InputDecoration(
                               hintText: "Write your feedback here",
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(12),

                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(12),
                                   borderSide: BorderSide(
                                       color:Color.fromARGB(255,243,33,243),
                                       width: 2
                                   )
                               ),
                               enabledBorder: OutlineInputBorder(
                                   borderRadius:BorderRadius.circular(12),
                                   borderSide:BorderSide(color:Colors.grey, width:2)
                               )
                           ),
                           controller: _feedbackController,
                         ),
                       ),
                       IconButton(
                         onPressed:(){
                           if(_feedbackController.text.isNotEmpty){

                             provider.addFeedback(_feedbackController.text);
                             _feedbackController.clear();
                             _scrolldown();
                           }
                         } ,
                         icon: Icon(
                             FluentSystemIcons.ic_fluent_send_filled,
                             color:Color.fromARGB(255,37,33,243)
                         ),
                       )
                     ],
                   ),
                 )
             );
           },
         )
        ],
      )
    );
  }
}
class FeedbackBuddle extends StatelessWidget {
  final String feedback, feedbackId;
  final DateTime time;
  final VoidCallback onDelte;

  const FeedbackBuddle({super.key, required this.feedback, required this.feedbackId, required this.time, required this.onDelte});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:8, horizontal: 15),
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width / 1.25),
        padding: EdgeInsets.symmetric(vertical:10, horizontal: 14),
        decoration: BoxDecoration(
          color:Color.fromARGB(255,100,73,65),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(25),
            bottomRight: .zero,
          )
        ),
        child: Column(
          crossAxisAlignment: .end,
          children: [
            Text(
                feedback,
                style:TextStyle(
                  fontSize:16,
                  color:Colors.white
                )
            ),
            SizedBox(height:5,),
            Row(
              mainAxisSize: .min,
              children: [
                Text(
                  DateFormat.yMMMd().add_jm().format(time),
                  style: const TextStyle(
                      fontSize: 12,
                      color:Colors.white70
                  ),
                ),
                SizedBox(width: 8,),
                IconButton(
                  icon:Icon(
                    Icons.delete,
                    color:Colors.white,
                    size: 12,
                  ),
                  onPressed: onDelte,
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}

