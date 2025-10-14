import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

/// Notifier for managing current tab index
@riverpod
class DashboardProvider extends _$DashboardProvider {
  @override
  int build() {
    return 0; // Default to first tab (Home)
  }

  /// Update tab index
  void setTab(int index) {
    state = index;
  }
}
