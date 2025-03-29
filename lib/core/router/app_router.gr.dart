// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:market3d/features/auth/views/forgot_password/forgot_password_view.dart'
    as _i5;
import 'package:market3d/features/auth/views/home/auth_home_view.dart' as _i3;
import 'package:market3d/features/auth/views/instrest/interest_view.dart'
    as _i7;
import 'package:market3d/features/home/models/product_model.dart' as _i14;
import 'package:market3d/features/home/views/home_nav/home_nav_view.dart'
    as _i6;
import 'package:market3d/features/home/views/product/views/product_details_view.dart'
    as _i9;
import 'package:market3d/features/home/views/product/views/write_review_view.dart'
    as _i11;
import 'package:market3d/features/profile/views/add_addresses_view.dart' as _i1;
import 'package:market3d/features/profile/views/addresses_view.dart' as _i2;
import 'package:market3d/features/profile/views/edit_profile_view.dart' as _i4;
import 'package:market3d/features/profile/views/my_profile_view.dart' as _i8;
import 'package:market3d/features/splash/splash_view.dart' as _i10;

/// generated route for
/// [_i1.AddAddressesView]
class AddAddressesRoute extends _i12.PageRouteInfo<AddAddressesRouteArgs> {
  AddAddressesRoute({
    _i13.Key? key,
    String? id,
    String? userFK,
    String? title,
    String? name,
    String? phone,
    String? streetDetails,
    String? zipcode,
    String? state,
    String? city,
    bool? isDefault,
    bool edit = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         AddAddressesRoute.name,
         args: AddAddressesRouteArgs(
           key: key,
           id: id,
           userFK: userFK,
           title: title,
           name: name,
           phone: phone,
           streetDetails: streetDetails,
           zipcode: zipcode,
           state: state,
           city: city,
           isDefault: isDefault,
           edit: edit,
         ),
         initialChildren: children,
       );

  static const String name = 'AddAddressesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddAddressesRouteArgs>(
        orElse: () => const AddAddressesRouteArgs(),
      );
      return _i1.AddAddressesView(
        key: args.key,
        id: args.id,
        userFK: args.userFK,
        title: args.title,
        name: args.name,
        phone: args.phone,
        streetDetails: args.streetDetails,
        zipcode: args.zipcode,
        state: args.state,
        city: args.city,
        isDefault: args.isDefault,
        edit: args.edit,
      );
    },
  );
}

class AddAddressesRouteArgs {
  const AddAddressesRouteArgs({
    this.key,
    this.id,
    this.userFK,
    this.title,
    this.name,
    this.phone,
    this.streetDetails,
    this.zipcode,
    this.state,
    this.city,
    this.isDefault,
    this.edit = false,
  });

  final _i13.Key? key;

  final String? id;

  final String? userFK;

  final String? title;

  final String? name;

  final String? phone;

  final String? streetDetails;

  final String? zipcode;

  final String? state;

  final String? city;

  final bool? isDefault;

  final bool edit;

  @override
  String toString() {
    return 'AddAddressesRouteArgs{key: $key, id: $id, userFK: $userFK, title: $title, name: $name, phone: $phone, streetDetails: $streetDetails, zipcode: $zipcode, state: $state, city: $city, isDefault: $isDefault, edit: $edit}';
  }
}

/// generated route for
/// [_i2.AddressesView]
class AddressesRoute extends _i12.PageRouteInfo<void> {
  const AddressesRoute({List<_i12.PageRouteInfo>? children})
    : super(AddressesRoute.name, initialChildren: children);

  static const String name = 'AddressesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddressesView();
    },
  );
}

/// generated route for
/// [_i3.AuthHomeView]
class AuthHomeRoute extends _i12.PageRouteInfo<void> {
  const AuthHomeRoute({List<_i12.PageRouteInfo>? children})
    : super(AuthHomeRoute.name, initialChildren: children);

  static const String name = 'AuthHomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthHomeView();
    },
  );
}

/// generated route for
/// [_i4.EditProfileView]
class EditProfileRoute extends _i12.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i13.Key? key,
    required String name,
    required String email,
    required String phone,
    required String gender,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(
           key: key,
           name: name,
           email: email,
           phone: phone,
           gender: gender,
         ),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i4.EditProfileView(
        key: args.key,
        name: args.name,
        email: args.email,
        phone: args.phone,
        gender: args.gender,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  final _i13.Key? key;

  final String name;

  final String email;

  final String phone;

  final String gender;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, name: $name, email: $email, phone: $phone, gender: $gender}';
  }
}

/// generated route for
/// [_i5.ForgotPasswordView]
class ForgotPasswordRoute extends _i12.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i12.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordView();
    },
  );
}

/// generated route for
/// [_i6.HomeNavView]
class HomeNavRoute extends _i12.PageRouteInfo<void> {
  const HomeNavRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeNavRoute.name, initialChildren: children);

  static const String name = 'HomeNavRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeNavView();
    },
  );
}

/// generated route for
/// [_i7.InterestView]
class InterestRoute extends _i12.PageRouteInfo<void> {
  const InterestRoute({List<_i12.PageRouteInfo>? children})
    : super(InterestRoute.name, initialChildren: children);

  static const String name = 'InterestRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.InterestView();
    },
  );
}

/// generated route for
/// [_i8.MyProfileView]
class MyProfileRoute extends _i12.PageRouteInfo<void> {
  const MyProfileRoute({List<_i12.PageRouteInfo>? children})
    : super(MyProfileRoute.name, initialChildren: children);

  static const String name = 'MyProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.MyProfileView();
    },
  );
}

/// generated route for
/// [_i9.ProductDetailsView]
class ProductDetailsRoute extends _i12.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i13.Key? key,
    required _i14.ProductModel product,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ProductDetailsRoute.name,
         args: ProductDetailsRouteArgs(key: key, product: product),
         initialChildren: children,
       );

  static const String name = 'ProductDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i9.ProductDetailsView(key: args.key, product: args.product);
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.product});

  final _i13.Key? key;

  final _i14.ProductModel product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i10.SplashView]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashView();
    },
  );
}

/// generated route for
/// [_i11.WriteReviewView]
class WriteReviewRoute extends _i12.PageRouteInfo<WriteReviewRouteArgs> {
  WriteReviewRoute({
    _i13.Key? key,
    required _i14.ProductModel product,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         WriteReviewRoute.name,
         args: WriteReviewRouteArgs(key: key, product: product),
         initialChildren: children,
       );

  static const String name = 'WriteReviewRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WriteReviewRouteArgs>();
      return _i11.WriteReviewView(key: args.key, product: args.product);
    },
  );
}

class WriteReviewRouteArgs {
  const WriteReviewRouteArgs({this.key, required this.product});

  final _i13.Key? key;

  final _i14.ProductModel product;

  @override
  String toString() {
    return 'WriteReviewRouteArgs{key: $key, product: $product}';
  }
}
