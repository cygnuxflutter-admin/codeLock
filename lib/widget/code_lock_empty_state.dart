import 'package:flutter/material.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/modules/Home Screen/home_screen_controller.dart';


class CodeLockEmptyState extends StatelessWidget {
  final String categoryName;
  final bool isHomeScreen;
  final String? imgId;
  final VoidCallback? onAddTap;

  const CodeLockEmptyState({
    Key? key,
    required this.categoryName,
    this.isHomeScreen = false,
    this.imgId,
    this.onAddTap,
  }) : super(key: key);

  EmptyStateDetails _getDetails() {
    if (isHomeScreen) {
      return EmptyStateDetails(
        Icons.folder_open_outlined,
        'No Categories Added',
        'Create categories to organize your secure data.',
        'Tap the + button below to add your first category.',
      );
    }
    
    String lower = categoryName.toLowerCase();
    
    if (lower.contains('passport')) {
      return EmptyStateDetails(
        Icons.flight_takeoff_outlined,
        'No Passport Added',
        'Keep your passport details safe and organized.',
        'Tap the + button below to add your first passport.',
      );
    } else if (lower.contains('bank')) {
      return EmptyStateDetails(
        Icons.account_balance_outlined,
        'No Bank Accounts',
        'Securely save your bank account information.',
        'Tap the + button below to add your first bank account.',
      );
    } else if (lower.contains('tax')) {
      return EmptyStateDetails(
        Icons.receipt_long_outlined,
        'No Tax Records',
        'Store your tax information securely.',
        'Tap the + button below to add your first tax record.',
      );
    } else if (lower.contains('email')) {
      return EmptyStateDetails(
        Icons.email_outlined,
        'No Email Accounts',
        'Keep your email account details organized.',
        'Tap the + button below to add your first email account.',
      );
    } else if (lower.contains('car')) {
      return EmptyStateDetails(
        Icons.directions_car_outlined,
        'No Cars Added',
        'Manage your vehicle information securely.',
        'Tap the + button below to add your first vehicle.',
      );
    } else if (lower.contains('computer')) {
      return EmptyStateDetails(
        Icons.computer_outlined,
        'No Computer Records',
        'Store your computer details safely.',
        'Tap the + button below to add your first computer.',
      );
    } else if (lower.contains('license')) {
      return EmptyStateDetails(
        Icons.badge_outlined,
        'No License Added',
        'Keep your license information secure.',
        'Tap the + button below to add your first license.',
      );
    } else if (lower.contains('certificate')) {
      return EmptyStateDetails(
        Icons.card_membership_outlined,
        'No Certificates Added',
        'Store your certificates securely.',
        'Tap the + button below to add your first certificate.',
      );
    }
    
    // Default fallback
    return EmptyStateDetails(
      Icons.folder_open_outlined,
      'No Data Added',
      'Store and manage your secure information.',
      'Tap the + button below to add your first entry.',
    );
  }

  @override
  Widget build(BuildContext context) {
    var details = _getDetails();
    
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.easeOut,
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: CodeLockColor.accentVibrant.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CodeLockColor.accentVibrant.withValues(alpha: 0.25),
                    width: 1.0,
                  ),
                ),
                child: imgId != null
                    ? Image(
                        image: AssetImage(listOfIcon(imgId)),
                        width: 72,
                        height: 72,
                        color: CodeLockColor.accentVibrant,
                      )
                    : Icon(
                        details.icon,
                        size: 72,
                        color: CodeLockColor.accentVibrant,
                      ),
              ),
              const SizedBox(height: 24),
              Text(
                details.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CodeLockColor.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                details.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CodeLockColor.white.withValues(alpha: 0.7),
                  fontSize: 17,
                  fontWeight: FontWeight.w500, // Medium
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              if (onAddTap != null)
                ElevatedButton.icon(
                  onPressed: onAddTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CodeLockColor.accentVibrant,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.add, size: 24),
                  label: Text(
                    isHomeScreen ? "Add Category" : "Add ${categoryName.replaceAll(RegExp(r's$'), '')}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              else
                Text(
                  details.instruction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CodeLockColor.white.withValues(alpha: 0.55),
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyStateDetails {
  final IconData icon;
  final String title;
  final String description;
  final String instruction;

  EmptyStateDetails(this.icon, this.title, this.description, this.instruction);
}
