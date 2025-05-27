import 'package:flutter/material.dart';

import '../../widgets/filter_widget.dart';

class SortbyModal extends StatefulWidget {
  const SortbyModal({
    super.key,
  });

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
  final String text = 'Rating & Reviews';

  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      list: sortByList,
      selectedFilter: '',
      text: text,
    );
  }
}
