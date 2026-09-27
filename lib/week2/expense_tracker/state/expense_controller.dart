import 'package:flutter/material.dart';
import '../models/expense_item.dart';

/// Local State Management for the Expense Tracker Mini Project
/// Handles transactions, calculated balance, category analytics, and filtering.
class ExpenseController extends ChangeNotifier {
  final List<ExpenseItem> _transactions = [];

  ExpenseController() {
    _seedInitialData();
  }

  List<ExpenseItem> get transactions => List.unmodifiable(_transactions);

  void _seedInitialData() {
    final now = DateTime.now();
    _transactions.addAll([
      ExpenseItem(
        id: '1',
        title: 'Internship Stipend',
        amount: 25000.0,
        type: TransactionType.income,
        category: 'Salary',
        date: now.subtract(const Duration(days: 4)),
        note: 'Monthly development stipend',
      ),
      ExpenseItem(
        id: '2',
        title: 'Flutter UI Course / Books',
        amount: 1499.0,
        type: TransactionType.expense,
        category: 'Education',
        date: now.subtract(const Duration(days: 3)),
        note: 'Study material',
      ),
      ExpenseItem(
        id: '3',
        title: 'Café & Lunch with Team',
        amount: 580.0,
        type: TransactionType.expense,
        category: 'Food',
        date: now.subtract(const Duration(days: 2)),
        note: 'Team coffee break',
      ),
      ExpenseItem(
        id: '4',
        title: 'Metro / Travel Pass',
        amount: 850.0,
        type: TransactionType.expense,
        category: 'Transport',
        date: now.subtract(const Duration(days: 1)),
        note: 'Monthly recharge',
      ),
      ExpenseItem(
        id: '5',
        title: 'Freelance Bugfix Project',
        amount: 4500.0,
        type: TransactionType.income,
        category: 'Freelance',
        date: now,
        note: 'Landing page responsive fix',
      ),
    ]);
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.isExpense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get currentBalance => totalIncome - totalExpense;

  Map<String, double> get categoryBreakdown {
    final Map<String, double> map = {};
    for (final t in _transactions.where((t) => t.isExpense)) {
      map[t.category] = (map[t.category] ?? 0.0) + t.amount;
    }
    return map;
  }

  void addTransaction(ExpenseItem item) {
    _transactions.insert(0, item);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void restoreTransaction(int index, ExpenseItem item) {
    if (index >= 0 && index <= _transactions.length) {
      _transactions.insert(index, item);
    } else {
      _transactions.add(item);
    }
    notifyListeners();
  }
}
