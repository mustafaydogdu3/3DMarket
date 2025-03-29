import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/validators/validator.dart';
import '../../../core/values/localkeys/app_localkeys.dart';
import '../../../core/widgets/buttons/primary_button_widget.dart';
import '../../../core/widgets/done_show_modal.dart';
import '../../../core/widgets/textfields/text_form_field_widget.dart';
import '../models/address_model.dart';
import '../services/profile_service.dart';

@RoutePage()
class AddAddressesView extends StatefulWidget {
  const AddAddressesView({
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
  State<AddAddressesView> createState() => _AddAddressesViewState();
}

class _AddAddressesViewState extends State<AddAddressesView> {
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
              TextFormFieldWidget(
                validator: Validator.stringInput,
                controller: titleController,
                labelText: AppLocalkeys.addressTitle,
                keyboardType: TextInputType.name,
              ),
              TextFormFieldWidget(
                validator: Validator.stringInput,
                controller: nameController,
                labelText: AppLocalkeys.name,
                keyboardType: TextInputType.name,
              ),
              TextFormFieldWidget(
                validator: (value) => Validator.phone(value),
                keyboardType: TextInputType.phone,
                controller: phoneController,
                labelText: AppLocalkeys.mobileNumber,
              ),
              TextFormFieldWidget(
                validator: (value) => Validator.stringInput(value),
                keyboardType: TextInputType.streetAddress,
                controller: streetController,
                maxLines: 2,
                labelText: AppLocalkeys.streetDetail,
              ),
              TextFormFieldWidget(
                validator: (value) => Validator.zipCode(value),
                keyboardType: TextInputType.number,
                controller: zipcodeController,
                labelText: AppLocalkeys.zipcode,
              ),
              TextFormFieldWidget(
                validator: (value) => Validator.stringInput(value),
                keyboardType: TextInputType.text,
                controller: stateController,
                labelText: AppLocalkeys.state,
              ),
              TextFormFieldWidget(
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
                        await ProfileService.instance.updateAddress(address);
                      } else {
                        await ProfileService.instance.addAddress(address);
                      }

                      if (!context.mounted) return;

                      context.router.pop();

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => DoneShowModal(
                          title: widget.edit
                              ? 'Address Updated Successfully'
                              : 'Address Added Successfully',
                          confirmButtonText: 'Done',
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
