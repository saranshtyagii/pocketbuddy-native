import 'package:flutter/material.dart';
import 'package:procketbuddy_native/services/HomePageServices.dart';
import 'package:procketbuddy_native/widgets/personal_expense_widget.dart';
import 'package:http/http.dart' as http;
import 'package:procketbuddy_native/widgets/room_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Homepageservices homepageservices = Homepageservices();

  bool hasExpenseData = false;
  dynamic expenseData;
  bool isLoading = true;
  bool isPersonalExpenseScreen = true;
  int selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPersonalExpenseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pocket Buddy")),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Home'),
            _buildNavItem(1, Icons.group, 'Room'),
            _buildNavItem(2, Icons.analytics, 'Activity'),
            _buildNavItem(3, Icons.settings, 'Setting'),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : isPersonalExpenseScreen
              ? PersonalExpenseWidget(
                  hasExpenseData: hasExpenseData,
                  expenseData: expenseData,
                )
              : RoomDetailsWidget(),
      drawer: const Drawer(),
      drawerEnableOpenDragGesture: true,
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = index == selectedNavIndex;
    return GestureDetector(
      onTap: () {
        print("$label Button Pressed!");
        setState(() {
          isPersonalExpenseScreen = index == 1 ? false : true;
          selectedNavIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.surface),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? Theme.of(context).colorScheme.surface
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadPersonalExpenseData() async {
    try {
      http.Response? expenseResponse =
          await homepageservices.fetchUserPersonalExpense();

      if (expenseResponse != null && expenseResponse.statusCode == 200) {
        setState(() {
          hasExpenseData = expenseResponse.body.isNotEmpty;
          expenseData = expenseResponse.body;
          isLoading = false;
        });
      } else {
        setState(() {
          hasExpenseData = false;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching expenses: $e");
      setState(() {
        hasExpenseData = false;
        isLoading = false;
      });
    }
  }
}
