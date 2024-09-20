// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//

import 'package:geolocator/geolocator.dart';

class LocationFetcherWidget extends StatefulWidget {
  const LocationFetcherWidget({
    super.key,
    this.width,
    this.height,
    this.onLocationChanged,
    required this.refreshSeconds,
  });

  final double? width;
  final double? height;
  final Future Function(LatLng? newLocation, String? errorMessage)?
      onLocationChanged;
  final int refreshSeconds;

  @override
  State<LocationFetcherWidget> createState() => _LocationFetcherWidgetState();
}

class _LocationFetcherWidgetState extends State<LocationFetcherWidget> {
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      widget.onLocationChanged?.call(null, "GPS is disabled");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        widget.onLocationChanged?.call(null, "GPS permission denied");
        return;
      }
    }

    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
      widget.onLocationChanged
          ?.call(LatLng(position.latitude, position.longitude), null);

      Future.delayed(Duration(seconds: widget.refreshSeconds), () {
        _getLocation();
      });
    } catch (e) {
      widget.onLocationChanged?.call(null, "Error getting location");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
