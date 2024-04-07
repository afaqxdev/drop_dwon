import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomDropdownButton extends StatefulWidget {
  final String hint;

  final List<String> items;
  final String? dropvalue;
  final ValueChanged<String?>? onChanged;
  Color? backgroundColor;
  Color? color;
  double? size;
  final double iconsizes;
  FontWeight? fontWeight;
  final double? width;
  final double? height;

  CustomDropdownButton({
    super.key,
    required this.hint,
    this.color,
    required this.items,
    required this.onChanged,
    this.dropvalue,
    required this.iconsizes,
    this.backgroundColor = Colors.white,
    this.size = 16,
    this.width,
    this.fontWeight = FontWeight.w600,
    this.height,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.backgroundColor,
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            menuMaxHeight: 200,
            value: widget.dropvalue,
            focusColor: widget.backgroundColor,
            dropdownColor: Colors.white,
            iconEnabledColor: widget.color,
            iconDisabledColor: widget.color,
            isExpanded: true,
            isDense: true,
            borderRadius: BorderRadius.circular(10.r),
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat'),
            iconSize: widget.iconsizes,
            hint: Text(
              widget.hint,
              style: TextStyle(
                  color: widget.color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat'),
            ),
            onChanged: widget.onChanged,
            items: widget.items
                .toSet()
                .toList()
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ModelDropDown<T> extends StatefulWidget {
  const ModelDropDown({
    super.key,
    required this.hint,
    this.color,
    required this.items,
    required this.onChanged,
    required this.iconsizes,
    this.backgroundColor = Colors.white,
    this.size = 16,
    this.width,
    this.fontWeight = FontWeight.w600,
    this.onTap,
    this.height,
    this.selectedValue,
  });

  final String hint;
  final T? selectedValue;
  final void Function()? onTap;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Color? backgroundColor;
  final Color? color;
  final double? size;
  final double iconsizes;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;

  @override
  State<ModelDropDown<T>> createState() => _ModelDropDownState<T>();
}

class _ModelDropDownState<T> extends State<ModelDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: widget.backgroundColor,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurStyle: BlurStyle.outer, blurRadius: 1)
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          menuMaxHeight: 200,
          value: widget.selectedValue,
          focusColor: widget.backgroundColor,
          dropdownColor: Colors.white,
          iconEnabledColor: widget.color,
          iconDisabledColor: widget.color,
          isExpanded: true,
          isDense: true,
          borderRadius: BorderRadius.circular(10),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
          iconSize: widget.iconsizes,
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: widget.color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
          ),
          onChanged: widget.onChanged,
          items: widget.items,
        ),
      ),
    );
  }
}
