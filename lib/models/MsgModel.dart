// ignore_for_file: file_names,
class MsgModel{
  late String text;
  late String userId;

  MsgModel({required this.text, required this.userId});

  factory  MsgModel.fromJson(Map<String, dynamic> json){
    return MsgModel(
      text: json['text'],
      userId: json['userId'],
    );
  }
}