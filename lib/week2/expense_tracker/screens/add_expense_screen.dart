import 'package:flutter/material.dart';
import '../models/expense_item.dart';
import '../state/expense_controller.dart';

/// Screen 2 of Mini Project: Add Expense Screen
class AddExpenseScreen extends StatefulWidget {
  final ExpenseController controller;
  final VoidCallback? onSaved;

  const AddExpenseScreen({
    super.key,
    required this.controller,
    this.onSaved,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();

  final Map<String, IconData> _expenseCategories = {
    'Food': Icons.restaurant_rounded,
    'Transport': Icons.directions_bus_rounded,
    'Education': Icons.school_rounded,
    'Shopping': Icons.shopping_bag_rounded,
    'Entertainment': Icons.movie_rounded,
    'Bills': Icons.receipt_long_rounded,
    'Health': Icons.medical_services_rounded,
    'Other': Icons.category_rounded,
  };

  final Map<String, IconData> _incomeCategories = {
    'Salary': Icons.account_balance_wallet_rounded,
    'Freelance': Icons.laptop_mac_rounded,
    'Investment': Icons.trending_up_rounded,
    'Gift': Icons.card_giftcard_rounded,
    'Other': Icons.savings_rounded,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTransaction() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an amount greater than 0'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newTransaction = ExpenseItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: amount,
      type: _selectedType,
      category: _selectedCategory,
      date: _selectedDate,
      note: _noteController.text.trim(),
    );

    widget.controller.addTransaction(newTransaction);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${_selectedType == TransactionType.income ? "Income" : "Expense"}: ₹${amount.toStringAsFixed(2)}',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    if (widget.onSaved != null) {
      widget.onSaved!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentCategoryMap = _selectedType == TransactionType.expense
        ? _expenseCategories
        : _incomeCategories;

    // Reset selected category if not in the current category map
    if (!currentCategoryMap.containsKey(_selectedCategory)) {
      _selectedCategory = currentCategoryMap.keys.first;
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Segmented Button: Expense vs Income
                    SegmentedButton<TransactionType>(
                      segments: const [
                        ButtonSegment(
                          value: TransactionType.expense,
                          icon: Icon(Icons.arrow_downward_rounded, color: Colors.red),
                          label: Text('Expense'),
                        ),
                        ButtonSegment(
                          value: TransactionType.income,
                          icon: Icon(Icons.arrow_upward_rounded, color: Colors.green),
                          label: Text('Income'),
                        ),
                      ],
                      selected: {_selectedType},
                      onSelectionChanged: (set) {
                        setState(() {
                          _selectedType = set.first;
                          _selectedCategory = _selectedType == TransactionType.expense
                              ? 'Food'
                              : 'Salary';
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // Amount input
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _selectedType == TransactionType.expense
                            ? Colors.red.shade700
                            : Colors.green.shade700,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Amount (₹) *',
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the amount';
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Title input
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title / Subject *',
                        hintText: 'e.g. Grocery shopping, Electricity bill...',
                        prefixIcon: const Icon(Icons.edit_note_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please provide a title';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Date selector row
                    InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.outlineVariant),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today_rounded, color: colorScheme.primary),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(Icons.edit_calendar_rounded, size: 20, color: colorScheme.outline),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Category Selector
                    Text(
                      'Category:',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: currentCategoryMap.entries.map((entry) {
                        final isSelected = _selectedCategory == entry.key;
                        return ChoiceChip(
                          avatar: Icon(
                            entry.value,
                            size: 16,
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                          label: Text(entry.key),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedCategory = entry.key;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 18),

                    // Optional Note
                    TextFormField(
                      controller: _noteController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Note (Optional)',
                        hintText: 'Additional details or memo...',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Icon(Icons.description_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Submit Button
                    FilledButton.icon(
                      onPressed: _saveTransaction,
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: Text(
                        'Save ${_selectedType == TransactionType.income ? "Income" : "Expense"}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: _selectedType == TransactionType.expense
                            ? Colors.red.shade700
                            : Colors.green.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
