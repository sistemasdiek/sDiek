import 'package:flutter/material.dart';

class DashboardKpi {
  final String activeGiras;
  final String pendingDeliveries;
  final String activeEmployees;
  final String monthlyPvrRevenue;
  final String salesTargetAchievement;

  DashboardKpi({
    required this.activeGiras,
    required this.pendingDeliveries,
    required this.activeEmployees,
    required this.monthlyPvrRevenue,
    required this.salesTargetAchievement,
  });
}

class DashboardProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DashboardKpi _kpi = DashboardKpi(
    activeGiras: '14',
    pendingDeliveries: '38',
    activeEmployees: '124',
    monthlyPvrRevenue: 'L. 485,200',
    salesTargetAchievement: '87.4%',
  );

  DashboardKpi get kpi => _kpi;

  Future<void> refreshDashboard() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    _kpi = DashboardKpi(
      activeGiras: '16',
      pendingDeliveries: '42',
      activeEmployees: '128',
      monthlyPvrRevenue: 'L. 512,800',
      salesTargetAchievement: '91.2%',
    );

    _isLoading = false;
    notifyListeners();
  }
}
