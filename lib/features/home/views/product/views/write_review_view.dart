import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/validators/validator.dart';
import '../../../../../core/widgets/buttons/primary_button_widget.dart';
import '../../../../../core/widgets/done_show_modal.dart';
import '../../../models/product_model.dart';
import '../../../models/review_model.dart';
import '../../../services/review_service.dart';

@RoutePage()
class WriteReviewView extends StatefulWidget {
  const WriteReviewView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  @override
  void dispose() {
    _headingController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  double _rating = 5;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final List<File> _images = [];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
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
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.product.imageUrls?.first ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.product.name ?? '',
                          maxLines: 2,
                          style: BaseTextStyle.bodyLarge(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xFFf59e0b),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                ],
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
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      RawMaterialButton(
                        onPressed: _pickImage,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(),
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
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.grey,
                              ),
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 88,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  top: 8,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _images[index],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: RawMaterialButton(
                                  onPressed: () => _removeImage(index),
                                  shape: const CircleBorder(),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: const CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.black54,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
        padding: const EdgeInsets.all(18.0),
        child: PrimaryButtonWidget(
          text: 'Submit Review',
          onPressed: () async {
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

              final review = ReviewModel(
                id: const Uuid().v4(),
                productFK: widget.product.id,
                heading: _headingController.text,
                review: _reviewController.text,
                rating: _rating,
              );

              final failureOrSuccess = await ReviewService.instance.addReview(
                review,
                _images,
              );
              if (!mounted) return;
              context.router.pop();

              if (failureOrSuccess.$1 != null) {
                final error = failureOrSuccess.$1;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) => const DoneShowModal(
                    title: 'Review Submitted Successfully',
                    confirmButtonText: 'Done',
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
