import 'dart:ui';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCell extends StatelessWidget {
  InfoCell({
    required this.TitleName,
    this.onEdit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  final String TitleName;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: context.getHeight * 0.08,
          decoration: BoxDecoration(
            color: CodeLockColor.glassBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CodeLockColor.glassBorder,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CodeLockColor.accentVibrant,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 4.5,
              ),
              SizedBox(width: context.getWidth * 0.04),
              Expanded(
                child: Text(
                  TitleName.trim().isEmpty ? "- -" : TitleName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: CodeLockColor.white, // light text
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (onEdit != null || onDelete != null)
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: CodeLockColor.isDark ? const Color(0xFF2A2D4F) : CodeLockColor.bgGradientStart,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: CodeLockColor.accentVibrant,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.description_outlined, color: Colors.white, size: 24),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      TitleName.trim().isEmpty ? "- -" : TitleName,
                                      style: TextStyle(
                                        color: CodeLockColor.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Divider(color: CodeLockColor.white.withOpacity(0.1), thickness: 1, height: 1),
                            if (onEdit != null) ...[
                              ListTile(
                                leading: Icon(Icons.edit, color: CodeLockColor.white),
                                title: Text("Edit", style: TextStyle(color: CodeLockColor.white, fontSize: 16, fontWeight: FontWeight.w500)),
                                onTap: () {
                                  Navigator.pop(context);
                                  onEdit!();
                                },
                              ),
                              Divider(color: CodeLockColor.white.withOpacity(0.1), thickness: 1, height: 1),
                            ],
                            if (onDelete != null) ...[
                              ListTile(
                                leading: const Icon(Icons.delete_outline, color: Color(0xFFFF4D4F)),
                                title: const Text("Delete", style: TextStyle(color: Color(0xFFFF4D4F), fontSize: 16, fontWeight: FontWeight.w500)),
                                onTap: () {
                                  Navigator.pop(context);
                                  onDelete!();
                                },
                              ),
                              Divider(color: CodeLockColor.white.withOpacity(0.1), thickness: 1, height: 1),
                            ],
                            ListTile(
                              leading: Icon(Icons.close, color: CodeLockColor.white.withOpacity(0.7)),
                              title: Text("Cancel", style: TextStyle(color: CodeLockColor.white.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.w500)),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white70),
                  splashRadius: 20,
                ),
              if (onEdit == null && onDelete == null) SizedBox(width: context.getWidth * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
