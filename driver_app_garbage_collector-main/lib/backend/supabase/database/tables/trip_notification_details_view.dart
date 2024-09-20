import '../database.dart';

class TripNotificationDetailsViewTable
    extends SupabaseTable<TripNotificationDetailsViewRow> {
  @override
  String get tableName => 'trip_notification_details_view';

  @override
  TripNotificationDetailsViewRow createRow(Map<String, dynamic> data) =>
      TripNotificationDetailsViewRow(data);
}

class TripNotificationDetailsViewRow extends SupabaseDataRow {
  TripNotificationDetailsViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TripNotificationDetailsViewTable();

  String? get tripId => getField<String>('trip_id');
  set tripId(String? value) => setField<String>('trip_id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool? get seen => getField<bool>('seen');
  set seen(bool? value) => setField<bool>('seen', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);
}
