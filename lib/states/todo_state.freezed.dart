// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TodoStateTearOff {
  const _$TodoStateTearOff();

  _TodoState call(
      {List<Todo> todos = const [],
      String publisher = '',
      int count = 0,
      String comicName = ''}) {
    return _TodoState(
      todos: todos,
      publisher: publisher,
      count: count,
      comicName: comicName,
    );
  }
}

/// @nodoc
const $TodoState = _$TodoStateTearOff();

/// @nodoc
mixin _$TodoState {
  List<Todo> get todos => throw _privateConstructorUsedError;
  String get publisher => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get comicName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoStateCopyWith<TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res>;
  $Res call({List<Todo> todos, String publisher, int count, String comicName});
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res> implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  final TodoState _value;
  // ignore: unused_field
  final $Res Function(TodoState) _then;

  @override
  $Res call({
    Object? todos = freezed,
    Object? publisher = freezed,
    Object? count = freezed,
    Object? comicName = freezed,
  }) {
    return _then(_value.copyWith(
      todos: todos == freezed
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      publisher: publisher == freezed
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      comicName: comicName == freezed
          ? _value.comicName
          : comicName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TodoStateCopyWith<$Res> implements $TodoStateCopyWith<$Res> {
  factory _$TodoStateCopyWith(
          _TodoState value, $Res Function(_TodoState) then) =
      __$TodoStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Todo> todos, String publisher, int count, String comicName});
}

/// @nodoc
class __$TodoStateCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$TodoStateCopyWith<$Res> {
  __$TodoStateCopyWithImpl(_TodoState _value, $Res Function(_TodoState) _then)
      : super(_value, (v) => _then(v as _TodoState));

  @override
  _TodoState get _value => super._value as _TodoState;

  @override
  $Res call({
    Object? todos = freezed,
    Object? publisher = freezed,
    Object? count = freezed,
    Object? comicName = freezed,
  }) {
    return _then(_TodoState(
      todos: todos == freezed
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      publisher: publisher == freezed
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      comicName: comicName == freezed
          ? _value.comicName
          : comicName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TodoState implements _TodoState {
  const _$_TodoState(
      {this.todos = const [],
      this.publisher = '',
      this.count = 0,
      this.comicName = ''});

  @JsonKey(defaultValue: const [])
  @override
  final List<Todo> todos;
  @JsonKey(defaultValue: '')
  @override
  final String publisher;
  @JsonKey(defaultValue: 0)
  @override
  final int count;
  @JsonKey(defaultValue: '')
  @override
  final String comicName;

  @override
  String toString() {
    return 'TodoState(todos: $todos, publisher: $publisher, count: $count, comicName: $comicName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoState &&
            (identical(other.todos, todos) ||
                const DeepCollectionEquality().equals(other.todos, todos)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.comicName, comicName) ||
                const DeepCollectionEquality()
                    .equals(other.comicName, comicName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(todos) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(comicName);

  @JsonKey(ignore: true)
  @override
  _$TodoStateCopyWith<_TodoState> get copyWith =>
      __$TodoStateCopyWithImpl<_TodoState>(this, _$identity);
}

abstract class _TodoState implements TodoState {
  const factory _TodoState(
      {List<Todo> todos,
      String publisher,
      int count,
      String comicName}) = _$_TodoState;

  @override
  List<Todo> get todos => throw _privateConstructorUsedError;
  @override
  String get publisher => throw _privateConstructorUsedError;
  @override
  int get count => throw _privateConstructorUsedError;
  @override
  String get comicName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodoStateCopyWith<_TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}
