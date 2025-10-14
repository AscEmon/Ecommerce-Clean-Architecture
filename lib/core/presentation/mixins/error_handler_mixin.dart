import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/presentation/view_util.dart';
import '/core/presentation/widgets/global_text.dart';

/// A mixin that provides error handling methods for presentation layer
mixin ErrorHandlerMixin {
  /// Show appropriate error UI based on failure type
  void handleError(dynamic error) {
    if (error is AuthenticationFailure || error is UnauthorizedException) {
      _showUnauthorizedDialog(error.toString());
    } else if (error is ServerFailure || error is ServerException) {
      _showServerErrorSnackBar(error.toString());
    } else if (error is NetworkFailure || error is NetworkException) {
      _showNetworkErrorSnackBar(error.toString());
    } else {
      ViewUtil.snackbar(error.toString());
    }
  }

  /// Show dialog for authentication errors
  void _showUnauthorizedDialog(String message) {
    ViewUtil.alertDialog(
      title: GlobalText(str: 'Authentication Error'),
      content: GlobalText(str: message),
    );
  }

  /// Show snackbar for server errors
  void _showServerErrorSnackBar(String message) {
    ViewUtil.snackbar('Server Error');
  }

  /// Show snackbar for network errors
  void _showNetworkErrorSnackBar(String message) {
    ViewUtil.snackbar('Network Error');
  }
}
