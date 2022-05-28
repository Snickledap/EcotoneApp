import 'package:flutter/material.dart';

void main() => runApp(AnalyticsPage());


class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Data'),
          leading: _DropDownButton(),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}



class _DropDownButton extends StatefulWidget {
  const _DropDownButton({Key? key}) : super(key: key);

  @override
  State<_DropDownButton> createState() => _DropDownButtonState();
}
class _DropDownButtonState extends State<_DropDownButton> {
  String dropdownValue = 'SeaHorse1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 1,
        width: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['SeaHorse1', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}