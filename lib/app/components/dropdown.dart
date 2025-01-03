import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';

const OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: ENABLED_BORDER_COLOR),
);
const OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: FOCUSED_BORDER_COLOR),
);
const OutlineInputBorder PLAIN_WHITE_COLOR = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: Colors.white),
);
const OutlineInputBorder ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: ERROR_BORDER_COLOR),
);
const OutlineInputBorder FOCUSED_ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: FOCUSED_ERROR_BORDER_COLOR),
);

class PrimaryDropDownField extends StatelessWidget {
  const PrimaryDropDownField({
    Key? key,
    required this.list,
    this.validationText,
    this.hint,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  final List<dynamic> list;
  final String? hint;
  final String? validationText;
  final void Function(String? value) onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      hint: Text(hint ?? ''),
      value: (value == '') ? null : value,
      items: list
          .map((e) =>
              DropdownMenuItem<String>(value: e.toString(), child: Text('$e')))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          enabledBorder: ENABLED_BORDER,
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_ERROR_BORDER),
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}

class SecondaryDropDownField extends StatelessWidget {
  const SecondaryDropDownField(
      {Key? key,
      required this.list,
      required this.selectedItem,
      this.validationText,
      this.hint,
      required this.onChanged})
      : super(key: key);

  final List<Object> list;
  final Object? selectedItem;
  final String? hint;
  final String? validationText;
  final void Function(Object? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object>(
      value: selectedItem,
      hint: Text(
        hint ?? '',
        style: const TextStyle(fontSize: 16),
      ),
      items: list
          .map((e) => DropdownMenuItem<Object>(value: e, child: Text('$e')))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      ),
      validator: (value) {
        if (value == null) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}

class BorderlessDropDownField extends StatelessWidget {
  const BorderlessDropDownField(
      {Key? key,
        required this.list,
        required this.selectedItem,
        this.validationText,
        this.hint,
        required this.onChanged})
      : super(key: key);

  final List<Object> list;
  final Object? selectedItem;
  final String? hint;
  final String? validationText;
  final void Function(Object? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object>(
      value: selectedItem,
      hint: Text(
        hint ?? '',
        style: const TextStyle(fontSize: 16),
      ),
      items: list
          .map((e) => DropdownMenuItem<Object>(value: e, child: Text('$e')))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value == null) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}



class PrimaryDropDownSearch<T> extends StatelessWidget {
  const PrimaryDropDownSearch({
    super.key,
    this.hintText,
    required this.items,
    this.itemBuilder,
    this.onChanged,
    this.asyncItems,
    this.padding = const EdgeInsets.all(10),
  });
  final String? hintText;
  final List<T> items;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      itemBuilder;
  final void Function(T? item)? onChanged;
  final Future<List<T>> Function(String)? asyncItems;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      asyncItems: asyncItems,
      items: items,
      onChanged: onChanged,
      dropdownButtonProps: DropdownButtonProps(
        padding: padding,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        hintText: hintText,
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      )),
      popupProps: PopupProps.bottomSheet(
        fit: FlexFit.loose,
        itemBuilder: itemBuilder,
        showSearchBox: true,
        bottomSheetProps: const BottomSheetProps(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class PrimaryDropDownSearchSelect<T> extends StatelessWidget {
  const PrimaryDropDownSearchSelect({
    super.key,
    this.hintText,
    required this.items,
    required this.selectedItem,
    this.itemBuilder,
    this.onChanged,
    this.asyncItems,
    this.padding = const EdgeInsets.all(10),
  });
  final String? hintText;
  final List<T> items;
  final Widget Function(BuildContext context, T item, bool isSelected)?
  itemBuilder;
  final void Function(T? item)? onChanged;
  final Future<List<T>> Function(String)? asyncItems;
  final EdgeInsetsGeometry padding;
  final T selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      asyncItems: asyncItems,
      items: items,
      onChanged: onChanged,
      dropdownButtonProps: DropdownButtonProps(
        padding: padding,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: hintText,
            enabledBorder: ENABLED_BORDER,
            focusedBorder: FOCUSED_BORDER,
            errorBorder: ERROR_BORDER,
            focusedErrorBorder: FOCUSED_ERROR_BORDER,
          )),
      selectedItem: selectedItem,
      popupProps: PopupProps.bottomSheet(
        fit: FlexFit.loose,
        itemBuilder: itemBuilder,
        showSearchBox: true,
        bottomSheetProps: const BottomSheetProps(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class PrimaryDropDownSelectEdit<T> extends StatelessWidget {
  const PrimaryDropDownSelectEdit({
    super.key,
    this.hintText,
    required this.items,
    this.itemBuilder,
    this.onChanged,
    this.asyncItems,
    this.padding = const EdgeInsets.all(10),
  });
  final String? hintText;
  final List<T> items;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      itemBuilder;
  final void Function(T? item)? onChanged;
  final Future<List<T>> Function(String)? asyncItems;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      asyncItems: asyncItems,
      items: items,
      onChanged: onChanged,
      // dropdownButtonProps: DropdownButtonProps(
      //   padding: padding,
      // ),
      // dropdownDecoratorProps: DropDownDecoratorProps(
      //     dropdownSearchDecoration: InputDecoration(
      //   hintText: hintText,
      //   enabledBorder: ENABLED_BORDER,
      //   focusedBorder: FOCUSED_BORDER,
      //   errorBorder: ERROR_BORDER,
      //   focusedErrorBorder: FOCUSED_ERROR_BORDER,
      // )),
      popupProps: PopupProps.bottomSheet(
        fit: FlexFit.loose,
        itemBuilder: itemBuilder,
        showSearchBox: true,
        bottomSheetProps: const BottomSheetProps(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class PrimaryEditDropDownSearch<T> extends StatelessWidget {
  const PrimaryEditDropDownSearch({
    super.key,
    this.hintText,
    required this.items,
    required this.selectedItem,
    this.itemBuilder,
    this.onChanged,
    this.asyncItems,
    this.padding = const EdgeInsets.all(10),
  });
  final String? hintText;
  final List<T> items;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      itemBuilder;
  final void Function(T? item)? onChanged;
  final Future<List<T>> Function(String)? asyncItems;
  final EdgeInsetsGeometry padding;
  final T selectedItem;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      asyncItems: asyncItems,
      items: items,
      onChanged: onChanged,
      dropdownButtonProps: DropdownButtonProps(
        padding: padding,
      ),
      selectedItem: selectedItem,
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        hintText: hintText,
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      )),
      popupProps: PopupProps.bottomSheet(
        fit: FlexFit.loose,
        itemBuilder: itemBuilder,
        showSearchBox: true,
        bottomSheetProps: const BottomSheetProps(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
