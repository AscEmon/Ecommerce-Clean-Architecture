import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/get_profile.dart';
import '/features/profile/presentation/providers/state/profile_state.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  FutureOr<ProfileState> build() async {
    return _getProfile();
  }

  Future<ProfileState> _getProfile() async {
    final getProfile = sl<GetProfile>();
    final result = await getProfile(NoParams());
    return result.fold((failure) => throw Exception(failure.message), (
      profile,
    ) {
      return ProfileState(profile: profile);
    });
  }
}
