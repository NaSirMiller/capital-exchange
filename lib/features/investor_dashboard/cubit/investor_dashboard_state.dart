part of "investor_dashboard_cubit.dart";

class InvestorDashboardState {
  final LoadingStatus status;
  final Portfolio? portfolio;
  final List<Holding> holdings;
  final String? errorMessage;

  const InvestorDashboardState({
    required this.status,
    this.portfolio,
    required this.holdings,
    this.errorMessage,
  });

  factory InvestorDashboardState.initial() {
    return const InvestorDashboardState(
      status: LoadingStatus.idle,
      holdings: [],
    );
  }

  InvestorDashboardState copyWith({
    LoadingStatus? status,
    Portfolio? portfolio,
    List<Holding>? holdings,
    String? errorMessage,
  }) {
    return InvestorDashboardState(
      status: status ?? this.status,
      portfolio: portfolio ?? this.portfolio,
      holdings: holdings ?? this.holdings,
      errorMessage: errorMessage,
    );
  }
}
