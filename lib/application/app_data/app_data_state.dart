part of 'app_data_bloc.dart';

class AppDataState with EquatableMixin {
  final TestData? test1data;
  final TestData? test2data;
  final TestData? test3data;
  final TestData? test4data;
  final TestData? test5data;
  final TestData? test6data;
  final TestData? test7data;
  final TestData? test8data;
  final TestData? test9data;

  const AppDataState({
    this.test1data,
    this.test2data,
    this.test3data,
    this.test4data,
    this.test5data,
    this.test6data,
    this.test7data,
    this.test8data,
    this.test9data,
  });

  AppDataState copyWith({
    TestData? test1data,
    TestData? test2data,
    TestData? test3data,
    TestData? test4data,
    TestData? test5data,
    TestData? test6data,
    TestData? test7data,
    TestData? test8data,
    TestData? test9data,
  }) {
    return AppDataState(
      test1data: test1data ?? this.test1data,
      test2data: test2data ?? this.test2data,
      test3data: test3data ?? this.test3data,
      test4data: test4data ?? this.test4data,
      test5data: test5data ?? this.test5data,
      test6data: test6data ?? this.test6data,
      test7data: test7data ?? this.test7data,
      test8data: test8data ?? this.test8data,
      test9data: test9data ?? this.test9data,
    );
  }

  @override
  List<Object?> get props => [
        test9data,
        test8data,
        test7data,
        test6data,
        test5data,
        test4data,
        test3data,
        test2data,
        test1data,
      ];
}
