import 'package:ecommerce/core/presentation/widgets/global_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/widgets/global_appbar.dart';
import '../../../../core/presentation/widgets/global_text.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: GlobalAppBar(title: "Profile"),
      body: state.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlobalText(str: "User Profile"),
              const SizedBox(height: 16),
              GlobalText(str: "NAME: ${data.profile?.fullName}"),
              const SizedBox(height: 8),
              GlobalText(str: "EMAIL: ${data.profile?.email}"),
              const SizedBox(height: 8),
              GlobalText(str: "PHONE: ${data.profile?.phone}"),
            ],
          ),
        ),
        loading: () => const Center(child: GlobalLoader()),
        error: (error, stackTrace) =>
            Center(child: GlobalText(str: "Error: $error")),
      ),
    );
  }
}
