import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';

sealed class CouponState {
  const CouponState();
}

final class CouponStateInitial extends CouponState {
  const CouponStateInitial();
}

final class CouponStateLoading extends CouponState {
  const CouponStateLoading();
}

final class CouponStateSuccess extends CouponState {
  const CouponStateSuccess({required this.value});
  final List<Coupon> value;
}

final class CouponStateFailed extends CouponState {
  const CouponStateFailed({required this.exception});
  final Exception exception;
}

sealed class CouponTypesState {
  const CouponTypesState();
}

final class CouponTypesStateInitial extends CouponTypesState {
  const CouponTypesStateInitial();
}

final class CouponTypesStateLoading extends CouponTypesState {
  const CouponTypesStateLoading();
}

final class CouponTypesStateSuccess extends CouponTypesState {
  const CouponTypesStateSuccess({required this.value});
  final List<CouponType> value;
}

final class CouponTypesStateFailed extends CouponTypesState {
  const CouponTypesStateFailed({required this.exception});
  final Exception exception;
}
