import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../home/views/home_nav_view.dart';
import '../../../models/interest_model.dart';
import '../../../services/interest_service.dart';

class InterestView extends StatefulWidget {
  const InterestView({super.key});

  @override
  State<InterestView> createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  final InterestService _interestService = InterestService();
  List<InterestModel> interests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInterests();
  }

  Future<void> _loadInterests() async {
    try {
      final loadedInterests = await _interestService.getInterests();

      setState(() {
        interests = loadedInterests;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load interests')),
        );
      }
    }
  }

  Future<void> _saveInterests() async {
    try {
      final selectedInterests =
          interests.where((interest) => interest.isSelected).toList();
      await _interestService.saveUserInterests(selectedInterests);

      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeNavView()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save interests')),
      );
    }
  }

  void _toggleInterest(int index) {
    if (index < 0 || index >= interests.length) return;
    setState(() {
      interests[index].isSelected = !interests[index].isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                'Choose Your\nInterests',
                style: BaseTextStyle.headlineLarge(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: interests.length,
                    itemBuilder: (context, index) {
                      final interest = interests[index];
                      return GestureDetector(
                        onTap: () => _toggleInterest(index),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        interest.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[100],
                                            child: const Icon(Icons.error,
                                                color: Colors.grey),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  if (interest.isSelected)
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Colors.black.withValues(alpha: 0.4),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              interest.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: interest.isSelected
                                    ? Colors.blue
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: interests.any((interest) => interest.isSelected)
                      ? _saveInterests
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              interests.any((interest) => interest.isSelected)
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: interests.any((interest) => interest.isSelected)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
