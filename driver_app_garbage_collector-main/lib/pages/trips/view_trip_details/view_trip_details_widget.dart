import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'view_trip_details_model.dart';
export 'view_trip_details_model.dart';

class ViewTripDetailsWidget extends StatefulWidget {
  const ViewTripDetailsWidget({
    super.key,
    required this.tripId,
  });

  final String? tripId;

  @override
  State<ViewTripDetailsWidget> createState() => _ViewTripDetailsWidgetState();
}

class _ViewTripDetailsWidgetState extends State<ViewTripDetailsWidget> {
  late ViewTripDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewTripDetailsModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
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
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            currentUserLocationValue =
                await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
            await TripsTable().update(
              data: {
                'status': 'completed',
                'completed_at': supaSerialize<DateTime>(getCurrentTimestamp),
                'driver_location':
                    functions.convertLatLangToJson(currentUserLocationValue),
                'updated_at': supaSerialize<DateTime>(getCurrentTimestamp),
              },
              matchingRows: (rows) => rows
                  .eq(
                    'id',
                    widget.tripId,
                  )
                  .eq(
                    'driver_id',
                    currentUserUid,
                  ),
            );
            if (_model.updatedTripData?.first?.id != null &&
                _model.updatedTripData?.first?.id != '') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Trip is completed ',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  duration: Duration(milliseconds: 4000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
            } else {
              setState(() {
                FFAppState().TripStarted = false;
                FFAppState().LiveTripId = '';
              });

              context.goNamed('HomePage');
            }

            FFAppState().clearFetchDriverPendingTripsCache();
            FFAppState().clearFetchDriverTripsCache();

            setState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: FaIcon(
            FontAwesomeIcons.clock,
          ),
          elevation: 8.0,
          label: Text(
            'Complete Trip',
            style: FlutterFlowTheme.of(context).titleMedium,
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Trip Details',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (widget.tripId == null || widget.tripId == '')
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Tripid is not passed',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ),
                    ),
                  ),
                if (widget.tripId != null && widget.tripId != '')
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Builder(builder: (context) {
                          final _googleMapMarker = currentUserLocationValue;
                          return FlutterFlowGoogleMap(
                            controller: _model.googleMapsController,
                            onCameraIdle: (latLng) =>
                                _model.googleMapsCenter = latLng,
                            initialLocation: _model.googleMapsCenter ??=
                                currentUserLocationValue!,
                            markers: [
                              if (_googleMapMarker != null)
                                FlutterFlowMarker(
                                  _googleMapMarker.serialize(),
                                  _googleMapMarker,
                                ),
                            ],
                            markerColor: GoogleMarkerColor.violet,
                            mapType: MapType.normal,
                            style: GoogleMapStyle.standard,
                            initialZoom: 14.0,
                            allowInteraction: true,
                            allowZoom: true,
                            showZoomControls: true,
                            showLocation: true,
                            showCompass: false,
                            showMapToolbar: false,
                            showTraffic: false,
                            centerMapOnMarkerTap: true,
                          );
                        }),
                        PointerInterceptor(
                          intercepting: isWeb,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: custom_widgets.LocationFetcherWidget(
                              width: double.infinity,
                              height: double.infinity,
                              refreshSeconds: 30,
                              onLocationChanged:
                                  (newLocation, errorMessage) async {
                                currentUserLocationValue =
                                    await getCurrentUserLocation(
                                        defaultLocation: LatLng(0.0, 0.0));
                                if (errorMessage != null &&
                                    errorMessage != '') {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Errors'),
                                        content: Text(errorMessage!),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  _model.updatedTripInfoCopy2 =
                                      await TripsTable().update(
                                    data: {
                                      'driver_location':
                                          functions.convertLatLangToJson(
                                              currentUserLocationValue),
                                      'updated_at': supaSerialize<DateTime>(
                                          getCurrentTimestamp),
                                    },
                                    matchingRows: (rows) => rows
                                        .eq(
                                          'id',
                                          widget.tripId,
                                        )
                                        .eq(
                                          'driver_id',
                                          currentUserUid,
                                        ),
                                    returnRows: true,
                                  );
                                }

                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: PointerInterceptor(
                            intercepting: isWeb,
                            child: Text(
                              (String input) {
                                return input.substring(0, input.indexOf('-'));
                              }(widget.tripId!),
                              style: FlutterFlowTheme.of(context).headlineLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
