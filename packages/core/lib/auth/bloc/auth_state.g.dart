// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      status: $enumDecode(_$AuthStatusEnumMap, json['status']),
      message: json['message'] as String?,
      type: $enumDecodeNullable(_$ErrorTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'message': instance.message,
      'type': _$ErrorTypeEnumMap[instance.type],
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.unauthenticated: 'unauthenticated',
  AuthStatus.manyTried: 'manyTried',
  AuthStatus.error: 'error',
};

const _$ErrorTypeEnumMap = {
  ErrorType.manyTried: 'manyTried',
  ErrorType.error: 'error',
};
