import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../../product/values/paths/app_paths.dart';
import '../../../product/widgets/drawers/app_drawer.dart';
import '../services/profile_service.dart';
import 'add_addresses_view.dart';
import 'addresses_view.dart';
import 'edit_profile_view.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProfileService().getUserProfile(),
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return PopScope(
              canPop: false,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(AppLocalkeys.editProfil),
                ),
                drawer: const AppDrawer(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            email = snap.data?.email ?? '';
            name = snap.data?.name ?? '';
            phone = snap.data?.phoneNumber ?? '';
            address = snap.data?.address ?? '';
            gender = snap.data?.gender ?? '';

            return Scaffold(
              appBar: AppBar(
                title: const Text(AppLocalkeys.editProfil),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(
                          address: address,
                          email: email,
                          gender: gender,
                          name: name,
                          phone: phone,
                        ),
                      ),
                    ).then(
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
              drawer: const AppDrawer(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        child: Image.asset('assets/images/png/profil.png'),
                      ),
                    ),
                    ProfileFieldsWidget(title: 'Name:', name: name),
                    ProfileFieldsWidget(title: 'Email:', name: email),
                    ProfileFieldsWidget(title: 'Phone:', name: phone),
                    ProfileFieldsWidget(title: 'Address:', name: address),
                    ProfileFieldsWidget(title: 'Gender:', name: gender),
                    FutureBuilder(
                      future: ProfileService().getDefaultAddress(),
                      builder: (context, snap) {
                        switch (snap.connectionState) {
                          case ConnectionState.none:
                            return const SizedBox();

                          case ConnectionState.waiting:
                            return PopScope(
                              canPop: false,
                              child: Scaffold(
                                appBar: AppBar(
                                  title: const Text(AppLocalkeys.editProfil),
                                ),
                                drawer: const AppDrawer(),
                                body: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
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
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddressesView(),
                                        ),
                                      ).then(
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
                                                  onPressed: () =>
                                                      Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddAddressView(
                                                        id: defaultAddress.id,
                                                        userFK: defaultAddress
                                                            .userFK,
                                                        title: defaultAddress
                                                            .title,
                                                        name:
                                                            defaultAddress.name,
                                                        phone: defaultAddress
                                                            .phoneNumber,
                                                        streetDetails:
                                                            defaultAddress
                                                                .streetDetails,
                                                        zipcode: defaultAddress
                                                            .zipcode,
                                                        state: defaultAddress
                                                            .state,
                                                        city:
                                                            defaultAddress.city,
                                                        isDefault:
                                                            defaultAddress
                                                                .isDefault,
                                                        edit: true,
                                                      ),
                                                    ),
                                                  ).then(
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
                                                      ProfileService()
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
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddAddressView(),
                                                      ),
                                                    ).then(
                                                      (_) => setState(() {}),
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

class ProfileFieldsWidget extends StatelessWidget {
  const ProfileFieldsWidget({
    super.key,
    required this.title,
    required this.name,
  });

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BaseTextStyle.labelSmall(),
            ),
            Text(
              name,
              style: BaseTextStyle.bodyLarge(),
            ),
          ],
        ),
      ),
    );
  }
}
