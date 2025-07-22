import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:ibie/utils/form_decoration.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String label;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.validator,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool dropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 365,
      child: DropdownButtonFormField2<T>(
        value: widget.value,
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: decorationForm(widget.label),
        style: const TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 20,
          color: Color(0xFF767474),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400,
          width: 365,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 6,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        iconStyleData: IconStyleData(
          icon: dropdownOpened
              ? SvgPicture.asset('assets/arrowUpIcon.svg', width: 10, height: 10)
              : SvgPicture.asset('assets/arrowDownIcon.svg', width: 10, height: 10),
          iconDisabledColor: Colors.grey,
          iconEnabledColor: Colors.black,
        ),
        onMenuStateChange: (bool isOpen) {
          setState(() {
            dropdownOpened = isOpen;
          });
        },
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(item.toString()),
            ),
          );
        }).toList(),
      ),
    );
  }
}