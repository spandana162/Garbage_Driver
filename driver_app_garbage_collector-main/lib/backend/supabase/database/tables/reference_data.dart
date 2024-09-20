import '../database.dart';

class ReferenceDataTable extends SupabaseTable<ReferenceDataRow> {
  @override
  String get tableName => 'reference_data';

  @override
  ReferenceDataRow createRow(Map<String, dynamic> data) =>
      ReferenceDataRow(data);
}

class ReferenceDataRow extends SupabaseDataRow {
  ReferenceDataRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ReferenceDataTable();

  String get key => getField<String>('key')!;
  set key(String value) => setField<String>('key', value);

  String get value => getField<String>('value')!;
  set value(String value) => setField<String>('value', value);

  String get label => getField<String>('label')!;
  set label(String value) => setField<String>('label', value);
}
