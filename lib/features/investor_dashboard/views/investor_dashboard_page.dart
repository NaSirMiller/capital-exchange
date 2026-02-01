import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../cubit/investor_dashboard_cubit.dart";
import "../widgets/portfolio_overview.dart";
import "../widgets/holdings_list.dart";
import "../widgets/quick_actions.dart";

class InvestorDashboardPage extends StatelessWidget {
  const InvestorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvestorDashboardCubit()..loadDashboard(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A1628),
        body: SafeArea(
          child: BlocBuilder<InvestorDashboardCubit, InvestorDashboardState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PortfolioOverview(portfolio: state.portfolio),
                    const SizedBox(height: 24),
                    QuickActions(),
                    const SizedBox(height: 24),
                    HoldingsList(holdings: state.holdings),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
