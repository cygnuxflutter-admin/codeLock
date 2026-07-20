import 'package:code_lock/custom/timer_method.dart';
import 'package:code_lock/preferences/shared_pref.dart';

detectOnTap() {
  final SingletonTimer time = SingletonTimer();

  time.stopTimer();
  time.resetTimer(LocalData.getIsSec.toInt());
  print("-------------------------------------");
  print("clicked by user");
  print("-------------------------------------");
}
