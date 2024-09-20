import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import 'backend/supabase/supabase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _firebasetoken =
          await secureStorage.getString('ff_firebasetoken') ?? _firebasetoken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _firebasetoken = '';
  String get firebasetoken => _firebasetoken;
  set firebasetoken(String _value) {
    _firebasetoken = _value;
    secureStorage.setString('ff_firebasetoken', _value);
  }

  void deleteFirebasetoken() {
    secureStorage.delete(key: 'ff_firebasetoken');
  }

  bool _TripStarted = false;
  bool get TripStarted => _TripStarted;
  set TripStarted(bool _value) {
    _TripStarted = _value;
  }

  String _LiveTripId = '';
  String get LiveTripId => _LiveTripId;
  set LiveTripId(String _value) {
    _LiveTripId = _value;
  }

  final _fetchUserDetailsManager = FutureRequestManager<List<DriversRow>>();
  Future<List<DriversRow>> fetchUserDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<DriversRow>> Function() requestFn,
  }) =>
      _fetchUserDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFetchUserDetailsCache() => _fetchUserDetailsManager.clear();
  void clearFetchUserDetailsCacheKey(String? uniqueKey) =>
      _fetchUserDetailsManager.clearRequest(uniqueKey);

  final _fetchDriverTripsManager = FutureRequestManager<List<TripsRow>>();
  Future<List<TripsRow>> fetchDriverTrips({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TripsRow>> Function() requestFn,
  }) =>
      _fetchDriverTripsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFetchDriverTripsCache() => _fetchDriverTripsManager.clear();
  void clearFetchDriverTripsCacheKey(String? uniqueKey) =>
      _fetchDriverTripsManager.clearRequest(uniqueKey);

  final _fetchDriverPendingTripsManager =
      FutureRequestManager<List<TripsRow>>();
  Future<List<TripsRow>> fetchDriverPendingTrips({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TripsRow>> Function() requestFn,
  }) =>
      _fetchDriverPendingTripsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFetchDriverPendingTripsCache() =>
      _fetchDriverPendingTripsManager.clear();
  void clearFetchDriverPendingTripsCacheKey(String? uniqueKey) =>
      _fetchDriverPendingTripsManager.clearRequest(uniqueKey);

  final _fetchDriverRequestsManager = FutureRequestManager<List<RequestsRow>>();
  Future<List<RequestsRow>> fetchDriverRequests({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RequestsRow>> Function() requestFn,
  }) =>
      _fetchDriverRequestsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFetchDriverRequestsCache() => _fetchDriverRequestsManager.clear();
  void clearFetchDriverRequestsCacheKey(String? uniqueKey) =>
      _fetchDriverRequestsManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
