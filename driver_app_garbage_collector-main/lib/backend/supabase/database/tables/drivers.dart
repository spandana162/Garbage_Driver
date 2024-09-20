import '../database.dart';

class DriversTable extends SupabaseTable<DriversRow> {
  @override
  String get tableName => 'drivers';

  @override
  DriversRow createRow(Map<String, dynamic> data) => DriversRow(data);
}

class DriversRow extends SupabaseDataRow {
  DriversRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DriversTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get fcmToken => getField<String>('fcm_token');
  set fcmToken(String? value) => setField<String>('fcm_token', value);

  String? get municipality => getField<String>('municipality');
  set municipality(String? value) => setField<String>('municipality', value);
}
