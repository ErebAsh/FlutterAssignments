import 'package:flutter/material.dart';
import '../models/expense_item.dart';
import '../state/expense_controller.dart';

/// Screen 3 of Mini Project: History Screen
/// Displays filterable and searchable list of all past transactions.
class ExpenseHistoryScreen extends StatefulWidget {
  final ExpenseController controller;

  const ExpenseHistoryScreen({
    super.key,
    required this.controller,
  });

  @override
  State<ExpenseHistoryScreen> createState() => _ExpenseHistoryScreenState();
}

class _ExpenseHistoryScreenState extends State<ExpenseHistoryScreen> {
  String _searchQuery = '';
  String _filter = 'All'; // 'All', 'Expense', 'Income'
  String _sortBy = 'Date (Newest)';

  final List<String> _sortOptions = [
    'Date (Newest)',
    'Date (Oldest)',
    'Amount (High-Low)',
    'Amount (Low-High)',
  ];

  List<ExpenseItem> _getFilteredTransactions() {
    var list = widget.controller.transactions.where((t) {
      final matchesSearch = t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _filter == 'All' ||
          (_filter == 'Expense' && t.isExpense) ||
          (_filter == 'Income' && t.isIncome);

      return matchesSearch && matchesFilter;
    }).toList();

    // Sorting
    if (_sortBy == 'Date (Newest)') {
      list.sort((a, b) => b.date.compareTo(a.date));
    } else if (_sortBy == 'Date (Oldest)') {
      list.sort((a, b) => a.date.compareTo(b.date));
    } else if (_sortBy == 'Amount (High-Low)') {
      list.sort((a, b) => b.amount.compareTo(a.amount));
    } else if (_sortBy == 'Amount (Low-High)') {
      list.sort((a, b) => a.amount.compareTo(b.amount));
    }

    return list;
  }

  void _deleteTransaction(ExpenseItem item) {
    final originalIndex = widget.controller.transactions.indexOf(item);
    widget.controller.deleteTransaction(item.id);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${item.title}"'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            widget.controller.restoreTransaction(originalIndex, item);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final filteredList = _getFilteredTransactions();
        final totalAmount = filteredList.fold(0.0, (sum, t) => sum + (t.isIncome ? t.amount : -t.amount));

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  // Search & Sort Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search expenses, categories...',
                            prefixIcon: const Icon(Icons.search_rounded),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val.trim();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton<String>(
                        tooltip: 'Sort by',
                        initialValue: _sortBy,
                        onSelected: (val) {
                          setState(() {
                            _sortBy = val;
                          });
                        },
                        itemBuilder: (context) => _sortOptions.map((opt) {
                          return PopupMenuItem(
                            value: opt,
                            child: Text(opt),
                          );
                        }).toList(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorScheme.outlineVariant),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.sort_rounded, size: 20),
                              SizedBox(width: 4),
                              Text('Sort', style: TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Filter Chips & Net filtered Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: ['All', 'Expense', 'Income'].map((f) {
                          final isSelected = _filter == f;
                          return ChoiceChip(
                            label: Text(f),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _filter = f;
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Net: ₹${totalAmount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: totalAmount >= 0 ? Colors.green.shade700 : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Transactions List
                  Expanded(
                    child: filteredList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 64,
                                  color: colorScheme.outlineVariant,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No transactions found',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Try adjusting your search or filter keywords',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredList.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final item = filteredList[index];
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: item.isIncome
                                        ? Colors.green.withValues(alpha: 0.15)
                                        : Colors.red.withValues(alpha: 0.15),
                                    foregroundColor: item.isIncome
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                    child: Icon(
                                      item.isIncome
                                          ? Icons.arrow_downward_rounded
                                          : Icons.arrow_upward_rounded,
                                    ),
                                  ),
                                  title: Text(
                                    item.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${item.category} • ${item.date.day}/${item.date.month}/${item.date.year}'
                                    '${item.note.isNotEmpty ? " • ${item.note}" : ""}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${item.isIncome ? "+" : "-"}₹${item.amount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: item.isIncome
                                              ? Colors.green.shade700
                                              : Colors.red.shade700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline_rounded, size: 20),
                                        color: colorScheme.error,
                                        tooltip: 'Delete transaction',
                                        onPressed: () => _deleteTransaction(item),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
