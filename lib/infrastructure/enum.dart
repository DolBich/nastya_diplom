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
        return 'Тест Торндайка';
      case TestType.test2:
        return 'Тест Шульте-Горбова (1 версия)';
      case TestType.test3:
        return 'Тест Шульте-Горбова (Версия 2)';
      case TestType.test4:
        return 'Тест Пьерона-Рузера';
      case TestType.test5:
        return 'Тест "Запомни и расставь точки"';
      case TestType.test6:
        return 'Тест "Перепутанные линии"';
      case TestType.test7:
        return 'SCAAT (Визуальная версия)';
      case TestType.test8:
        return 'Аудитивная концентрация';
      case TestType.test9:
        return 'Тест на многозадачность';
    }
  }

  PageRouteInfo get testRoute {
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
        return const Test7Route();
      case TestType.test8:
        return const Test8Route();
      case TestType.test9:
        return const Test9Route();
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