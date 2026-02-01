import "package:capital_commons/clients/auth_client.dart";
import "package:capital_commons/clients/valuation_client.dart";
import "package:capital_commons/core/loading_status.dart";
import "package:capital_commons/core/logger.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:capital_commons/models/business_valuation_results.dart";
import "package:capital_commons/models/update_business.dart";
import "package:capital_commons/repositories/business_repository.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
part "issue_shares_cubit.freezed.dart";

class IssueSharesCubit extends Cubit<IssueSharesState> {
  IssueSharesCubit() : super(IssueSharesState());
  final _authClient = getIt<AuthClient>();
  final _businessValuationClient = getIt<BusinessValuationClient>();
  final _businessRepository = getIt<BusinessRepository>();

  Future<void> getBusinessValuation({required String businessId}) async {
    emit(state.copyWith(loadValuationStatus: LoadingStatus.loading));
    try {
      final evalResult = await _businessValuationClient.getBusinessValuation(
        businessId,
      );
      emit(
        state.copyWith(
          loadValuationStatus: LoadingStatus.success,
          valuationResults: evalResult,
        ),
      );
    } on FirebaseException catch (e) {
      emit(state.copyWith(loadValuationStatus: LoadingStatus.failure));
      throw BusinessValuationClientException(
        e.message ?? "Failed to get business valuation",
      );
    }
  }

  Future<void> issueShares({
    required double sharePrice,
    required int totalSharesIssued,
  }) async {
    emit(state.copyWith(issueSharesStatus: LoadingStatus.loading));

    final user = _authClient.currentUser1;

    if (user == null) {
      emit(
        state.copyWith(
          issueSharesStatus: LoadingStatus.failure,
          message: "User is not signed in",
        ),
      );
      emit(state.copyWith(message: null));
      return;
    }
    try {
      await _businessRepository.updateBusiness(
        user.uid,
        UpdateBusiness(
          sharePrice: sharePrice,
          totalSharesIssued: totalSharesIssued,
        ),
      );
    } catch (_) {
      Log.error("Could not create user info");
      emit(state.copyWith(message: "Could not create user info"));
      emit(state.copyWith(message: null));
    }
  }
}

@freezed
sealed class IssueSharesState with _$IssueSharesState {
  factory IssueSharesState({
    @Default(LoadingStatus.initial) LoadingStatus issueSharesStatus,
    @Default(LoadingStatus.initial) LoadingStatus loadValuationStatus,

    @Default(null) BusinessValuationResults? valuationResults,

    String? message,
  }) = _IssueSharesState;
}
