import "package:capital_commons/core/logger.dart";
import "package:capital_commons/models/business.dart";
import "package:capital_commons/models/create_business.dart";
import "package:capital_commons/models/update_business.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class BusinessRepositoryException implements Exception {
  const BusinessRepositoryException([
    this.message = "An unexpected error occurred",
  ]);
  final String message;
}

const _businessesCollectionName = "businesses";

class BusinessRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createBusiness(CreateBusiness business) async {
    Log.trace("Creating business with id ${business.uid}");
    try {
      await _firestore
          .collection(_businessesCollectionName)
          .doc(business.uid)
          .set(business.toJson());
    } on FirebaseException catch (e) {
      Log.error(
        "FirebaseException occurred while creating business ${business.uid}: $e",
      );
      throw const BusinessRepositoryException("A FirebaseException occurred");
    }
  }

  Future<void> updateBusiness(String businessId, UpdateBusiness updates) async {
    Log.trace("Updating business with id $businessId");
    try {
      await _firestore
          .collection(_businessesCollectionName)
          .doc(businessId)
          .update(updates.toJson());
    } on FirebaseException catch (e) {
      Log.error(
        "FirebaseException occurred while updating business $businessId: $e",
      );
      throw const BusinessRepositoryException("A FirebaseException occurred");
    }
  }

  Future<Business?> getBusinessById(String businessId) async {
    Log.trace("Fetching business with id $businessId");
    try {
      final doc = await _firestore
          .collection(_businessesCollectionName)
          .doc(businessId)
          .get();

      if (!doc.exists) {
        Log.trace("Business with id $businessId not found");
        return null;
      }

      return Business.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      Log.error(
        "FirebaseException occurred while fetching business $businessId: $e",
      );
      throw const BusinessRepositoryException("A FirebaseException occurred");
    }
  }

  Future<List<Business>> getAllBusinesses() async {
    Log.trace("Getting all businesses");

    late final QuerySnapshot<Map<String, dynamic>> results;
    try {
      results = await _firestore.collection(_businessesCollectionName).get();
    } on FirebaseException catch (e) {
      Log.error("FirebaseException occurred while getting all businesses: $e");
      throw const BusinessRepositoryException("A FirebaseException occurred");
    }

    final businesses = <Business>[];
    for (final doc in results.docs) {
      try {
        businesses.add(Business.fromJson(doc.data()));
      } on TypeError catch (e) {
        Log.warning("TypeError while converting doc to business: $e");
      }
    }

    Log.debug("Loaded ${businesses.length} businesses");

    return businesses;
  }
}
