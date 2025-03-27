import 'package:flutter/material.dart';
import 'package:procketbuddy_native/utils/personal_expense_details.dart';

class PersonalExpenseWidget extends StatefulWidget {
  final bool hasExpenseData;
  final dynamic expenseData; // Expecting expense data from API

  const PersonalExpenseWidget({
    super.key,
    required this.hasExpenseData,
    this.expenseData,
  });

  @override
  State<PersonalExpenseWidget> createState() => _PersonalExpenseWidgetState();
}

class _PersonalExpenseWidgetState extends State<PersonalExpenseWidget> {
  @override
  void initState() {
    super.initState();
    PersonalExpenseDetails.addItemToExpenseDetailList(widget.expenseData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).colorScheme.onError,
      child: widget.hasExpenseData
          ? _buildExpenseSummary()
          : _buildNoExpenseSummary(),
    );
  }

  Widget _buildExpenseSummary() {
    List<PersonalExpenseDetails> expenseData =
        PersonalExpenseDetails.getExpenseDetailList();
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Expense: \$ 1200"),
              Text("Current: \$ 600"),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Personal Expense",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.sort),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: expenseData.length,
                    itemBuilder: (context, index) {
                      final expense = expenseData[index];
                      Color color = Theme.of(context).colorScheme.onSecondary;
                      if (index % 2 == 0) {
                        color = Theme.of(context).colorScheme.onTertiary;
                      }
                      return Card();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoExpenseSummary() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "No Expense Found!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "Please add some expenses.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
