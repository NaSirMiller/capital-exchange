import "package:capital_commons/clients/auth_client.dart";
import "package:capital_commons/core/loading_status.dart";
import "package:capital_commons/core/logger.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:capital_commons/models/business.dart";
import "package:capital_commons/repositories/business_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "business_dashboard_cubit.freezed.dart";

class BusinessDashboardCubit extends Cubit<BusinessDashboardState> {
  BusinessDashboardCubit({BusinessRepository? businessRepository})
    : _businessRepository = businessRepository ?? getIt<BusinessRepository>(),
      super(const BusinessDashboardState());

  final _authClient = getIt<AuthClient>();
  final BusinessRepository _businessRepository;

  /// Load business data for the current user (business owner)
  Future<void> loadBusinessData() async {
    emit(state.copyWith(loadBusinessStatus: LoadingStatus.loading));

    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Assuming the business ID is the same as the user ID for business owners
      final business = await _businessRepository.getBusinessById(user.uid);

      if (business == null) {
        emit(
          state.copyWith(
            loadBusinessStatus: LoadingStatus.failure,
            message: "Business not found",
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          business: business,
          loadBusinessStatus: LoadingStatus.success,
        ),
      );
    } catch (e, st) {
      Log.error("Failed to load business data", error: e, stackTrace: st);
      emit(
        state.copyWith(
          loadBusinessStatus: LoadingStatus.failure,
          message: "Couldn't load business data",
        ),
      );
      emit(state.copyWith(message: null));
    }
  }
}

@freezed
sealed class BusinessDashboardState with _$BusinessDashboardState {
  const factory BusinessDashboardState({
    @Default(LoadingStatus.initial) LoadingStatus loadBusinessStatus,
    Business? business,
    String? message,
  }) = _BusinessDashboardState;
}
