class Message {
  late String _senderName;
  late String _message;
  late String _senderPhotoURL;
  late String _sentDate;

  String get senderName => _senderName;
  String get senderPhotoURL => _senderPhotoURL;
  String get message => _message;
  String get sentDate => _sentDate;

  Message(
      this._message, this._senderName, this._senderPhotoURL, this._sentDate);
}
