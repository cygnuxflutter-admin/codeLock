import 'package:flutter/material.dart';
import 'package:code_lock/preferences/shared_pref.dart';
class CodeLockColor {
  static bool isDark = LocalData.getIsDarkMode ?? true;
  
  // Original colors (converted to getters if they need dynamic behavior)
  static Color get darkblue => isDark ? const Color(0xff2D3243) : const Color(0xffE2E8F0);
  static Color get blue => Colors.blue;
  
  // This is a trick: in light mode, text that expects 'white' should turn 'black'
  static Color get white => isDark ? Colors.white : const Color(0xff1A1C29);
  
  static Color get red => Colors.red;
  static Color get black => isDark ? Colors.black : Colors.white;
  static Color get dropdown => const Color(0xffD9D9D9);
  static Color get grey => Colors.grey;
  static Color get gray => isDark ? const Color(0xff73757E) : const Color(0xff94A3B8);
  static Color get homelist => isDark ? const Color(0xff3C4253) : const Color(0xffFFFFFF);
  static Color get homelistback => isDark ? const Color(0xffFFFFFF) : const Color(0xffF1F5F9);
  static Color get homeback => isDark ? const Color(0xffF2F2F7) : const Color(0xffE2E8F0);
  static Color get listiconcolor => isDark ? const Color(0xff3C4253) : const Color(0xff64748B);
  static Color get hinttext => isDark ? const Color(0xff63656D) : const Color(0xff94A3B8);
  static Color get infoText => isDark ? const Color(0xff6F6F6F) : const Color(0xff475569);
  static Color get ccwhite => isDark ? const Color(0xffDFDFE3) : const Color(0xff94A3B8);
  static Color get checkBox => isDark ? const Color(0xffC2C2C6) : const Color(0xffCBD5E1);
  static Color get green => Colors.green;
  static Color get black87 => Colors.black87;

  // Premium UI Redesign Colors
  static Color get bgGradientStart => isDark ? const Color(0xff161B29) : const Color(0xffF8FAFC);
  static Color get bgGradientEnd => isDark ? const Color(0xff0A0C13) : const Color(0xffE2E8F0);
  
  static Color get glassBg => isDark 
      ? Colors.white.withOpacity(0.08) 
      : Colors.white; // Solid white in light mode
      
  static Color get glassBorder => isDark 
      ? Colors.white.withOpacity(0.15) 
      : const Color(0xFFE8EAF2); // Subtle border/divider for light mode
      
  static Color get accentVibrant => const Color(0xff4F46E5); // Modern indigo accent remains same
}
