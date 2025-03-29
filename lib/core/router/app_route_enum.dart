enum AppRoute {
  splash,
  forgotPassword,
  authHome,
  interest,
  home,
  productDetails,
  writeReview,
  addAddresses,
  addresses,
  editProfile,
  myProfile,
}

extension AppRouteExt on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.forgotPassword:
        return '/${AppRoute.forgotPassword.name}';
      case AppRoute.authHome:
        return '/${AppRoute.authHome.name}';
      case AppRoute.interest:
        return '/${AppRoute.interest.name}';
      case AppRoute.home:
        return '/${AppRoute.home.name}';
      case AppRoute.productDetails:
        return '/${AppRoute.productDetails.name}';
      case AppRoute.writeReview:
        return '/${AppRoute.writeReview.name}';
      case AppRoute.addAddresses:
        return '/${AppRoute.addAddresses.name}';
      case AppRoute.addresses:
        return '/${AppRoute.addresses.name}';
      case AppRoute.editProfile:
        return '/${AppRoute.editProfile.name}';
      case AppRoute.myProfile:
        return '/${AppRoute.myProfile.name}';
    }
  }
}
