import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    super.key,
    required this.list,
    required this.text,
    required this.selectedFilter,
    this.onSelect,
  });

  final String text;
  final List<String> list;
  final String selectedFilter;
  final Function(String?)? onSelect;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
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
      child: Wrap(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                    style: BaseTextStyle.headlineSmall(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => context.router.pop(),
                  ),
                ],
              ),
              ...widget.list.map(
                (filter) => ListTile(
                  selected: filter.contains(widget.selectedFilter),
                  title: Text(filter),
                  onTap: () {
                    if (widget.onSelect != null) {
                      widget.onSelect!(filter);
                    }
                    context.router.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
