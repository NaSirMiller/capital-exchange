class InvestorsLeaderboard {

  InvestorsLeaderboard({
    required this.userId,
    required this.totalSharesBought,
    required this.largestNumSharesBought,
    required this.totalAmountBought,
    required this.profitPercentage,
  });

  factory InvestorsLeaderboard.fromJson(Map<String, dynamic> json) {
    return InvestorsLeaderboard(
      userId: json["user_id"],
      totalSharesBought: json["totalSharesBought"],
      largestNumSharesBought: json["largestNumSharesBought"],
      totalAmountBought: (json["totalAmountBought"] as num).toDouble(),
      profitPercentage: (json["profitPercentage"] as num).toDouble(),
    );
  }
  final String userId;
  final int totalSharesBought;
  final int largestNumSharesBought;
  final double totalAmountBought;
  final double profitPercentage;

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "totalSharesBought": totalSharesBought,
      "largestNumSharesBought": largestNumSharesBought,
      "totalAmountBought": totalAmountBought,
      "profitPercentage": profitPercentage,
    };
  }
}
