// ignore_for_file: constant_identifier_names

abstract class Routes {
  // Root
  static const HOME = '/';

  // Authentication
  static const LOGIN = '/login';
  static const PW_LOGIN = '/PWLogin';
  static const PIN = '/pin';
  static const ONBOARDING = '/onboarding';
  static const MANUAL = '/manual';

  // Main features
  static const PAYMENT = '/payment';
  static const REGISTER_CARD = '/payment/registerCard';
  static const EDIT_CARD = '/payment/editCard';
  static const TRANSACTION = '/transaction';
  static const TRANSACTION_DETAIL = '/transaction/detail';

  // Settings and Info
  static const INFO = '/info';
  static const THEME_SELECT = '/info/themeSelect';
  static const FACESIGN = '/info/facesign';
  static const VERSION = '/info/version';
  static const LICENSE = '/info/version/license';
  static const TERMS_OF_SERVICE = '/info/version/termsOfService';
  static const PRIVACY_POLICY = '/info/version/privacyPolicy';

  // Admin
  static const ADMIN = '/admin';
  static const GENERATE_COUPON = '/admin/generate_coupon';
  static const COUPON = '/admin/generate_coupon/coupon';
  static const GENERATE_PASSCODE = '/admin/generate_passcode';
  static const PASSCODE = '/admin/generate_passcode/passcode';
  static const RESET_PIN = '/reset_pin';
  static const SYNC_PRODUCT = '/sync_product';

  // Miscellaneous
  static const TEST = '/test';
}
