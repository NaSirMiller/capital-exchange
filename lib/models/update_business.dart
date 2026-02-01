import "package:freezed_annotation/freezed_annotation.dart";

part "update_business.freezed.dart";
part "update_business.g.dart";

@freezed
sealed class UpdateBusiness with _$UpdateBusiness {
  const factory UpdateBusiness({
    String? uid,
    String? name,
    String? description,
    String? industry,
    String? logoFilepath,
    String? plDocFilepath,
    double? projectedRevenue,
    double? projectedExpenses,
    double? projectedProfit,
    double? valuation,
    int? totalSharesIssued,
    double? sharePrice,
    double? dividendPercentage,
    bool? isApproved,
    String? address,
    double? goal,
    int? numInvestors,
    int? amountRaised,
    String? yearFounded,
  }) = _UpdateBusiness;

  factory UpdateBusiness.fromJson(Map<String, dynamic> json) =>
      _$UpdateBusinessFromJson(json);
}
