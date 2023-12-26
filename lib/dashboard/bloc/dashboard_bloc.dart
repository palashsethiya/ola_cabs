import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ola_cabs/dashboard/model/CarListModel.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Map<MarkerId, Marker>? markers = {};

  DashboardBloc() : super(DashboardState()) {
    on<OnMarkerChanged>(_onMarkerChanged);

    getFirebaseData();
  }

  getFirebaseData() {
    ref.onValue.listen((DatabaseEvent event) {
      print(event.snapshot.value);
      setCarLocation(CarListModel.fromJson(json.decode(jsonEncode(event.snapshot.value))));
    });
  }

  setCarLocation(CarListModel carListModel) async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(carListModel.carOne!.icon!)).load(carListModel.carOne!.icon!)).buffer.asUint8List();
    _addMarker(LatLng(carListModel.carOne!.coordinate!.latitude!, carListModel.carOne!.coordinate!.longitude!), carListModel.carOne!.name!, BitmapDescriptor.fromBytes(bytes));
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers![markerId] = marker;
    add(OnMarkerChanged(markers));
  }

  void _onMarkerChanged(
    OnMarkerChanged event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(markers: event.markers),
    );
  }
}
