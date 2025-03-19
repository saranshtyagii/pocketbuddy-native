import 'package:flutter/material.dart';

class Homescreenwidget extends StatefulWidget {
  const Homescreenwidget({super.key});

  @override
  State<Homescreenwidget> createState() {
    return _HomeScreenWidgetState();
  }
}

class _HomeScreenWidgetState extends State<Homescreenwidget> {
  bool hasExpenseData = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: hasExpenseData ? _buildExpenseSummary() : _buildNoExpenseSummary(),
    );
  }

  _buildExpenseSummary() {}

  _buildNoExpenseSummary() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Expense Found!",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(),
          Text(
            "Please add some expense.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
