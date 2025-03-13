import 'dart:io';

import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../product/validators/validator.dart';
import '../../../product/widgets/buttons/primary_button_widget.dart';
import '../models/product_model.dart';

class WriteReviewPage extends StatefulWidget {
  final ProductModel product;

  const WriteReviewPage({
    super.key,
    required this.product,
  });

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _rating = 0;

  @override
  void dispose() {
    _headingController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Review'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 20,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.product.imageUrls?.first ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.product.name ?? '',
                      style: BaseTextStyle.bodyLarge(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _headingController,
                validator: Validator.stringInput,
                decoration: InputDecoration(
                  hintText: 'Heading of your review',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reviewController,
                validator: Validator.stringInput,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write Your Review',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (_image != null)
                    Stack(
                      children: [
                        Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _image = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, color: Colors.grey),
                          SizedBox(height: 4),
                          Text(
                            'Add Photo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButtonWidget(
          text: 'Submit Review',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const PopScope(
                  canPop: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
