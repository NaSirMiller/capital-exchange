import "holding.dart";

class Portfolio {

  Portfolio({
    required this.userUid,
    required this.holdings,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      userUid: json["user_uid"],
      holdings: (json["holdings"] as List<dynamic>)
          .map((h) => Holding.fromJson(h))
          .toList(),
    );
  }
  final String userUid;
  final List<Holding> holdings;

  Map<String, dynamic> toJson() {
    return {
      "user_uid": userUid,
      "holdings": holdings.map((h) => h.toJson()).toList(),
    };
  }
}
