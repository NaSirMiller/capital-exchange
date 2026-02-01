import "package:freezed_annotation/freezed_annotation.dart";

part "business_valuation_results.freezed.dart";
part "business_valuation_results.g.dart";

@freezed
sealed class BusinessValuationResults with _$BusinessValuationResults {
  factory BusinessValuationResults({
    required double pricePerShare,
    required int sharesAllowed,
    required String businessClass,
  }) = _BusinessValuationResults;
  factory BusinessValuationResults.fromJson(Map<String, dynamic> json) =>
      _$BusinessValuationResultsFromJson(json);
}
