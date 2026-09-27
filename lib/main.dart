import 'package:flutter/material.dart';
// Week 1 Screens
import 'week1/screens/hello_flutter_screen.dart';
import 'week1/screens/profile_card_screen.dart';
import 'week1/screens/personal_info_screen.dart';

// Week 2 Screens
import 'week2/todo/screens/todo_list_screen.dart';
import 'week2/auth_demo/screens/login_screen.dart';
import 'week2/expense_tracker/expense_tracker_shell.dart';

// Week 3 Screens
import 'week3/public_api_news/screens/public_news_screen.dart';
import 'week3/firebase_auth/screens/firebase_login_screen.dart';
import 'week3/weather_app/screens/weather_forecast_screen.dart';

// Week 4 Capstone Screen
import 'week4/ecommerce_app_shell.dart';

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
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Himanshu Raj - Flutter Coursework & Capstone Hub',
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
  int _selectedWeek = 4; // Default to Week 4 Capstone
  int _selectedWeek1Index = 0;
  int _selectedWeek2Index = 0;
  int _selectedWeek3Index = 0;

  // Week 1 Screens
  final List<Widget> _week1Screens = const [
    HelloFlutterScreen(),
    ProfileCardScreen(),
    PersonalInfoScreen(),
  ];

  final List<String> _week1Titles = const [
    'Assignment 1: Hello Flutter',
    'Assignment 2: Profile Card',
    'Mini Project: Personal Info',
  ];

  // Week 2 Screens
  final List<Widget> _week2Screens = const [
    TodoListScreen(),
    LoginScreen(),
    ExpenseTrackerShell(),
  ];

  final List<String> _week2Titles = const [
    'Week 2: To-Do List App (2 Screens)',
    'Week 2: Login & Navigation Demo',
    'Week 2 Mini Project: Expense Tracker',
  ];

  // Week 3 Screens
  final List<Widget> _week3Screens = const [
    PublicNewsScreen(),
    FirebaseLoginScreen(),
    WeatherForecastScreen(),
  ];

  final List<String> _week3Titles = const [
    'Week 3: Public API Feed',
    'Week 3: Firebase Login Page',
    'Week 3 Mini Project: Weather Forecast App',
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
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ListView(
                controller: scrollController,
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
                    'Flutter Coursework & Capstone Portfolio',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Student: Himanshu Raj • B.Tech CSE',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Week 4 Capstone
                  const Text('Week 4 - Capstone Project:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  _buildOverviewTile(
                    week: 4,
                    index: 0,
                    number: '🏆',
                    title: 'Pulse E-Commerce App',
                    description: 'Full store: Login, Catalog, Cart with Badges, Mock Checkout & Order Tracking.',
                  ),

                  const SizedBox(height: 18),

                  // Week 3 Tasks
                  const Text('Week 3 Solutions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 3, index: 0, number: '1', title: 'Public API News Feed', description: 'Live news feed via Hacker News public REST API.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 3, index: 1, number: '2', title: 'Firebase Login Page', description: 'Email/Password auth, validation, password reset & profile.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 3, index: 2, number: '★', title: 'Weather Forecast App', description: 'Live OpenWeather / Open-Meteo, 5-day forecast, city search & icons.'),

                  const SizedBox(height: 18),

                  // Week 2 Tasks
                  const Text('Week 2 Solutions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 2, index: 0, number: '1', title: 'To-Do List App (2 Screens)', description: 'Screen 1: Tasks • Screen 2: Add with TextField & setState.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 2, index: 1, number: '2', title: 'Login & Home Navigation', description: 'Form validation, parameters passing, and logout modal.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 2, index: 2, number: '★', title: 'Expense Tracker UI App', description: 'Multi-screen (Dashboard, Add, History) + Local State.'),

                  const SizedBox(height: 18),

                  // Week 1 Tasks
                  const Text('Week 1 Solutions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 1, index: 0, number: '1', title: 'Hello Flutter App', description: 'Displays student name, course, and reactive greeting.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 1, index: 1, number: '2', title: 'Profile Card App', description: 'Built with Container, Row, Column, Image, and Text.'),
                  const SizedBox(height: 8),
                  _buildOverviewTile(week: 1, index: 2, number: '★', title: 'Personal Info App', description: 'Responsive layout with skills and contact cards.'),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOverviewTile({
    required int week,
    required int index,
    required String number,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedWeek == week &&
        (_selectedWeek == 1
            ? _selectedWeek1Index == index
            : _selectedWeek == 2
                ? _selectedWeek2Index == index
                : _selectedWeek == 3
                    ? _selectedWeek3Index == index
                    : true);

    return ListTile(
      onTap: () {
        setState(() {
          _selectedWeek = week;
          if (week == 1) {
            _selectedWeek1Index = index;
          } else if (week == 2) {
            _selectedWeek2Index = index;
          } else if (week == 3) {
            _selectedWeek3Index = index;
          }
        });
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      tileColor: isSelected ? colorScheme.primaryContainer.withValues(alpha: 0.3) : null,
      leading: CircleAvatar(
        backgroundColor: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        foregroundColor: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
        child: Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.w600)),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedWeek == 4) {
      return Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Week 4: Capstone E-Commerce App',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Production-Ready Mobile Application',
                style: TextStyle(fontSize: 11, color: Colors.blue),
              ),
            ],
          ),
          actions: [
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('W1')),
                ButtonSegment(value: 2, label: Text('W2')),
                ButtonSegment(value: 3, label: Text('W3')),
                ButtonSegment(value: 4, label: Text('W4')),
              ],
              selected: const {4},
              onSelectionChanged: (set) {
                setState(() => _selectedWeek = set.first);
              },
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              onPressed: widget.onToggleTheme,
              icon: Icon(widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            ),
            IconButton(
              tooltip: 'View Syllabus / Overview',
              onPressed: _showAssignmentsOverview,
              icon: const Icon(Icons.info_outline_rounded),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: const EcommerceAppShell(),
      );
    }

    final currentTitle = _selectedWeek == 1
        ? _week1Titles[_selectedWeek1Index]
        : _selectedWeek == 2
            ? _week2Titles[_selectedWeek2Index]
            : _week3Titles[_selectedWeek3Index];

    final currentScreen = _selectedWeek == 1
        ? _week1Screens[_selectedWeek1Index]
        : _selectedWeek == 2
            ? _week2Screens[_selectedWeek2Index]
            : _week3Screens[_selectedWeek3Index];

    final currentIndex = _selectedWeek == 1
        ? _selectedWeek1Index
        : _selectedWeek == 2
            ? _selectedWeek2Index
            : _selectedWeek3Index;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Week $_selectedWeek Submission',
              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          // Week Switcher Segmented Control (W1, W2, W3, W4)
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 1, label: Text('W1')),
              ButtonSegment(value: 2, label: Text('W2')),
              ButtonSegment(value: 3, label: Text('W3')),
              ButtonSegment(value: 4, label: Text('W4')),
            ],
            selected: {_selectedWeek},
            onSelectionChanged: (set) {
              setState(() {
                _selectedWeek = set.first;
              });
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          ),
          IconButton(
            tooltip: 'View Syllabus / Overview',
            onPressed: _showAssignmentsOverview,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey<String>('w${_selectedWeek}_$currentIndex'),
          child: currentScreen,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            if (_selectedWeek == 1) {
              _selectedWeek1Index = index;
            } else if (_selectedWeek == 2) {
              _selectedWeek2Index = index;
            } else {
              _selectedWeek3Index = index;
            }
          });
        },
        destinations: _selectedWeek == 1
            ? const [
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
              ]
            : _selectedWeek == 2
                ? const [
                    NavigationDestination(
                      icon: Icon(Icons.checklist_rounded),
                      selectedIcon: Icon(Icons.checklist_rtl_rounded),
                      label: 'To-Do (2 Screens)',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.login_rounded),
                      selectedIcon: Icon(Icons.lock_open_rounded),
                      label: 'Login & Nav',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.account_balance_wallet_outlined),
                      selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                      label: 'Expense Tracker',
                    ),
                  ]
                : const [
                    NavigationDestination(
                      icon: Icon(Icons.public_rounded),
                      selectedIcon: Icon(Icons.public_sharp),
                      label: 'Public API',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.local_fire_department_outlined),
                      selectedIcon: Icon(Icons.local_fire_department_rounded),
                      label: 'Firebase Login',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.cloud_outlined),
                      selectedIcon: Icon(Icons.cloud_rounded),
                      label: 'Weather App',
                    ),
                  ],
      ),
    );
  }
}
