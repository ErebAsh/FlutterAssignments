import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/expense_history_screen.dart';
import 'state/expense_controller.dart';

/// Mini Project: Expense Tracker UI App
/// Features multiple screens:
/// 1. Dashboard
/// 2. Add Expense
/// 3. History
/// Uses local state management (ExpenseController with ChangeNotifier / setState).
class ExpenseTrackerShell extends StatefulWidget {
  const ExpenseTrackerShell({super.key});

  @override
  State<ExpenseTrackerShell> createState() => _ExpenseTrackerShellState();
}

class _ExpenseTrackerShellState extends State<ExpenseTrackerShell> {
  late final ExpenseController _controller;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = ExpenseController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        controller: _controller,
        onNavigateToAdd: () {
          setState(() {
            _currentTabIndex = 1; // Switch to Add tab
          });
        },
        onNavigateToHistory: () {
          setState(() {
            _currentTabIndex = 2; // Switch to History tab
          });
        },
      ),
      AddExpenseScreen(
        controller: _controller,
        onSaved: () {
          setState(() {
            _currentTabIndex = 0; // Return to Dashboard on save
          });
        },
      ),
      ExpenseHistoryScreen(controller: _controller),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: screens[_currentTabIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            selectedIcon: Icon(Icons.add_circle_rounded),
            label: 'Add Expense',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
