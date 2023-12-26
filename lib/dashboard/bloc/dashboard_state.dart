part of 'dashboard_bloc.dart';

class DashboardState {
  Map<MarkerId, Marker>? markers = {};

  DashboardState({this.markers});

  DashboardState copyWith({Map<MarkerId, Marker>? markers}) {
    return DashboardState(markers: markers ?? this.markers);
  }
}
