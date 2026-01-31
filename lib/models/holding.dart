class Holding {

  Holding({
    required this.ticker,
    required this.sharePrice,
    required this.shareCount,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      ticker: json["ticker"],
      sharePrice: (json["share_price"] as num).toDouble(),
      shareCount: json["share_count"],
    );
  }
  final String ticker;
  final double sharePrice;
  final int shareCount;

  Map<String, dynamic> toJson() {
    return {
      "ticker": ticker,
      "share_price": sharePrice,
      "share_count": shareCount,
    };
  }
}
