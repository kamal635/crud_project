// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodosPage {

 List<Todo> get todos; int get total; int get skip; int get limit;
/// Create a copy of TodosPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodosPageCopyWith<TodosPage> get copyWith => _$TodosPageCopyWithImpl<TodosPage>(this as TodosPage, _$identity);

  /// Serializes this TodosPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodosPage&&const DeepCollectionEquality().equals(other.todos, todos)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(todos),total,skip,limit);

@override
String toString() {
  return 'TodosPage(todos: $todos, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $TodosPageCopyWith<$Res>  {
  factory $TodosPageCopyWith(TodosPage value, $Res Function(TodosPage) _then) = _$TodosPageCopyWithImpl;
@useResult
$Res call({
 List<Todo> todos, int total, int skip, int limit
});




}
/// @nodoc
class _$TodosPageCopyWithImpl<$Res>
    implements $TodosPageCopyWith<$Res> {
  _$TodosPageCopyWithImpl(this._self, this._then);

  final TodosPage _self;
  final $Res Function(TodosPage) _then;

/// Create a copy of TodosPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todos = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_self.copyWith(
todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TodosPage].
extension TodosPagePatterns on TodosPage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodosPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodosPage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodosPage value)  $default,){
final _that = this;
switch (_that) {
case _TodosPage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodosPage value)?  $default,){
final _that = this;
switch (_that) {
case _TodosPage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Todo> todos,  int total,  int skip,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodosPage() when $default != null:
return $default(_that.todos,_that.total,_that.skip,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Todo> todos,  int total,  int skip,  int limit)  $default,) {final _that = this;
switch (_that) {
case _TodosPage():
return $default(_that.todos,_that.total,_that.skip,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Todo> todos,  int total,  int skip,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _TodosPage() when $default != null:
return $default(_that.todos,_that.total,_that.skip,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodosPage implements TodosPage {
  const _TodosPage({final  List<Todo> todos = const <Todo>[], required this.total, required this.skip, required this.limit}): _todos = todos;
  factory _TodosPage.fromJson(Map<String, dynamic> json) => _$TodosPageFromJson(json);

 final  List<Todo> _todos;
@override@JsonKey() List<Todo> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}

@override final  int total;
@override final  int skip;
@override final  int limit;

/// Create a copy of TodosPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodosPageCopyWith<_TodosPage> get copyWith => __$TodosPageCopyWithImpl<_TodosPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodosPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodosPage&&const DeepCollectionEquality().equals(other._todos, _todos)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_todos),total,skip,limit);

@override
String toString() {
  return 'TodosPage(todos: $todos, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$TodosPageCopyWith<$Res> implements $TodosPageCopyWith<$Res> {
  factory _$TodosPageCopyWith(_TodosPage value, $Res Function(_TodosPage) _then) = __$TodosPageCopyWithImpl;
@override @useResult
$Res call({
 List<Todo> todos, int total, int skip, int limit
});




}
/// @nodoc
class __$TodosPageCopyWithImpl<$Res>
    implements _$TodosPageCopyWith<$Res> {
  __$TodosPageCopyWithImpl(this._self, this._then);

  final _TodosPage _self;
  final $Res Function(_TodosPage) _then;

/// Create a copy of TodosPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todos = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_TodosPage(
todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
