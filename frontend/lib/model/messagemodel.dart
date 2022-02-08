class MessageModel {
  String type;
  var message;
  String messageType;
  String time;
  MessageModel(this.type,this.message,this.messageType ,this.time);
  showElement(){
    print('$type $message $messageType');
  }
}
