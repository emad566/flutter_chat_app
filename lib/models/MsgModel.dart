
class MsgModel{
  late String text;
  late String userId;

  MsgModel({required this.text, required this.userId});

  factory  MsgModel.fromJson(Map<String, dynamic> json){
    print(json);
    return MsgModel(
      text: json['text'],
      userId: json['userId'],
    );
  }
}