import 'package:flutter/material.dart';

import '../../widgets/filter_widget.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({
    super.key,
    required this.selectedFilter,
    required this.onSelect,
  });

  final String selectedFilter;
  final Function(String? selectedFilter)? onSelect;

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
    return FilterWidget(
      list: filterList,
      text: text,
      selectedFilter: widget.selectedFilter,
      onSelect: widget.onSelect,
    );
  }
}
