import "package:flutter_bloc/flutter_bloc.dart";
import "../../../models/portfolio.dart";
import "../../../models/holding.dart";
import "../../../core/loading_status.dart";

part "investor_dashboard_state.dart";

class InvestorDashboardCubit extends Cubit<InvestorDashboardState> {
  InvestorDashboardCubit() : super(InvestorDashboardState.initial());

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: LoadingStatus.loading));

    try {
      // TODO: Replace with Firestore calls
      final portfolio = Portfolio(
        totalValue: 12450,
        totalInvested: 10000,
        totalReturn: 2450,
      );

      final holdings = <Holding>[
        Holding(
          businessName: "River Street Café",
          shares: 120,
          value: 2400,
          dividendYield: 4.2,
        ),
        Holding(
          businessName: "Capital Tech Co",
          shares: 80,
          value: 3800,
          dividendYield: 6.1,
        ),
      ];

      emit(
        state.copyWith(
          status: LoadingStatus.success,
          portfolio: portfolio,
          holdings: holdings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoadingStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
