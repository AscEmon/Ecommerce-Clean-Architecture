import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/core/presentation/view_util.dart';
import 'package:ecommerce/core/presentation/widgets/global_image_loader.dart';
import 'package:ecommerce/features/auth/data/datasources/auth_local_datasource.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/presentation/widgets/global_text.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigation.dart';
import '../../../../core/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authDataSource = sl<AuthLocalDataSource>();
    final user = authDataSource.getLoginResponse();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.secondary.color),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: GlobalImageLoader(
                    imagePath: user?.image ?? '',
                    imageFor: ImageFor.network,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                const SizedBox(height: 12),
                GlobalText(
                  str: '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (user?.email != null)
                  GlobalText(
                    str: user?.email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: AppColors.primary.color),
                  horizontalTitleGap: 10,
                  title: const GlobalText(str: 'Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigation.push(context, appRoutes: AppRoutes.profile);
                  },
                ),
                SizedBox(height: 10.h),

                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.red.color),
                  horizontalTitleGap: 10,
                  title: GlobalText(
                    str: 'Logout',
                    style: TextStyle(color: AppColors.red.color),
                  ),
                  onTap: () => _handleLogout(context, authDataSource),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Handle logout with proper async handling
Future<void> _handleLogout(
  BuildContext context,
  AuthLocalDataSource authDataSource,
) async {
  // Close drawer first
  Navigator.pop(context);

  try {
    // Clear auth data
    await authDataSource.clearAuthData();

    // Navigate to login and remove all previous routes
    if (context.mounted) {
      Navigation.pushAndRemoveUntil(context, appRoutes: AppRoutes.login);
    }
  } catch (e) {
    // Show error
    if (context.mounted) {
      ViewUtil.snackbar('Logout failed: $e');
    }
  }
}
