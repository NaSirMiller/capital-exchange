import "package:capital_commons/models/business_valuation_results.dart";
import "package:cloud_functions/cloud_functions.dart";

class BusinessValuationClientException implements Exception {
  const BusinessValuationClientException([
    this.message = "An unexpected error occurred",
  ]);

  final String message;
}

class BusinessValuationClient {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<BusinessValuationResults> getBusinessValuation(
    String businessId,
  ) async {
    try {
      final result = await _functions
          .httpsCallable("get_business_valuation")
          .call({"business_id": businessId});

      final data = result.data;

      if (data is! Map<String, dynamic>) {
        throw const BusinessValuationClientException(
          "Invalid response format from business valuation service",
        );
      }

      // Handle error payloads returned as 200s
      if (data.containsKey("status") && data["status"] != 200) {
        throw BusinessValuationClientException(
          data["error"]?.toString() ?? "Business valuation failed",
        );
      }

      final payload = data["data"];

      if (payload is! Map<String, dynamic>) {
        throw const BusinessValuationClientException(
          "Invalid valuation payload",
        );
      }

      return BusinessValuationResults.fromJson(payload);
    } on FirebaseFunctionsException catch (e) {
      throw BusinessValuationClientException(
        e.message ?? "Failed to get business valuation",
      );
    } catch (_) {
      throw const BusinessValuationClientException();
    }
  }
}
