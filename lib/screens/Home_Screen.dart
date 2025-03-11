import 'package:flutter/material.dart';
import 'package:procketbuddy_native/services/HomePageServices.dart';
import 'package:procketbuddy_native/widgets/HomeScreenWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pocket Buddy",
        ),
        backgroundColor: const Color.fromARGB(255, 84, 205, 193),
      ),
      body: Homescreenwidget(),
      endDrawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AddExpenseDialog(),
    );
  }
}

class AddExpenseDialog extends StatefulWidget {
  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Expense"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: "Expense Description"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Enter Amount"),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addExpense,
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void _addExpense() {
    String description = _descriptionController.text.trim();
    String amount = _amountController.text.trim();

    if (description.isNotEmpty && amount.isNotEmpty) {
      Homepageservices().addExpense("home_screen", description, amount);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
