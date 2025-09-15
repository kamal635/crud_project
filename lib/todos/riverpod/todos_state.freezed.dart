// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodosState {

 List<Todo> get items; int get total; int get skip; int get limit; bool get isLoading; String? get error;
/// Create a copy of TodosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodosStateCopyWith<TodosState> get copyWith => _$TodosStateCopyWithImpl<TodosState>(this as TodosState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodosState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,skip,limit,isLoading,error);

@override
String toString() {
  return 'TodosState(items: $items, total: $total, skip: $skip, limit: $limit, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $TodosStateCopyWith<$Res>  {
  factory $TodosStateCopyWith(TodosState value, $Res Function(TodosState) _then) = _$TodosStateCopyWithImpl;
@useResult
$Res call({
 List<Todo> items, int total, int skip, int limit, bool isLoading, String? error
});




}
/// @nodoc
class _$TodosStateCopyWithImpl<$Res>
    implements $TodosStateCopyWith<$Res> {
  _$TodosStateCopyWithImpl(this._self, this._then);

  final TodosState _self;
  final $Res Function(TodosState) _then;

/// Create a copy of TodosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? skip = null,Object? limit = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Todo>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodosState].
extension TodosStatePatterns on TodosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodosState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodosState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodosState value)  $default,){
final _that = this;
switch (_that) {
case _TodosState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodosState value)?  $default,){
final _that = this;
switch (_that) {
case _TodosState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Todo> items,  int total,  int skip,  int limit,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodosState() when $default != null:
return $default(_that.items,_that.total,_that.skip,_that.limit,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Todo> items,  int total,  int skip,  int limit,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _TodosState():
return $default(_that.items,_that.total,_that.skip,_that.limit,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Todo> items,  int total,  int skip,  int limit,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _TodosState() when $default != null:
return $default(_that.items,_that.total,_that.skip,_that.limit,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TodosState implements TodosState {
  const _TodosState({final  List<Todo> items = const <Todo>[], this.total = 0, this.skip = 0, this.limit = 20, this.isLoading = false, this.error}): _items = items;
  

 final  List<Todo> _items;
@override@JsonKey() List<Todo> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int skip;
@override@JsonKey() final  int limit;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of TodosState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodosStateCopyWith<_TodosState> get copyWith => __$TodosStateCopyWithImpl<_TodosState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodosState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,skip,limit,isLoading,error);

@override
String toString() {
  return 'TodosState(items: $items, total: $total, skip: $skip, limit: $limit, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TodosStateCopyWith<$Res> implements $TodosStateCopyWith<$Res> {
  factory _$TodosStateCopyWith(_TodosState value, $Res Function(_TodosState) _then) = __$TodosStateCopyWithImpl;
@override @useResult
$Res call({
 List<Todo> items, int total, int skip, int limit, bool isLoading, String? error
});




}
/// @nodoc
class __$TodosStateCopyWithImpl<$Res>
    implements _$TodosStateCopyWith<$Res> {
  __$TodosStateCopyWithImpl(this._self, this._then);

  final _TodosState _self;
  final $Res Function(_TodosState) _then;

/// Create a copy of TodosState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? skip = null,Object? limit = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_TodosState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Todo>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
