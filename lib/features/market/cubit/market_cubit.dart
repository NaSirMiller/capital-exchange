import "package:capital_commons/core/loading_status.dart";
import "package:capital_commons/core/logger.dart";
import "package:capital_commons/core/service_locator.dart";
import "package:capital_commons/models/business.dart";
import "package:capital_commons/repositories/business_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "market_cubit.freezed.dart";

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(const MarketState());

  final _businessRepository = getIt<BusinessRepository>();

  Future<void> loadBusinesses() async {
    emit(
      state.copyWith(
        businesses: [],
        loadBusinessesStatus: LoadingStatus.loading,
      ),
    );

    try {
      final businesses = await _businessRepository.getAllBusinesses();
      emit(
        state.copyWith(
          businesses: businesses,
          loadBusinessesStatus: LoadingStatus.success,
        ),
      );
    } on BusinessRepositoryException catch (e) {
      Log.error(
        "BusinessRepositoryException occurred while getting all businesses: $e",
      );
      emit(state.copyWith(loadBusinessesStatus: LoadingStatus.failure));
    }
  }
}

@freezed
sealed class MarketState with _$MarketState {
  const factory MarketState({
    @Default([]) List<Business> businesses,
    @Default(LoadingStatus.initial) LoadingStatus loadBusinessesStatus,
    String? message,
  }) = _MarketState;
}
