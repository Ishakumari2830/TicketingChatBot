// Custon exception class to handle various Firebase-related errors.
class TFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message{
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'user-not-found':
        return 'No user found for the given email or UID.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA response is invalid. Please try again.';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API key.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'invalid-api-key':
        return 'The provided API key is invalid. Please check the API key and try again.';
      case 'invalid-phone-number':
        return 'The phone number is invalid. Please enter a valid phone number.';
      case 'quota-exceeded':
        return 'The quota for this project has been exceeded. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests have been made. Please try again later.';
      case 'user-token-expired':
        return 'The user token has expired. Please sign in again.';
      case 'user-cancelled':
        return 'The user canceled the operation.';
      case 'user-denied':
        return 'The user denied the request.';
      case 'invalid-session-cookie':
        return 'The session cookie is invalid. Please try again.';
      case 'session-cookie-expired':
        return 'The session cookie has expired. Please try again.';
      case 'session-cookie-mismatch':
        return 'The session cookie does not match the current session. Please try again.';
      case 'session-cookie-reset':
        return 'The session cookie has been reset. Please try again.';
      case 'session-cookie-revoked':
        return 'The session cookie has been revoked. Please try again.';
      case 'invalid-id-token':
        return 'The ID token is invalid. Please try again.';
      case 'id-token-expired':
        return 'The ID token has expired. Please try again.';
      case 'id-token-revoked':
        return 'The ID token has been revoked. Please try again.';
      case 'invalid-refresh-token':
        return 'The refresh token is invalid. Please try again.';
      case 'refresh-token-expired':
        return 'The refresh token has expired. Please try again.';
      case 'refresh-token-revoked':
        return 'The refresh token has been revoked. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token is invalid. Please try again.';
      case 'custom-token-expired':
        return 'The custom token has expired. Please try again.';
      case 'custom-token-revoked':
        return 'The custom token has been revoked. Please try again.';
      case 'invalid-credential-type':
        return 'The credential type is invalid. Please try again.';
      case 'credential-already-in-use':
        return 'The credential is already in use. Please try again.';
      case 'invalid-email-verification-code':
        return 'The email verification code is invalid. Please try again.';
      case 'email-verification-code-expired':
        return 'The email verification code has expired. Please try again.';
      case 'email-already-verified':
        return 'The email has already been verified.';
      case 'email-not-verified':
        return 'The email has not been verified.';
      case 'invalid-phone-number-verification-code':
        return 'The phone number verification code is invalid. Please try again.';
      case 'phone-number-verification-code-expired':
        return 'The phone number verification code has expired. Please try again.';
      case 'phone-number-already-verified':
        return 'The phone number has already been verified.';
      case 'phone-number-not-verified':
        return 'The phone number has not been verified.';
      case 'invalid-oath-token':
        return 'The OAuth token is invalid. Please try again.';
      case 'oath-token-expired':
        return 'The OAuth token has expired. Please try again.';
      case 'oath-token-revoked':
        return 'The OAuth token has been revoked. Please try again.';
      case 'invalid-oath-provider':
        return 'The OAuth provider is invalid. Please try again.';
      case 'oath-provider-disabled':
        return 'The OAuth provider is disabled. Please try again.';
      case 'invalid-oath-redirect-uri':
        return 'The OAuth redirect URI is invalid. Please try again.';
      case 'oath-redirect-uri-mismatch':
        return 'The OAuth redirect URI does not match the configured redirect URI. Please try again.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please try again.';
      case 'action-code-expired':
        return 'The action code has expired. Please try again.';
      case 'action-code-mismatch':
        return 'The action code does not match the expected action. Please try again.';
      case 'invalid-account-info':
        return 'The account information is invalid. Please try again.';
      case 'account-info-expired':
        return 'The account information has expired. Please try again.';
      case 'account-info-revoked':
        return 'The account information has been revoked. Please try again.';
      default:
        return 'An unexpected error occurred. Error code: $code';

    }
  }
}