import 'package:flutter/material.dart';
import 'screens/hello_flutter_screen.dart';
import 'screens/profile_card_screen.dart';
import 'screens/personal_info_screen.dart';

void main() {
  runApp(const FlutterAssignmentsApp());
}

class FlutterAssignmentsApp extends StatefulWidget {
  const FlutterAssignmentsApp({super.key});

  @override
  State<FlutterAssignmentsApp> createState() => _FlutterAssignmentsAppState();
}

class _FlutterAssignmentsAppState extends State<FlutterAssignmentsApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Himanshu Raj - Flutter Assignments',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF64B5F6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardTheme: const CardThemeData(
          color: Color(0xFF1E293B),
          elevation: 0,
        ),
      ),
      home: MainShellScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MainShellScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MainShellScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HelloFlutterScreen(),
    ProfileCardScreen(),
    PersonalInfoScreen(),
  ];

  final List<String> _titles = const [
    'Assignment 1: Hello Flutter',
    'Assignment 2: Profile Card',
    'Mini Project: Personal Info',
  ];

  void _showAssignmentsOverview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Coursework & Projects Overview',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildOverviewTile(
                context,
                index: 0,
                number: '1',
                title: 'Hello Flutter App',
                description: 'Displays student name and course with reactive greeting.',
              ),
              const SizedBox(height: 12),
              _buildOverviewTile(
                context,
                index: 1,
                number: '2',
                title: 'Profile Card App',
                description: 'Built with Container, Row, Column, Image, and Text widgets.',
              ),
              const SizedBox(height: 12),
              _buildOverviewTile(
                context,
                index: 2,
                number: '★',
                title: 'Mini Project: Personal Info App',
                description: 'Static screen with profile photo, name, skills, and responsive layout.',
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverviewTile(
    BuildContext context, {
    required int index,
    required String number,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedIndex == index;

    return ListTile(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      tileColor: isSelected
          ? colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      leading: CircleAvatar(
        backgroundColor:
            isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        foregroundColor:
            isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
        child: Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        ),
      ),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: widget.isDarkMode
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
          IconButton(
            tooltip: 'View Syllabus / Assignment Details',
            onPressed: _showAssignmentsOverview,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.waving_hand_outlined),
            selectedIcon: Icon(Icons.waving_hand_rounded),
            label: 'Hello Flutter',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge_rounded),
            label: 'Profile Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_pin_outlined),
            selectedIcon: Icon(Icons.person_pin_rounded),
            label: 'Personal Info',
          ),
        ],
      ),
    );
  }
}
