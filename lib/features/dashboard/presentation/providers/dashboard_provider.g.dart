// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing current tab index

@ProviderFor(DashboardProvider)
const dashboardProviderProvider = DashboardProviderProvider._();

/// Notifier for managing current tab index
final class DashboardProviderProvider
    extends $NotifierProvider<DashboardProvider, int> {
  /// Notifier for managing current tab index
  const DashboardProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardProviderHash();

  @$internal
  @override
  DashboardProvider create() => DashboardProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$dashboardProviderHash() => r'58d3b72d2ed6bf2f397670af47cb8f1c9275ea40';

/// Notifier for managing current tab index

abstract class _$DashboardProvider extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
