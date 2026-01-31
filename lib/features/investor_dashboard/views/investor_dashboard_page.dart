import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:capital_commons/features/investor_dashboard/cubit/investor_dashboard_cubit.dart";

class InvestorDashboardPage extends StatelessWidget {
  const InvestorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvestorDashboardCubit()..fetchDashboard(),
      child: BlocBuilder<InvestorDashboardCubit, InvestorDashboardState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Investor Dashboard")),
            body: Center(
              child: state.isLoading
                  ? const Text(
                      "Dashboard Loading...",
                      style: TextStyle(fontSize: 20),
                    )
                  : const Text(
                      "Dashboard Loaded!",
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          );
        },
      ),
    );
  }
}
