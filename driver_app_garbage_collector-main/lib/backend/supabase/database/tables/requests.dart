import '../database.dart';

class RequestsTable extends SupabaseTable<RequestsRow> {
  @override
  String get tableName => 'requests';

  @override
  RequestsRow createRow(Map<String, dynamic> data) => RequestsRow(data);
}

class RequestsRow extends SupabaseDataRow {
  RequestsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RequestsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get timestamp => getField<DateTime>('timestamp')!;
  set timestamp(DateTime value) => setField<DateTime>('timestamp', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  bool get isBiodegradable => getField<bool>('is_biodegradable')!;
  set isBiodegradable(bool value) => setField<bool>('is_biodegradable', value);

  dynamic get location => getField<dynamic>('location')!;
  set location(dynamic value) => setField<dynamic>('location', value);

  String get requestorId => getField<String>('requestor_id')!;
  set requestorId(String value) => setField<String>('requestor_id', value);

  String? get driverId => getField<String>('driver_id');
  set driverId(String? value) => setField<String>('driver_id', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  String get garbageType => getField<String>('garbage_type')!;
  set garbageType(String value) => setField<String>('garbage_type', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);
}
