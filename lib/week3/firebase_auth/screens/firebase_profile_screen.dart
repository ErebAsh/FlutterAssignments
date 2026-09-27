import 'package:flutter/material.dart';
import '../models/firebase_auth_user.dart';
import '../services/firebase_auth_service.dart';

/// Screen displayed after successful Firebase Authentication
class FirebaseProfileScreen extends StatelessWidget {
  final FirebaseAuthUser user;
  final FirebaseAuthService authService;
  final VoidCallback onSignedOut;

  const FirebaseProfileScreen({
    super.key,
    required this.user,
    required this.authService,
    required this.onSignedOut,
  });

  Future<void> _handleSignOut(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Sign Out from Firebase'),
        content: const Text('Are you sure you want to end your Firebase authenticated session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await authService.signOut();
      onSignedOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Firebase Badge & Icon
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        size: 48,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Firebase Authenticated',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_rounded, size: 16, color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Email & Password Session Active',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // User Info Details Box
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Display Name', user.displayName),
                        const Divider(height: 18),
                        _buildInfoRow('Email Address', user.email),
                        const Divider(height: 18),
                        _buildInfoRow('Firebase UID', user.uid),
                        const Divider(height: 18),
                        _buildInfoRow(
                          'Created At',
                          '${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  FilledButton.tonalIcon(
                    onPressed: () => _handleSignOut(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Sign Out'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
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
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
