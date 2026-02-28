class TPlatformException implements Exception {
  final String code;
  TPlatformException(this.code);

  String get message {
    final c = code.toLowerCase();

    switch (c) {
      case 'invalid_login_credentials':
        return 'Invalid login credentials. Please double-check your information.';

      // Google Sign-In common codes
      case 'sign_in_canceled':
        return 'Sign-in was cancelled.';
      case 'network_error':
        return 'Network error. Please check your internet connection.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';

      // Firebase / platform-ish codes you already had (normalize to lowercase)
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      default:
        return 'Platform error ($code). Please try again.';
    }
  }
}