class Chat{
  final String name;
  final String message;
  final String imageUrl;

  Chat( {this.name, this.message, this.imageUrl});

  // json转model
  factory Chat.formJson(Map dic){
    return Chat(
        name: dic["name"],
        message: dic['message'],
        imageUrl:dic['imageUrl']
    );
  }
}