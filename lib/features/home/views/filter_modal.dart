import 'package:flutter/material.dart';

import 'sortby_modal.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<String> filterList = [
    'All Star',
    '5 Star',
    '4 Star',
    '3 Star',
    '2 Star',
    '1 Star'
  ];
  final String text = 'Filter';

  @override
  Widget build(BuildContext context) {
    return SortByWidget(
      list: filterList,
      text: text,
    );
  }
}
