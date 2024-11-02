import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrels_box_2/features/settings/presentation/pages/settings_page.dart';

import '../../features/widgets/app_widgets.dart';
import '../../features/screens.dart';
import '../../features/util/logger/app_logger.dart';

final appRouter = GoRouter(
    initialLocation: '/authentication', routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          return SkeletonAppWidget(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'home',
            path: '/',
            builder: (context, state) => HomePage(),
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
                        /*routes: [
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
                        ],*/
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
                name: 'settings',
                path: 'settings',
                builder: (context, state) => const SettingsPage(),
              ),
              GoRoute(
                name: 'downloads',
                path: 'downloads',
                builder: (context, state) => const DownloadsPage(),
              ),
              GoRoute(
                name: 'comingSoon',
                path: 'coming-soon',
                builder: (context, state) => const ComingSoonPage(),
              ),
            ],
          ), // End Home
        ]
      ),
      GoRoute(
        name: 'authentication',
        path: '/authentication',
        builder: (context, state) => const AuthenticationPage(),
        routes: [
          GoRoute(
            name: 'signUp',
            path: 'sign-up',
            builder: (context, state) => const SignUpPage(),
          ),
        ],
      ),
      GoRoute(
        name: 'item',
        path: '/:itemId/specifications',
        builder: (context, state) => ItemSpecificationsPage(
            itemId: state.pathParameters['itemId']!,
            itemName: state.uri.queryParameters['itemName']!,
            sectionName: state.uri.queryParameters['sectionName']!,
            boxName: state.uri.queryParameters['boxName']!),
      ),
      GoRoute(
        name: 'camera',
        path: '/camera',
        builder: (context, state) => TakePictureScreen(
          camera: state.extra as CameraDescription,
        ),
      ),
    ]
);

class RouterCubit extends Cubit<GoRouter> {
  final CameraDescription camera;

  RouterCubit({required this.camera}) : super(appRouter);

  void goBack() => state.pop();

  void goBackValueString(String value) {
    return state.pop(value);
  }

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

  void goSettings(){
    state.goNamed('settings');
  }

  Future<String?> goCamera() async {
    try {
      final String? value = await state.pushNamed('camera', extra: camera);
      return value;
    } catch (e) {
      AppLogger.error('Error to obtain return value: $e');
      return null;
    }
  }

  void goComingSoon() {
    state.goNamed('comingSoon');
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
        queryParameters: {'boxName': boxName});
  }

  void goItems(String sectionId, String sectionName) {
    state.goNamed('items', pathParameters: {
      'boxId':
          state.routerDelegate.currentConfiguration.pathParameters['boxId']!,
      'sectionId': sectionId
    }, queryParameters: {
      'boxName': state
          .routerDelegate.currentConfiguration.uri.queryParameters['boxName']!,
      'sectionName': sectionName
    });
  }

  void goItemSpecifications(String itemId, String itemName) {
    state.pushNamed('item',
        pathParameters: {
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
