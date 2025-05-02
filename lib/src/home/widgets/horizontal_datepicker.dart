import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDatePickerExample extends StatefulWidget {
  const HorizontalDatePickerExample({super.key});

  @override
  _HorizontalDatePickerExampleState createState() =>
      _HorizontalDatePickerExampleState();
}

class _HorizontalDatePickerExampleState
    extends State<HorizontalDatePickerExample> {
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (context, index) {
                DateTime date = startDate.add(Duration(days: index));
                bool isSelected = date.day == selectedDate.day &&
                    date.month == selectedDate.month &&
                    date.year == selectedDate.year;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('d').format(date),
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('EEE').format(date),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Selected Date: ${DateFormat('EEEE, dd MMMM').format(selectedDate)}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}