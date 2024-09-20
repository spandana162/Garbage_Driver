import '../database.dart';

class UserRequestsSummaryViewTable
    extends SupabaseTable<UserRequestsSummaryViewRow> {
  @override
  String get tableName => 'user_requests_summary_view';

  @override
  UserRequestsSummaryViewRow createRow(Map<String, dynamic> data) =>
      UserRequestsSummaryViewRow(data);
}

class UserRequestsSummaryViewRow extends SupabaseDataRow {
  UserRequestsSummaryViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserRequestsSummaryViewTable();

  String? get requestorId => getField<String>('requestor_id');
  set requestorId(String? value) => setField<String>('requestor_id', value);

  int? get all => getField<int>('all');
  set all(int? value) => setField<int>('all', value);

  int? get approved => getField<int>('approved');
  set approved(int? value) => setField<int>('approved', value);

  int? get rejected => getField<int>('rejected');
  set rejected(int? value) => setField<int>('rejected', value);

  int? get pending => getField<int>('pending');
  set pending(int? value) => setField<int>('pending', value);
}
