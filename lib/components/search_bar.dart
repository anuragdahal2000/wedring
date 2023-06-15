import 'package:flutter/material.dart';
import 'package:wedring/components/custom_textfield.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;

  const CustomSearchBar({super.key, required this.hintText, this.onChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      controller: _searchController,
      prefixIcon: const Icon(Icons.search),
      onChanged: (value) => widget.onChanged!(value),
    );
  }
}
