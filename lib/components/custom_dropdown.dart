import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> optionList;
  final dynamic selectedOption;

  const CustomDropDown(
      {super.key, required this.optionList, required this.selectedOption});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  dynamic _value;
  @override
  void initState() {
    super.initState();
    _value = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: kTeritary1,
        ),
      ),
      child: DropdownButton<String>(
        elevation: 12,
        isExpanded: true,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        underline: const SizedBox.shrink(),
        value: _value,
        icon: const Icon(Icons.keyboard_arrow_down),
        style: kRegular14.copyWith(
          color: kTeritary1,
        ),
        onChanged: (String? value) {
          setState(() {
            _value = value!;
          });
        },
        items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
