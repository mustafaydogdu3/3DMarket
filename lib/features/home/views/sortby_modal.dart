import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class SortbyModal extends StatefulWidget {
  const SortbyModal({super.key});

  @override
  State<SortbyModal> createState() => _SortbyModalState();
}

class _SortbyModalState extends State<SortbyModal> {
  List<String> sortByList = [
    'Most Helpful',
    'Most Useful',
    'Highest Rating',
    'Lowest Rating',
    'Recent'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort By',
                style: BaseTextStyle.headlineSmall(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          ...sortByList.map(
            (sortBy) => ListTile(
              title: Text(sortBy),
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
