import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/router/app_route_enum.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../core/values/localkeys/app_localkeys.dart';
import '../../../core/values/paths/app_paths.dart';
import '../services/profile_service.dart';
import 'widgets/profile_fields_widget.dart';

@RoutePage()
class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProfileService.instance.getUserProfile(),
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return PopScope(
              canPop: false,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(AppLocalkeys.myProfile),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            final user = snap.data;

            return Scaffold(
              appBar: AppBar(
                title: const Text(AppLocalkeys.myProfile),
                actions: [
                  ElevatedButton(
                    onPressed: () => context.router
                        .push(
                          EditProfileRoute(
                            email: user?.email ?? '',
                            gender: user?.gender ?? '',
                            name: user?.name ?? '',
                            phone: user?.phoneNumber ?? '',
                          ),
                        )
                        .then(
                          (_) => setState(() {}),
                        ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                    ),
                    child: Row(
                      spacing: 12,
                      children: [
                        const Icon(
                          FontAwesome.user_pen_solid,
                          color: Colors.blueAccent,
                          size: 14,
                        ),
                        Text(
                          'Edit Profile',
                          style: BaseTextStyle.labelLarge(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: user?.photoUrl != null
                              ? Image.network(user!.photoUrl!)
                              : Image.asset('assets/images/png/profil.png'),
                        ),
                      ),
                    ),
                    ProfileFieldsWidget(
                      title: 'Name:',
                      name: user?.name ?? '',
                    ),
                    ProfileFieldsWidget(
                      title: 'Email:',
                      name: user?.email ?? '',
                    ),
                    ProfileFieldsWidget(
                      title: 'Phone:',
                      name: user?.phoneNumber ?? '',
                    ),
                    ProfileFieldsWidget(
                      title: 'Gender:',
                      name: user?.gender ?? '',
                    ),
                    FutureBuilder(
                      future: ProfileService.instance.getDefaultAddress(),
                      builder: (context, snap) {
                        switch (snap.connectionState) {
                          case ConnectionState.none:
                            return const SizedBox();

                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );

                          case ConnectionState.active:
                          case ConnectionState.done:
                            final defaultAddress = snap.data;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Default Address:',
                                        style: BaseTextStyle.bodyMedium(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => context.router
                                          .pushPath(AppRoute.addresses.path)
                                          .then(
                                            (_) => setState(() {}),
                                          ),
                                      child: Row(
                                        spacing: 8,
                                        children: [
                                          const Icon(
                                            FontAwesome.map_location_dot_solid,
                                            color: Colors.blueAccent,
                                          ),
                                          Text(
                                            'My Addresses',
                                            style: BaseTextStyle.labelLarge(
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Card(
                                  child: defaultAddress != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                top: 16,
                                              ),
                                              child: Text(
                                                defaultAddress.title ?? '',
                                                style: BaseTextStyle.bodyLarge(
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                  defaultAddress.name ?? ''),
                                              subtitle: Text(
                                                  '${defaultAddress.streetDetails}, ${defaultAddress.city}'),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextButton(
                                                  onPressed: () => context
                                                      .router
                                                      .push(
                                                        AddAddressesRoute(
                                                          id: defaultAddress.id,
                                                          userFK: defaultAddress
                                                              .userFK,
                                                          title: defaultAddress
                                                              .title,
                                                          name: defaultAddress
                                                              .name,
                                                          phone: defaultAddress
                                                              .phoneNumber,
                                                          streetDetails:
                                                              defaultAddress
                                                                  .streetDetails,
                                                          zipcode:
                                                              defaultAddress
                                                                  .zipcode,
                                                          state: defaultAddress
                                                              .state,
                                                          city: defaultAddress
                                                              .city,
                                                          isDefault:
                                                              defaultAddress
                                                                  .isDefault,
                                                          edit: true,
                                                        ),
                                                      )
                                                      .then(
                                                        (_) => setState(() {}),
                                                      ),
                                                  child: Row(
                                                    spacing: 8,
                                                    children: [
                                                      const Icon(
                                                        FontAwesome.pen_solid,
                                                        size: 14,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      Text(
                                                        'Edit',
                                                        style: BaseTextStyle
                                                            .labelLarge(
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async =>
                                                      ProfileService.instance
                                                          .removeAddress(
                                                            defaultAddress,
                                                          )
                                                          .then(
                                                            (_) => setState(
                                                              () {},
                                                            ),
                                                          ),
                                                  child: Row(
                                                    spacing: 8,
                                                    children: [
                                                      const Icon(
                                                        FontAwesome
                                                            .trash_can_solid,
                                                        size: 14,
                                                        color: Colors.redAccent,
                                                      ),
                                                      Text(
                                                        'Remove',
                                                        style: BaseTextStyle
                                                            .labelLarge(
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              spacing: 12,
                                              children: [
                                                SvgPicture.asset(
                                                  AppPaths.addressNotFound,
                                                  height: 100,
                                                ),
                                                Text(
                                                  'Default Address Not Found! Please Add Address.',
                                                  style:
                                                      BaseTextStyle.titleSmall(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    context.router
                                                        .pushPath(AppRoute
                                                            .addAddresses.path)
                                                        .then(
                                                          (_) =>
                                                              setState(() {}),
                                                        );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    side: const BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.5,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 22,
                                                      vertical: 10,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    spacing: 4,
                                                    children: [
                                                      const Icon(
                                                        FontAwesome
                                                            .location_dot_solid,
                                                        size: 14,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      Text(
                                                        'Add Address',
                                                        style: BaseTextStyle
                                                            .labelLarge(
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            );
                        }
                      },
                    )
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
