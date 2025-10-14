import 'package:ecommerce/features/auth/presentation/pages/login_page.dart';
import 'package:ecommerce/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/constants/api_urls.dart';
import '/core/di/service_locator.dart';
import '/core/presentation/widgets/global_network_listener.dart';
import '/core/routes/navigation.dart';
import '/core/theme/theme_manager.dart';
import '/core/utils/app_version.dart';
import '/core/utils/preferences_helper.dart';
import '/l10n/app_localizations.dart';
import 'core/presentation/widgets/app_starter_error.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize core services (preferences, API URLs, etc.)
    await initServices();

    // Initialize dependency injection (get_it service locator)
    // This must be called before runApp() to ensure all dependencies are ready
    await initDependencies();

    // Set Portrait Mode only
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(const ProviderScope(child: MyApp()));
  } catch (e, stackTrace) {
    // Log initialization error
    debugPrint('❌ App initialization failed: $e');
    debugPrint('Stack trace: $stackTrace');

    runApp(ProviderScope(child: AppStarterError(error: e.toString())));
  }
}

/// Initialize core services
Future<void> initServices() async {
  const flavorType = String.fromEnvironment('flavorType', defaultValue: 'DEV');
  ApiUrlExtention.setUrl(flavorType == 'DEV' ? UrlLink.isDev : UrlLink.isLive);
  await PrefHelper.init();
  await AppVersion.getVersion();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (ctx, child) {
        return MaterialApp(
          title: 'Ecommerce',
          navigatorKey: Navigation.key,
          debugShowCheckedModeBanner: false,

          // Localization
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: _getLocale(),

          // Theme
          theme: ThemeManager().themeData,

          // Network listener wrapper
          builder: (context, child) {
            return GlobalNetworkListener(child: child ?? const SizedBox());
          },

          // Initial route based on auth status
          home: _getInitialPage(),
        );
      },
    );
  }

  /// Get locale based on user preference
  Locale _getLocale() {
    final languageCode = PrefHelper.instance.getLanguage();
    return languageCode == 1
        ? const Locale('en', 'US')
        : const Locale('bn', 'BD');
  }

  /// Determine initial page based on authentication status
  Widget _getInitialPage() {
    final isLoggedIn = sl<AuthLocalDataSource>().isLoggedIn();
    if (isLoggedIn) {
      return const DashboardPage();
    }
    return const LoginPage();
  }
}
