
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>(
  (ref){
    final step1 = ref.watch(nowPlayingMovieProvider).isEmpty;
    final step2 = ref.watch(popularMovieProvider).isEmpty;
    final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
    final step4 = ref.watch(topRateMoviesProvider).isEmpty;
   

    if(step1 || step2 || step3 ||step4) return true;

    return false;

  }
);