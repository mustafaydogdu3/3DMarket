import 'package:auto_route/auto_route.dart';

import 'app_route_enum.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: AppRoute.splash.path,
          page: SplashRoute.page,
        ),
        AutoRoute(
          path: AppRoute.forgotPassword.path,
          page: ForgotPasswordRoute.page,
        ),
        AutoRoute(
          path: AppRoute.authHome.path,
          page: AuthHomeRoute.page,
        ),
        AutoRoute(
          path: AppRoute.interest.path,
          page: InterestRoute.page,
        ),
        AutoRoute(
          path: AppRoute.home.path,
          page: HomeNavRoute.page,
        ),
        AutoRoute(
          path: AppRoute.productDetails.path,
          page: ProductDetailsRoute.page,
        ),
        AutoRoute(
          path: AppRoute.writeReview.path,
          page: WriteReviewRoute.page,
        ),
        AutoRoute(
          path: AppRoute.addAddresses.path,
          page: AddAddressesRoute.page,
        ),
        AutoRoute(
          path: AppRoute.addresses.path,
          page: AddressesRoute.page,
        ),
        AutoRoute(
          path: AppRoute.editProfile.path,
          page: EditProfileRoute.page,
        ),
        AutoRoute(
          path: AppRoute.myProfile.path,
          page: MyProfileRoute.page,
        ),
      ];
}
