import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/home_views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
 
 ShellRoute(
  
  builder: (context, state, child) {
    return HomeScreen(childView: child);
  },
  routes:[

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
      routes: [
          GoRoute(
          path: '/movie/:id',
          name: MovieScreen.nameRouter,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(
              movieId: movieId,
            );
          },
        ),
      ]
      
      ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesViews(),
      
      ),
  ])
 
  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.nameRouter,
  //     builder: (context, state) => const HomeScreen(),
  //     routes: [
  //       GoRoute(
  //         path: '/movie/:id',
  //         name: MovieScreen.nameRouter,
  //         builder: (context, state) {
  //           final movieId = state.pathParameters['id'] ?? 'no-id';
  //           return MovieScreen(
  //             movieId: movieId,
  //           );
  //         },
  //       ),
  //     ]),
]);
