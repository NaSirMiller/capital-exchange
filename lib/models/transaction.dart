class TransactionModel {

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      uid: json["uid"],
      fromUser: json["fromUser"],
      toUser: json["toUser"],
      numShares: json["numShares"],
      isProcessed: json["isProcessed"],
      timestamp: DateTime.parse(json["timestamp"]),
      pricePerShare: (json["pricePerShare"] as num).toDouble(),
    );
  }

  TransactionModel({
    required this.uid,
    required this.fromUser,
    required this.toUser,
    required this.numShares,
    required this.isProcessed,
    required this.timestamp,
    required this.pricePerShare,
  });
  final String uid;
  final String fromUser;
  final String toUser;
  final int numShares;
  final bool isProcessed;
  final DateTime timestamp;
  final double pricePerShare;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "fromUser": fromUser,
      "toUser": toUser,
      "numShares": numShares,
      "isProcessed": isProcessed,
      "timestamp": timestamp.toIso8601String(),
      "pricePerShare": pricePerShare,
    };
  }
}
