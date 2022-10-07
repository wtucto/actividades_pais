import 'dart:async' as _i4;

import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart'
    as _i2;
import 'package:actividades_pais/backend/repository/main_repo.dart' as _i3;

import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUser_0 extends _i1.Fake implements _i2.TramaProyectoModel {}

/// A class which mocks [MainRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMainRepository extends _i1.Mock implements _i3.MainRepository {
  MockMainRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.TramaProyectoModel> getNewUserTest() =>
      (super.noSuchMethod(Invocation.method(#getNewUser, []),
              returnValue: Future<_i2.TramaProyectoModel>.value(_FakeUser_0()))
          as _i4.Future<_i2.TramaProyectoModel>);
  @override
  _i4.Future<List<_i2.TramaProyectoModel>> getAllUsers() =>
      (super.noSuchMethod(Invocation.method(#getAllUsers, []),
              returnValue: Future<List<_i2.TramaProyectoModel>>.value(
                  <_i2.TramaProyectoModel>[]))
          as _i4.Future<List<_i2.TramaProyectoModel>>);
  @override
  _i4.Future<bool> deleteUserTest(_i2.TramaProyectoModel? toDelete) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [toDelete]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UserModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i2.TramaProyectoModel {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  String get lastName =>
      (super.noSuchMethod(Invocation.getter(#lastName), returnValue: '')
          as String);
  @override
  String get city =>
      (super.noSuchMethod(Invocation.getter(#city), returnValue: '') as String);
  @override
  Map<String, dynamic> toMapForDb() =>
      (super.noSuchMethod(Invocation.method(#toMapForDb, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toString() => super.toString();
}
