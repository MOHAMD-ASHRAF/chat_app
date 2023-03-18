import 'package:flutter/material.dart';
import 'package:store_app/core/color_const.dart';
import 'package:store_app/core/const.dart';
import 'package:store_app/features/models/message_model.dart';
import 'package:store_app/features/presentation/widget/chat_bauble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/generated/assets.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  final _controller = ScrollController();
  static String id = 'HomePage';


  @override
  Widget build(BuildContext context) {
    var email =  ModalRoute.of(context)!.settings.arguments;
    CollectionReference messages =
    FirebaseFirestore.instance.collection(kMessageCollection);
    final TextEditingController controller = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation:3,
                  leading: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(Assets.imageUser),
                  ),
                  automaticallyImplyLeading: false,
                  title: const Text('chat page',style: TextStyle(color: Colors.black),),
                  actions: const[
                    Icon(Icons.camera_alt,color: kSecondColor,),
                    SizedBox(width: 10,),
                    Icon(Icons.phone,color: kSecondColor,),
                    SizedBox(width: 10,),
                    Icon(Icons.settings,color: kSecondColor,),
                    SizedBox(width: 5,),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index].id == email ?ChatBauble(
                              messageModel: messagesList[index],
                            ): ChatBaubleForHost(messageModel: messagesList[index],);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            'message': data,
                            'createdAt': DateTime.now(),
                            'id': email.toString(),
                          });
                          controller.clear();
                          _controller.animateTo(
                              0,
                              duration: const Duration(microseconds: 600), curve: Curves.easeIn);
                        },
                        decoration: InputDecoration(
                          hintText: 'Type Message',
                          suffixIcon:
                          const Icon(Icons.send, color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('Loading',style: TextStyle(fontSize: 20),)),
            );
          }
        });
  }
}
