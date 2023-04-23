import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/MsgModel.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/widgets/components.dart';
import 'package:flutter_chat_app/widgets/custom_text_field.dart';
import 'package:flutter_chat_app/widgets/theme_colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _inputController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> chatTexts = [];
  List<MsgModel> messages = [];

  final GetStorage _box = GetStorage();
  late String loggedInUserId;

  dynamic docs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedInUserId = _box.read(Caches.cacheUserId);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildRegisterAppBar(
        setState: setState,
        context: context,
        actionRow: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logoPath, width: 50, height: 50,),
            Text(
              'Chat',
              style: GoogleFonts.lato(
                fontSize: 26,
                color: whiteClr,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: ThemeColors.chatBg,
              // child: buildFutureChatMsgItm(),
              child: SingleChildScrollView(
                child: buildFutureChatMsgItems(),
              ),
            ),
          ),

          buildInputBox()
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildFutureChatMsgItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('messages').orderBy('created_at').snapshots(),
      // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        
        if (snapshot.data != null) {
          loadMessages(snapshot.data!.docs);
          return Column(
            children: [
              ...messages.map((MsgModel msg) => chatMsgItem(item: msg)).toList()
            ],
          );
        }

        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
  
  Material buildInputBox() {
    return Material(
      elevation: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        color: ThemeColors.chatInputBg,
        child: CustomTextField(
          controller: _inputController,
          hintText: 'your msg',
          borderColor: ThemeColors.chatInputBorder,
          suffixIcon: IconButton(
            onPressed: () {
              storeMsgToFirebase();
            },
            icon: Icon(
              Icons.send,
              size: 30,
              color: ThemeColors.chatInputBorder,
            ),
          ),
        ),
      ),
    );
  }

  void storeMsgToFirebase() {
    if(_inputController.text == '') return;

    FirebaseFirestore db = FirebaseFirestore.instance;
    final message = <String, dynamic>{
      "text": _inputController.text,
      "userId": loggedInUserId,
      "created_at": DateTime.now(),
    };

    db.collection("messages").add(message).then((DocumentReference doc) async{
      _inputController.text= '';
      if (kDebugMode) {
        print('messages id: ${doc.id}');
      }
    });
  }

  loadMessages(List<QueryDocumentSnapshot<Object?>> messagesList){
    messages = [];
    for (var item in messagesList) {
      messages.add(MsgModel.fromJson(item.data() as Map<String, dynamic>));
    }
  }

  Widget chatMsgItem({
    required MsgModel item
  }) {
    return Row(
      mainAxisAlignment: item.userId == loggedInUserId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        item.text.length >35? Expanded(child: chatMsgItemContainer(item)) : chatMsgItemContainer(item),
      ],
    );
  }

  Container chatMsgItemContainer(MsgModel item) {
    return Container(
        margin : const EdgeInsets.all(10),
        padding : const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30.0),
            bottomLeft: Radius.circular(item.userId == loggedInUserId ? 30 : 0),
            bottomRight: Radius.circular(item.userId != loggedInUserId ? 30 : 0),
            topRight: const Radius.circular(30.0),
          ),
          color: item.userId == loggedInUserId ? ThemeColors.chatItemBg.withOpacity(.7) : ThemeColors.chatItemBg,
        ),

        child: Text(
          item.text ,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: whiteClr,
                fontSize: 20
            ),
          ),
        ),
      );
  }
}
