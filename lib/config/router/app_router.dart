import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/common_widgets/common_widgets.dart';
import '../../features/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/authentication',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return SkeletonAppWidget(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              name: 'favorites',
              path: 'favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
            GoRoute(
              name: 'boxes',
              path: 'boxes',
              builder: (context, state) => const BoxesPage(),
              routes: [
                GoRoute(
                  name: 'sections',
                  path: ':boxId/sections',
                  builder: (context, state) => SectionsPage(
                    boxId: state.pathParameters['boxId']!,
                    boxName: state.uri.queryParameters['boxName']!,
                  ),
                  routes: [
                    GoRoute(
                      name: 'items',
                      path: ':sectionId/items',
                      builder: (context, state) => ItemsPage(
                        sectionId: state.pathParameters['sectionId']!,
                        sectionName: state.uri.queryParameters['sectionName']!,
                        boxName: state.uri.queryParameters['boxName']!,
                      ),
                      routes: [
                        GoRoute(
                          name: 'item',
                          path: ':itemId',
                          builder: (context, state) => ItemSpecificationsPage(
                            itemId: state.pathParameters['itemId']!,
                            itemName: state.uri.queryParameters['itemName']!,
                            sectionName: state.uri.queryParameters['sectionName']!,
                            boxName: state.uri.queryParameters['boxName']!
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ), // End Boxes
            GoRoute(
              name: 'profile',
              path: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
            GoRoute(
              name: 'downloads',
              path: 'downloads',
              builder: (context, state) => const DownloadsPage(),
            ),
            GoRoute(
              name: 'camera',
              path: 'camera',
              builder: (context, state) => TakePictureScreen(
                camera: state.extra as CameraDescription,
              ),
            ),
          ],
        ), // End Home
        GoRoute(
          name: 'authentication',
          path: '/authentication',
          builder: (context, state) => const AuthenticationPage(),
        ),
      ]
    ),
  ]
);

class RouterCubit extends Cubit<GoRouter> {
  final CameraDescription camera;
  RouterCubit({required this.camera}):super(appRouter);

  void goBack() => state.pop();

  String getRouteName() {
    return state.routerDelegate.currentConfiguration.last.route.name.toString();
  }

  void goRouteName(String name) {
    state.goNamed(name);
  }

  void goHome() {
    state.goNamed('home');
  }

  void goAuthentication() {
    state.goNamed('authentication');
  }

  void goCamera() {
    state.goNamed('camera', extra: camera);
  }

  void goFavorites() {
    state.goNamed('favorites');
  }

  void goMyBoxes() {
    state.goNamed('boxes');
  }

  void goSections(String boxId, String boxName) {
    state.goNamed('sections',
      pathParameters: {'boxId': boxId},
      queryParameters: {'boxName': boxName}
    );
  }

  void goItems(String sectionId, String sectionName) {
    state.goNamed('items',
      pathParameters: {
        'boxId': state.routerDelegate.currentConfiguration.pathParameters['boxId']!,
        'sectionId': sectionId
      },
      queryParameters: {
        'boxName': state.routerDelegate.currentConfiguration.uri.queryParameters['boxName']!,
        'sectionName': sectionName
      }
    );
  }

  void goItemSpecifications(String itemId, String itemName) {
    state.goNamed('item',
        pathParameters: {
          'boxId': state.routerDelegate.currentConfiguration.pathParameters['boxId']!,
          'sectionId': state.routerDelegate.currentConfiguration.pathParameters['sectionId']!,
          'itemId': itemId,
        },
        queryParameters: {
          'boxName': state.routerDelegate.currentConfiguration.uri.queryParameters['boxName']!,
          'sectionName': state.routerDelegate.currentConfiguration.uri.queryParameters['sectionName']!,
          'itemName': itemName,
        }
    );
  }

}