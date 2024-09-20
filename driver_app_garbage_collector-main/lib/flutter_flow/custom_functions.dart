import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

DateTime? convertDateToIst(DateTime? input) {
  // function to convert timestampz to ist format
  if (input == null) return null;

  final utc = input.toUtc();
  final ist = utc.add(const Duration(hours: 5, minutes: 30));
  return ist;
}

dynamic convertLatLangToJson(LatLng? location) {
  // function to convert location to json
  if (location == null) return null;

  return {
    'lat': location.latitude,
    'long': location.longitude,
  };
}

LatLng? convertJsonToLatLang(dynamic jsonLocation) {
  // convert json to Location
// function to convert json to location
  if (jsonLocation == null) return null;

  final lat = jsonLocation['lat'] as double?;
  final long = jsonLocation['long'] as double?;

  if (lat == null || long == null) return null;

  return LatLng(lat, long);
}
