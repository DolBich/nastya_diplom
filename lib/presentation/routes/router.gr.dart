// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CustomNameScreen]
class CustomNameRoute extends PageRouteInfo<void> {
  const CustomNameRoute({List<PageRouteInfo>? children})
    : super(CustomNameRoute.name, initialChildren: children);

  static const String name = 'CustomNameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CustomNameScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [SelectionScreen]
class SelectionRoute extends PageRouteInfo<SelectionRouteArgs> {
  SelectionRoute({
    Key? key,
    SelectionState? initState,
    List<PageRouteInfo>? children,
  }) : super(
         SelectionRoute.name,
         args: SelectionRouteArgs(key: key, initState: initState),
         initialChildren: children,
       );

  static const String name = 'SelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectionRouteArgs>(
        orElse: () => const SelectionRouteArgs(),
      );
      return SelectionScreen(key: args.key, initState: args.initState);
    },
  );
}

class SelectionRouteArgs {
  const SelectionRouteArgs({this.key, this.initState});

  final Key? key;

  final SelectionState? initState;

  @override
  String toString() {
    return 'SelectionRouteArgs{key: $key, initState: $initState}';
  }
}

/// generated route for
/// [Test1Screen]
class Test1Route extends PageRouteInfo<void> {
  const Test1Route({List<PageRouteInfo>? children})
    : super(Test1Route.name, initialChildren: children);

  static const String name = 'Test1Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test1Screen();
    },
  );
}

/// generated route for
/// [Test2Screen]
class Test2Route extends PageRouteInfo<void> {
  const Test2Route({List<PageRouteInfo>? children})
    : super(Test2Route.name, initialChildren: children);

  static const String name = 'Test2Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test2Screen();
    },
  );
}

/// generated route for
/// [Test3Screen]
class Test3Route extends PageRouteInfo<void> {
  const Test3Route({List<PageRouteInfo>? children})
    : super(Test3Route.name, initialChildren: children);

  static const String name = 'Test3Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test3Screen();
    },
  );
}

/// generated route for
/// [Test4Screen]
class Test4Route extends PageRouteInfo<void> {
  const Test4Route({List<PageRouteInfo>? children})
    : super(Test4Route.name, initialChildren: children);

  static const String name = 'Test4Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test4Screen();
    },
  );
}

/// generated route for
/// [Test5Screen]
class Test5Route extends PageRouteInfo<void> {
  const Test5Route({List<PageRouteInfo>? children})
    : super(Test5Route.name, initialChildren: children);

  static const String name = 'Test5Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test5Screen();
    },
  );
}

/// generated route for
/// [Test6Screen]
class Test6Route extends PageRouteInfo<void> {
  const Test6Route({List<PageRouteInfo>? children})
    : super(Test6Route.name, initialChildren: children);

  static const String name = 'Test6Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test6Screen();
    },
  );
}

/// generated route for
/// [Test7Screen]
class Test7Route extends PageRouteInfo<void> {
  const Test7Route({List<PageRouteInfo>? children})
    : super(Test7Route.name, initialChildren: children);

  static const String name = 'Test7Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test7Screen();
    },
  );
}

/// generated route for
/// [Test8Screen]
class Test8Route extends PageRouteInfo<void> {
  const Test8Route({List<PageRouteInfo>? children})
    : super(Test8Route.name, initialChildren: children);

  static const String name = 'Test8Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test8Screen();
    },
  );
}

/// generated route for
/// [Test9Screen]
class Test9Route extends PageRouteInfo<void> {
  const Test9Route({List<PageRouteInfo>? children})
    : super(Test9Route.name, initialChildren: children);

  static const String name = 'Test9Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Test9Screen();
    },
  );
}
