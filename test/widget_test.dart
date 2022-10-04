// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_controller_test.mocks.dart';

@GenerateMocks([MainRepository, UserModel])
void main() {
  late MockMainRepository mockRepo;
  setUp(() {
    Get.reset();
    mockRepo = MockMainRepository();

    Get.put<MainRepository>(mockRepo);
  });

  test('Controller will load empty list when initialized', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => []);
    final controller = Get.put(MainController());

    expect(controller.users.length, 0);
    verify(mockRepo.getAllUsers()).called(1);
  });

  test('Controller will load one user', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => [
          UserModel(
              id: 1,
              isEdit: true,
              rol: 'Arellano',
              codigo: 'Taipei',
              nombres: 'https://..',
              createdTime: DateTime.now()),
        ]);
    final controller = Get.put(MainController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.users.length, 1);
  });

  test('Controller will load one user: test 2', () async {
    when(mockRepo.getAllUsers())
        .thenAnswer((_) async => [MockUser(), MockUser(), MockUser()]);
    final controller = Get.put(MainController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.users.length, 3);
  });

  test('Get new user will add a new user correctly', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => [MockUser()]);
    when(mockRepo.getNewUser()).thenAnswer((_) async => MockUser());

    final controller = Get.put(MainController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before adding
    expect(controller.users.length, 1);

    // Adding
    await controller.getUser();
    expect(controller.users.length, 2);
  });

  test('Delete users works correctly', () async {
    final userToDelete = MockUser();
    when(mockRepo.getAllUsers())
        .thenAnswer((_) async => [MockUser(), MockUser(), userToDelete]);
    when(mockRepo.deleteUser(any!)).thenAnswer((_) async => true);

    final controller = Get.put(MainController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before delete
    expect(controller.users.length, 3);
    expect(controller.users, contains(userToDelete));

    // deleting
    await controller.deleteUser(userToDelete);
    expect(controller.users.length, 2);
    expect(controller.users, isNot(contains(userToDelete)));
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
