import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items; // List of items for the dropdown
  final String hintText; // Placeholder text when no selection is made
  final Color? hintColor; // Placeholder text when no selection is made
  final Color? dropDownColor; // Placeholder text when no selection is made
  final Color? dropDownTextColor; // Placeholder text when no selection is made
  final Function(String?) onChanged; // Callback when item is selected
  final Color? dropDownFieldColor;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.dropDownFieldColor,
    this.dropDownTextColor,
    this.hintColor,
    this.dropDownColor,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue; // Holds the selected item

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        color: widget.dropDownFieldColor ?? Colors.white,
      ),
      child: DropdownButton<String>(
        style: TextStyle(color: widget.dropDownTextColor ?? Colors.white),
        dropdownColor: widget.dropDownColor ?? Colors.white,
        value: selectedValue,
        hint: Text(
          widget.hintText,
          style: TextStyle(color: widget.hintColor ?? Colors.grey),
        ), // Display hint text if no item is selected
        isExpanded: true,
        icon:
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
        underline: const SizedBox(),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged(newValue); // Call the onChanged callback
        },
      ),
    );
  }
}

class DynamicDropdownExample extends StatelessWidget {
  const DynamicDropdownExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example dynamic list of items
    List<String> items = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Dynamic Dropdown'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomDropdownButton(
              items: items,
              hintText:
                  'Select an option', // Hint text when no selection is made
              onChanged: (value) {
                debugPrint('Selected value: $value'); // Handle value change
              },
            ),
          ],
        ),
      ),
    );
  }
}
