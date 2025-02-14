import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/validators/validator.dart';
import '../../../product/values/colors/app_colors.dart';
import '../../../product/values/localkeys/app_localkeys.dart';
import '../../../product/values/paths/app_paths.dart';
import '../../../product/widgets/buttons/primary_button_widget.dart';
import '../models/address_model.dart';
import '../services/profile_service.dart';
import 'addresses_view.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({
    super.key,
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
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  @override
  void initState() {
    super.initState();

    titleController.text = widget.title ?? '';
    nameController.text = widget.name ?? '';
    phoneController.text = widget.phone ?? '';
    streetController.text = widget.streetDetails ?? '';
    zipcodeController.text = widget.zipcode ?? '';
    stateController.text = widget.state ?? '';
    cityController.text = widget.city ?? '';
    isDefault = widget.isDefault ?? false;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isDefault = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              AppTextFormField(
                validator: Validator.stringInput,
                controller: titleController,
                labelText: AppLocalkeys.addressTitle,
                keyboardType: TextInputType.name,
              ),
              AppTextFormField(
                validator: Validator.stringInput,
                controller: nameController,
                labelText: AppLocalkeys.name,
                keyboardType: TextInputType.name,
              ),
              AppTextFormField(
                validator: (value) => Validator.phone(value),
                keyboardType: TextInputType.phone,
                controller: phoneController,
                labelText: AppLocalkeys.mobileNumber,
              ),
              AppTextFormField(
                validator: (value) => Validator.stringInput(value),
                keyboardType: TextInputType.streetAddress,
                controller: streetController,
                maxLines: 2,
                labelText: AppLocalkeys.streetDetail,
              ),
              AppTextFormField(
                validator: (value) => Validator.zipCode(value),
                keyboardType: TextInputType.number,
                controller: zipcodeController,
                labelText: AppLocalkeys.zipcode,
              ),
              AppTextFormField(
                validator: (value) => Validator.stringInput(value),
                keyboardType: TextInputType.text,
                controller: stateController,
                labelText: AppLocalkeys.state,
              ),
              AppTextFormField(
                validator: (value) => Validator.stringInput(value),
                keyboardType: TextInputType.text,
                controller: cityController,
                labelText: AppLocalkeys.cityDistrict,
              ),
              CheckboxListTile(
                enabled: !(widget.isDefault ?? false),
                value: isDefault,
                onChanged: (value) {
                  setState(() {
                    isDefault = value!;
                  });
                },
                title: const Text('Set as default address'),
              ),
              PrimaryButtonWidget(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final title = titleController.text.trim();
                    final name = nameController.text.trim();
                    final phone = phoneController.text.trim();
                    final streetDetail = streetController.text.trim();
                    final zipcode = zipcodeController.text.trim();
                    final state = stateController.text.trim();
                    final city = cityController.text.trim();

                    final address = AddressModel(
                      id: widget.id,
                      userFK: widget.userFK,
                      title: title,
                      name: name,
                      phoneNumber: phone,
                      streetDetails: streetDetail,
                      zipcode: zipcode,
                      state: state,
                      city: city,
                      isDefault: isDefault,
                    );

                    try {
                      if (widget.edit) {
                        await ProfileService().updateAddress(address);
                      } else {
                        await ProfileService().addAddress(address);
                      }

                      if (!context.mounted) return;

                      Navigator.pop(context);

                      showModalBottomSheet(
                        context: AddressesView.scaffoldState.currentContext!,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(24),
                          width: double.maxFinite,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 24,
                            children: [
                              Image.asset(AppPaths.check),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.edit
                                        ? 'Address updated\nsuccessfully!'
                                        : 'Address added\nsuccessfully!',
                                    textAlign: TextAlign.center,
                                    style: BaseTextStyle.headlineSmall(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.background,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Done',
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                text: AppLocalkeys.saveAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.validator,
    required this.controller,
    this.keyboardType,
    required this.labelText,
    this.maxLines,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        labelStyle: BaseTextStyle.bodyMedium(),
        labelText: labelText,
      ),
    );
  }
}
