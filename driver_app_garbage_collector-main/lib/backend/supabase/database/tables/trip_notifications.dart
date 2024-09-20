import '../database.dart';

class TripNotificationsTable extends SupabaseTable<TripNotificationsRow> {
  @override
  String get tableName => 'trip_notifications';

  @override
  TripNotificationsRow createRow(Map<String, dynamic> data) =>
      TripNotificationsRow(data);
}

class TripNotificationsRow extends SupabaseDataRow {
  TripNotificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TripNotificationsTable();

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  String get tripId => getField<String>('trip_id')!;
  set tripId(String value) => setField<String>('trip_id', value);

  bool get seen => getField<bool>('seen')!;
  set seen(bool value) => setField<bool>('seen', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);
}
