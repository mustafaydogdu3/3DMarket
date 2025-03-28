import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/router/app_route_enum.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../core/values/paths/app_paths.dart';
import '../../../core/widgets/buttons/bordered_button_widget.dart';
import '../models/address_model.dart';
import '../services/profile_service.dart';

@RoutePage()
class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  static final GlobalKey<ScaffoldState> scaffoldState =
      GlobalKey<ScaffoldState>();

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AddressesView.scaffoldState,
      appBar: AppBar(
        title: const Text('Addresses'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BorderedButtonWidget(
              onPressed: () =>
                  context.router.pushPath(AppRoute.addAddresses.path).then(
                        (_) => setState(() {}),
                      ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(
                    width: 8,
                  ),
                  Text('New Address'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ProfileService.instance.getAddresses(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const SizedBox();

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:
              final defaultAddress = snapshot.data?.singleWhere(
                (element) => element.isDefault,
                orElse: () => AddressModel.empty(),
              );

              final addresses = snapshot.data
                  ?.where(
                    (element) => !element.isDefault,
                  )
                  .toList();

              final emptyAddress = AddressModel.empty();

              return Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    defaultAddress != null && defaultAddress != emptyAddress
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Default Address',
                                style: BaseTextStyle.titleMedium(),
                              ),
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
                                title: Text(defaultAddress.name ?? ''),
                                subtitle: Text(
                                    '${defaultAddress.streetDetails}, ${defaultAddress.city}'),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () => context.router
                                        .push(
                                          AddAddressesRoute(
                                            id: defaultAddress.id,
                                            userFK: defaultAddress.userFK,
                                            title: defaultAddress.title,
                                            name: defaultAddress.name,
                                            phone: defaultAddress.phoneNumber,
                                            streetDetails:
                                                defaultAddress.streetDetails,
                                            zipcode: defaultAddress.zipcode,
                                            state: defaultAddress.state,
                                            city: defaultAddress.city,
                                            isDefault: defaultAddress.isDefault,
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
                                          color: Colors.blueAccent,
                                        ),
                                        Text(
                                          'Edit',
                                          style: BaseTextStyle.labelLarge(
                                            color: Colors.blueAccent,
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
                                          FontAwesome.trash_can_solid,
                                          size: 14,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          'Remove',
                                          style: BaseTextStyle.labelLarge(
                                            color: Colors.redAccent,
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
                                    style: BaseTextStyle.titleSmall(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Other Addresses',
                            style: BaseTextStyle.titleMedium(),
                          ),
                          addresses != null && addresses.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      'No Have Any Other Addresses...',
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: addresses?.length,
                                    itemBuilder: (context, index) {
                                      final address = addresses?[index];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              top: 16,
                                            ),
                                            child: Text(
                                              address?.title ?? '',
                                              style: BaseTextStyle.bodyLarge(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(address?.name ?? ''),
                                            subtitle: Text(
                                                '${address?.streetDetails}, ${address?.city}'),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                onPressed: () => context.router
                                                    .push(
                                                      AddAddressesRoute(
                                                        id: address?.id,
                                                        userFK: address?.userFK,
                                                        title: address?.title,
                                                        name: address?.name,
                                                        phone: address
                                                            ?.phoneNumber,
                                                        streetDetails: address
                                                            ?.streetDetails,
                                                        zipcode:
                                                            address?.zipcode,
                                                        state: address?.state,
                                                        city: address?.city,
                                                        isDefault:
                                                            address?.isDefault,
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
                                                      color: Colors.blueAccent,
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
                                                onPressed: address != null
                                                    ? () async =>
                                                        ProfileService.instance
                                                            .removeAddress(
                                                              address,
                                                            )
                                                            .then(
                                                              (_) => setState(
                                                                () {},
                                                              ),
                                                            )
                                                    : null,
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
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: address != null
                                                    ? () async => ProfileService
                                                        .instance
                                                        .setAsDefaultAddress(
                                                          address,
                                                        )
                                                        .then(
                                                          (_) => setState(
                                                            () {},
                                                          ),
                                                        )
                                                    : null,
                                                child: Row(
                                                  spacing: 8,
                                                  children: [
                                                    const Icon(
                                                      FontAwesome.map_pin_solid,
                                                      size: 14,
                                                      color: Colors.lightBlue,
                                                    ),
                                                    Text(
                                                      'Set As Default',
                                                      style: BaseTextStyle
                                                          .labelLarge(
                                                        color: Colors.lightBlue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
