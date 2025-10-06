// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_entry_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HealthEntryState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<HealthEntry> get entries => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of HealthEntryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthEntryStateCopyWith<HealthEntryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthEntryStateCopyWith<$Res> {
  factory $HealthEntryStateCopyWith(
    HealthEntryState value,
    $Res Function(HealthEntryState) then,
  ) = _$HealthEntryStateCopyWithImpl<$Res, HealthEntryState>;
  @useResult
  $Res call({bool isLoading, List<HealthEntry> entries, String? error});
}

/// @nodoc
class _$HealthEntryStateCopyWithImpl<$Res, $Val extends HealthEntryState>
    implements $HealthEntryStateCopyWith<$Res> {
  _$HealthEntryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthEntryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? entries = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<HealthEntry>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HealthEntryStateImplCopyWith<$Res>
    implements $HealthEntryStateCopyWith<$Res> {
  factory _$$HealthEntryStateImplCopyWith(
    _$HealthEntryStateImpl value,
    $Res Function(_$HealthEntryStateImpl) then,
  ) = __$$HealthEntryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<HealthEntry> entries, String? error});
}

/// @nodoc
class __$$HealthEntryStateImplCopyWithImpl<$Res>
    extends _$HealthEntryStateCopyWithImpl<$Res, _$HealthEntryStateImpl>
    implements _$$HealthEntryStateImplCopyWith<$Res> {
  __$$HealthEntryStateImplCopyWithImpl(
    _$HealthEntryStateImpl _value,
    $Res Function(_$HealthEntryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthEntryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? entries = null,
    Object? error = freezed,
  }) {
    return _then(
      _$HealthEntryStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<HealthEntry>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HealthEntryStateImpl implements _HealthEntryState {
  const _$HealthEntryStateImpl({
    this.isLoading = false,
    final List<HealthEntry> entries = const [],
    this.error,
  }) : _entries = entries;

  @override
  @JsonKey()
  final bool isLoading;
  final List<HealthEntry> _entries;
  @override
  @JsonKey()
  List<HealthEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'HealthEntryState(isLoading: $isLoading, entries: $entries, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthEntryStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_entries),
    error,
  );

  /// Create a copy of HealthEntryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthEntryStateImplCopyWith<_$HealthEntryStateImpl> get copyWith =>
      __$$HealthEntryStateImplCopyWithImpl<_$HealthEntryStateImpl>(
        this,
        _$identity,
      );
}

abstract class _HealthEntryState implements HealthEntryState {
  const factory _HealthEntryState({
    final bool isLoading,
    final List<HealthEntry> entries,
    final String? error,
  }) = _$HealthEntryStateImpl;

  @override
  bool get isLoading;
  @override
  List<HealthEntry> get entries;
  @override
  String? get error;

  /// Create a copy of HealthEntryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthEntryStateImplCopyWith<_$HealthEntryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
