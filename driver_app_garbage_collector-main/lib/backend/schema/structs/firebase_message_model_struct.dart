// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FirebaseMessageModelStruct extends BaseStruct {
  FirebaseMessageModelStruct({
    String? token,
    String? errorMessage,
  })  : _token = token,
        _errorMessage = errorMessage;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;
  bool hasToken() => _token != null;

  // "errorMessage" field.
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? '';
  set errorMessage(String? val) => _errorMessage = val;
  bool hasErrorMessage() => _errorMessage != null;

  static FirebaseMessageModelStruct fromMap(Map<String, dynamic> data) =>
      FirebaseMessageModelStruct(
        token: data['token'] as String?,
        errorMessage: data['errorMessage'] as String?,
      );

  static FirebaseMessageModelStruct? maybeFromMap(dynamic data) => data is Map
      ? FirebaseMessageModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'token': _token,
        'errorMessage': _errorMessage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'errorMessage': serializeParam(
          _errorMessage,
          ParamType.String,
        ),
      }.withoutNulls;

  static FirebaseMessageModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      FirebaseMessageModelStruct(
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        errorMessage: deserializeParam(
          data['errorMessage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FirebaseMessageModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FirebaseMessageModelStruct &&
        token == other.token &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => const ListEquality().hash([token, errorMessage]);
}

FirebaseMessageModelStruct createFirebaseMessageModelStruct({
  String? token,
  String? errorMessage,
}) =>
    FirebaseMessageModelStruct(
      token: token,
      errorMessage: errorMessage,
    );
