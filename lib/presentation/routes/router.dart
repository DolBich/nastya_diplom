import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:nastya_diplom/application/selection/selection_bloc.dart';
import 'package:nastya_diplom/presentation/screens/profile/profile_screen.dart';
import 'package:nastya_diplom/presentation/screens/selection/selection_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_1/test_1_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_2/test_2_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_3/test_3_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_4/test_4_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_5/test_5_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_6/test_6_screen.dart';
import 'package:nastya_diplom/presentation/screens/test_7/test_7_screen.dart';

export 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SelectionRoute.page,
          path: '/',
        ),

        /// TODO
        CustomRoute(
          page: Test1Route.page,
          path: '/test1',
        ),
        CustomRoute(
          page: Test2Route.page,
          path: '/test2',
        ),
        CustomRoute(
          page: Test3Route.page,
          path: '/test3',
        ),
        CustomRoute(
          page: Test4Route.page,
          path: '/test4',
        ),
        CustomRoute(
          page: Test5Route.page,
          path: '/test5',
        ),
        CustomRoute(
          page: Test6Route.page,
          path: '/test6',
        ),
        CustomRoute(
          page: Test7Route.page,
          path: '/test7',
        ),
        // CustomRoute(
        //   page: Test1Route.page,
        //   path: 'application/test8',
        // ),
        // CustomRoute(
        //   page: Test1Route.page,
        //   path: 'application/test9',
        // ),
        CustomRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
      ];
}
