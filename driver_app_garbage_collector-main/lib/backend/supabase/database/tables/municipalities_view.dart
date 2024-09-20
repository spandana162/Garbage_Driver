import '../database.dart';

class MunicipalitiesViewTable extends SupabaseTable<MunicipalitiesViewRow> {
  @override
  String get tableName => 'municipalities_view';

  @override
  MunicipalitiesViewRow createRow(Map<String, dynamic> data) =>
      MunicipalitiesViewRow(data);
}

class MunicipalitiesViewRow extends SupabaseDataRow {
  MunicipalitiesViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MunicipalitiesViewTable();

  String? get municipality => getField<String>('municipality');
  set municipality(String? value) => setField<String>('municipality', value);
}
