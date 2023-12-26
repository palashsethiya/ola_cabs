part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class OnMarkerChanged extends DashboardEvent {
  OnMarkerChanged(this.markers);

  final Map<MarkerId, Marker>? markers;
}

class SwitchOnlineSubmitted extends DashboardEvent {
  final bool isOnline;

  SwitchOnlineSubmitted(this.isOnline);
}
