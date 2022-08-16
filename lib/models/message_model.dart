class messageModel {
  String? senderId;
  String? receverId;
  String? dateTime;
  String? text;
  String? imageUrl;

  messageModel({
    this.senderId,
    this.receverId,
    this.dateTime,
    this.text,
    this.imageUrl,
  });

  messageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receverId = json['receverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receverId': receverId,
      'dateTime': dateTime,
      'text': text,
      'imageUrl': imageUrl,
    };
  }
}

// abstract class messageeModel {
//   String? senderId;
//   String? receverId;
//   String? dateTime;

//   messageeModel({
//     this.senderId,
//     this.receverId,
//     this.dateTime,
//   });

//   messageeModel.fromJson(Map<String, dynamic> json) {
//     senderId = json['senderId'];
//     receverId = json['receverId'];
//     dateTime = json['dateTime'];
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'receverId': receverId,
//       'dateTime': dateTime,
//     };
//   }
// }

// class imageMessage extends messageModel {
  
//   String? imageUrl;

//   imageMessage({senderId, this.imageUrl}) : super(senderId: senderId,receverId: receverId);

//   Map<String, dynamic> toMap() {
//     return {
//       'imageUrl': imageUrl,
//     };
//   }
// }
