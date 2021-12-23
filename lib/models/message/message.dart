class Message {
  late String _senderName;
  late String _message;
  late String _senderPhotoURL;
  late String _sentDate;
  late String _senderID;

  String get senderName => _senderName;
  String get senderPhotoURL => _senderPhotoURL;
  String get message => _message;
  String get sentDate => _sentDate;
  String get senderID => _senderID;

  Message(this._message, this._senderName, this._senderPhotoURL, this._sentDate,
      this._senderID);

  Map<String, dynamic> toMap() {
    return {
      "senderName": _senderName,
      "senderID": _senderID,
      "senderPhotoURL": _senderPhotoURL,
      "sentDate": DateTime.parse(_sentDate),
      "message": _message
    };
  }
}
