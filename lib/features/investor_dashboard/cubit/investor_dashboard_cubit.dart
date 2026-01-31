import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "investor_dashboard_cubit.freezed.dart";

class InvestorDashboardCubit extends Cubit<InvestorDashboardState> {
  InvestorDashboardCubit() : super(const InvestorDashboardState());

  // Placeholder fetch method for later
  void fetchDashboard() async {
    // For now, just wait 1 second
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false));
  }
}

@freezed
sealed class InvestorDashboardState with _$InvestorDashboardState {
  const factory InvestorDashboardState({
    @Default(true) bool isLoading,
  }) = _InvestorDashboardState;
}
