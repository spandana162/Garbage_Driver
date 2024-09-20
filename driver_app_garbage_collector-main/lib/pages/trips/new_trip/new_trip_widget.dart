import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_trip_model.dart';
export 'new_trip_model.dart';

class NewTripWidget extends StatefulWidget {
  const NewTripWidget({super.key});

  @override
  State<NewTripWidget> createState() => _NewTripWidgetState();
}

class _NewTripWidgetState extends State<NewTripWidget> {
  late NewTripModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewTripModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.pendingTrips = await TripsTable().queryRows(
        queryFn: (q) => q
            .eq(
              'driver_id',
              currentUserUid,
            )
            .eq(
              'status',
              'started',
            )
            .order('started_at'),
      );
      if (_model.pendingTrips!.length >= 1) {
        context.pushNamed(
          'ViewTripDetails',
          queryParameters: {
            'tripId': serializeParam(
              _model.pendingTrips?.first?.id,
              ParamType.String,
            ),
          }.withoutNulls,
        );
      } else {
        _model.newTrip = await TripsTable().insert({
          'driver_id': currentUserUid,
          'status': 'started',
          'scheduled_at': supaSerialize<DateTime>(getCurrentTimestamp),
          'started_at': supaSerialize<DateTime>(getCurrentTimestamp),
          'driver_location': getJsonField(
            <String, dynamic>{
              'location': currentUserLocationValue,
            },
            r'''$["location"]''',
          ),
        });
        if (_model.newTrip?.id != null && _model.newTrip?.id != '') {
          context.pushNamed(
            'ViewTripDetails',
            queryParameters: {
              'tripId': serializeParam(
                _model.newTrip?.id,
                ParamType.String,
              ),
            }.withoutNulls,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Trip creation failed',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).accent1,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).alternate,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Trip',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
