import 'dart:convert';

class PersonalExpenseDetails {
  final String expenseId;
  final String description;
  final num amount;
  final DateTime expenseDate;
  final DateTime updatedDate;
  final bool edited;
  final bool deleted;

  static List<PersonalExpenseDetails> expenseDetailList = [];

  PersonalExpenseDetails(
    this.expenseId,
    this.description,
    this.amount,
    this.expenseDate,
    this.updatedDate,
    this.edited,
    this.deleted,
  );

  static List<PersonalExpenseDetails> getExpenseDetailList() {
    return expenseDetailList;
  }

  static void addItemToExpenseDetailList(dynamic expenseData) {
    // ✅ Ensure `expenseData` is not null and properly formatted
    if (expenseData == null) {
      print("Error: expenseData is null");
      return;
    }

    try {
      // ✅ If expenseData is a string, decode it into a List
      if (expenseData is String) {
        expenseData = jsonDecode(expenseData);
      }

      // ✅ Ensure it's a List before iterating
      if (expenseData is List) {
        expenseDetailList.clear(); // Avoid duplicates
        for (var expense in expenseData) {
          expenseDetailList.add(
            PersonalExpenseDetails(
              expense['expenseId'] ?? '',
              expense['description'] ?? '',
              expense['amount'] ?? 0,
              expense['expenseDate'] != null
                  ? DateTime.parse(expense['expenseDate'])
                  : DateTime.now(),
              expense['updatedDate'] != null
                  ? DateTime.parse(expense['updatedDate'])
                  : DateTime.now(),
              expense['edited'] ?? false,
              expense['deleted'] ?? false,
            ),
          );
        }
      } else {
        print("Error: Expected List but received ${expenseData.runtimeType}");
      }
    } catch (e) {
      print("Error parsing expenseData: $e");
    }
  }
}
