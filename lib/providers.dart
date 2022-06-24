import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/notifier.dart';

final iconSizeProvider =
    StateNotifierProvider.autoDispose<IconColorSize, IconColor>(
  (ref) => IconColorSize(),
);
