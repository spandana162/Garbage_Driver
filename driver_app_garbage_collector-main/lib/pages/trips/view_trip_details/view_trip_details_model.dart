import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'view_trip_details_widget.dart' show ViewTripDetailsWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class ViewTripDetailsModel extends FlutterFlowModel<ViewTripDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Backend Call - Update Row(s)] action in LocationFetcherWidget widget.
  List<TripsRow>? updatedTripInfo;
  // Stores action output result for [Backend Call - Update Row(s)] action in LocationFetcherWidget widget.
  List<TripsRow>? updatedTripInfoCopy;
  // Stores action output result for [Backend Call - Update Row(s)] action in LocationFetcherWidget widget.
  List<TripsRow>? updatedTripInfoCopy2;
  // Stores action output result for [Backend Call - Update Row(s)] action in FloatingActionButton widget.
  List<TripsRow>? updatedTripData;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
