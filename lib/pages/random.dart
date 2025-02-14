import 'package:flutter/material.dart';

class Random extends StatefulWidget {
  const Random({super.key});

  @override
  State<Random> createState() => _RandomState();
}

class _RandomState extends State<Random> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random'),
      ),
      body: Center(
        child: DropdownMenu(
          width: 400,
          hintText: 'Select an item',
          textAlign: TextAlign.center,
          leadingIcon: Icon(Icons.ac_unit),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(20),
            filled: true,
            fillColor: Colors.red,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2
              )
            ),
          ),
          textStyle: TextStyle(
            color: Colors.greenAccent,
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
          ),
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: 1,
              label: 'One',
            ),
            DropdownMenuEntry(value: 2, label: 'Two'),
            DropdownMenuEntry(value: 3, label: 'Three'),
          ],
        ),
      ),
    );
  }
}
