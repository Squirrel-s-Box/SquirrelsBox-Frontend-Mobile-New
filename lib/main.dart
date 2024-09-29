import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squirrels_box_2/features/management/presentation/blocs/box/box_bloc.dart';
import 'package:squirrels_box_2/features/management/services/box_service.dart';
import 'package:squirrels_box_2/features/management/services/item_specification_service.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'features/authentication/services/session_service.dart';
import 'features/management/presentation/blocs/item/item_bloc.dart';
import 'features/management/presentation/blocs/item_specification/item_specification_bloc.dart';
import 'features/management/presentation/blocs/section/section_bloc.dart';
import 'features/management/services/item_service.dart';
import 'features/management/services/section_service.dart';


Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(BlocsProviders(camera: firstCamera));
}

class BlocsProviders extends StatelessWidget {
  final CameraDescription camera;
  const BlocsProviders({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RouterCubit(camera: camera)),
        BlocProvider(create: (context) => AuthenticationBloc(service: SessionService())),
        BlocProvider(create: (context) => SignUpBloc(service: SessionService())),
        BlocProvider(create: (context) => BoxBloc(boxService: BoxService())),
        BlocProvider(create: (context) => SectionBloc(sectionService: SectionService())),
        BlocProvider(create: (context) => ItemBloc(itemService: ItemService())),
        BlocProvider(create: (context) => ItemSpecificationBloc(specService: ItemSpecificationService())),
      ],
      child: const MyApp()
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final appRouter = context.watch<RouterCubit>().state;

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port)=> true;
  }
}