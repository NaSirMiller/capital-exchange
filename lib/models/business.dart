class Business {

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      uid: json["uid"],
      name: json["name"],
      description: json["description"],
      industry: json["industry"],
      logoFilepath: json["logo_filepath"],
      plDocFilepath: json["pl_doc_filepath"],
      projectedRevenue: (json["projectedRevenue"] as num).toDouble(),
      projectedExpenses: (json["projectedExpenses"] as num).toDouble(),
      projectedProfit: (json["projectedProfit"] as num).toDouble(),
      valuation: (json["valuation"] as num).toDouble(),
      totalSharesIssued: json["totalSharesIssued"],
      sharePrice: (json["sharePrice"] as num).toDouble(),
      dividendPercentage: (json["dividendPercentage"] as num).toDouble(),
      isApproved: json["isApproved"],
    );
  }

  Business({
    required this.uid,
    required this.name,
    required this.description,
    required this.industry,
    this.logoFilepath,
    this.plDocFilepath,
    required this.projectedRevenue,
    required this.projectedExpenses,
    required this.projectedProfit,
    required this.valuation,
    required this.totalSharesIssued,
    required this.sharePrice,
    required this.dividendPercentage,
    required this.isApproved,
  });
  final String uid;
  final String name;
  final String description;
  final String industry;
  final String? logoFilepath;
  final String? plDocFilepath;
  final double projectedRevenue;
  final double projectedExpenses;
  final double projectedProfit;
  final double valuation;
  final int totalSharesIssued;
  final double sharePrice;
  final double dividendPercentage;
  final bool isApproved;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "description": description,
      "industry": industry,
      "logo_filepath": logoFilepath,
      "pl_doc_filepath": plDocFilepath,
      "projectedRevenue": projectedRevenue,
      "projectedExpenses": projectedExpenses,
      "projectedProfit": projectedProfit,
      "valuation": valuation,
      "totalSharesIssued": totalSharesIssued,
      "sharePrice": sharePrice,
      "dividendPercentage": dividendPercentage,
      "isApproved": isApproved,
    };
  }
}
