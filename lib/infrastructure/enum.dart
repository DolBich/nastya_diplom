import 'package:auto_route/auto_route.dart';
import 'package:nastya_diplom/presentation/routes/router.dart';


enum TestType {
  test1,
  test2,
  test3,
  test4,
  test5,
  test6,
  test7,
  test8,
  test9,
}

extension TestTypeX on TestType {
  String get title {
    switch (this) {
      case TestType.test1:
        return 'test 1';
      case TestType.test2:
        return 'test 2';
      case TestType.test3:
        return 'test 3';
      case TestType.test4:
        return 'test 4';
      case TestType.test5:
        return 'test 5';
      case TestType.test6:
        return 'test 6';
      case TestType.test7:
        return 'test 7';
      case TestType.test8:
        return 'test 8';
      case TestType.test9:
        return 'test 9';
    }
  }

  PageRouteInfo get testRoute { /// TODO
    switch (this) {
      case TestType.test1:
        return const Test1Route();
      case TestType.test2:
        return const Test2Route();
      case TestType.test3:
        return const Test3Route();
      case TestType.test4:
        return const Test4Route();
      case TestType.test5:
        return const Test5Route();
      case TestType.test6:
        return const Test6Route();
      case TestType.test7:
        return Test1Route();
      case TestType.test8:
        return Test1Route();
      case TestType.test9:
        return Test1Route();
    }
  }

  String get instructionText {
    switch (this) {
      case TestType.test1:
        return 'Инструкция для первого теста на внимательность...';
      case TestType.test2:
        return 'Особые указания для второго теста...';
      case TestType.test3:
        return '';
      case TestType.test4:
        return 'Test2Route()';
      case TestType.test5:
        return 'Test2Route()';
      case TestType.test6:
        return 'Test2Route()';
      case TestType.test7:
        return 'Test2Route()';
      case TestType.test8:
        return 'Test2Route()';
      case TestType.test9:
        return 'Test2Route()';
    }
  }
}