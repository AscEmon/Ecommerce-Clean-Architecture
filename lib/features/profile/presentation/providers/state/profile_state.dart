import 'package:flutter/material.dart';

import '../../../domain/entities/profile.dart';

@immutable
class ProfileState {
  final bool isLoading;
  final String? errorMessage;
  final Profile? profile;

  const ProfileState({this.isLoading = false, this.errorMessage, this.profile});

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    Profile? profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
    );
  }
}
