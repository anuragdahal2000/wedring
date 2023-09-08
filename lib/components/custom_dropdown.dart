import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<T> optionList;
  final T selectedOption;
  final String? helperText;
  final void Function(T?)? onChanged;

  const CustomDropDown({
    super.key,
    required this.optionList,
    required this.selectedOption,
    this.helperText,
    this.onChanged,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.helperText != null
            ? Text(
                widget.helperText!,
                style: kRegular14,
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: kTeritary1,
            ),
          ),
          child: DropdownButton<T>(
            elevation: 12,
            isExpanded: true,
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            underline: const SizedBox.shrink(),
            value: widget.selectedOption,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: kRegular14.copyWith(
              color: kTeritary1,
            ),
            onChanged: widget.onChanged,
            items: [
              DropdownMenuItem<T>(
                  value: null,
                  child: Text(
                    'Select ${widget.helperText}',
                  )),
              ...widget.optionList.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      value.toString(),
                    ));
              }).toList()
            ],
          ),
        ),
      ],
    );
  }
}
