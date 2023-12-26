import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ola_cabs/dashboard/bloc/dashboard_bloc.dart';

class DashboardForm extends StatelessWidget {
  const DashboardForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Stack(
          children: [
            const _GoogleMapWidget(),
            Positioned(
              top: 40.0,
              left: 14.0,
              child: _IconWidget(icon: Icons.menu, voidCallback: () {}),
            ),
            Positioned(
              top: 40.0,
              right: 14.0,
              child: _IconWidget(icon: Icons.notifications, voidCallback: () {}),
            ),
            const _BottomSheetWidget()
          ],
        );
      },
    );
  }
}

class _IconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback voidCallback;

  const _IconWidget({required this.icon, required this.voidCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: voidCallback,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0XFF584bf8),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class _GoogleMapWidget extends StatelessWidget {
  const _GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              zoomControlsEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.751063, 75.895423),
                zoom: 17,
              ),
              markers: state.markers != null ? Set<Marker>.of(state.markers!.values) : <Marker>{},
              onMapCreated: (GoogleMapController controller) {
                context.read<DashboardBloc>().controller.complete(controller);
              },
            ),
            IgnorePointer(
                child: Container(
              color: const Color(0XFF584bf8).withOpacity(0.1),
            ))
          ],
        );
      },
    );
  }
}

class _BottomSheetWidget extends StatelessWidget {
  const _BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20.0, offset: const Offset(0, 0))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose a Ride",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                ),
                getItem(true),
                getItem(false),
                getItem(false),
                const _ApplyCouponWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                const _ActionButtonWidget()
              ],
            )));
  }

  Widget getItem(bool isSelected) {
    return GestureDetector(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.only(top: 14.0),
          decoration: BoxDecoration(
              color: isSelected ? const Color(0XFF584bf8) : Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20.0, offset: const Offset(0, 0))]),
          child: Row(
            children: [
              Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Image.asset("images/destination_icon.png")),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mini",
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            baseline: TextBaseline.alphabetic,
                            child: Icon(
                              Icons.person_4,
                              color: isSelected ? Colors.white : Colors.black,
                            )),
                        const WidgetSpan(alignment: PlaceholderAlignment.middle, baseline: TextBaseline.alphabetic, child: SizedBox(width: 8.0)),
                        TextSpan(text: "3", style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16.0)),
                      ],
                    ),
                  )
                ],
              )),
              Text(
                "₹ 200.00",
                style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
              const SizedBox(
                width: 18.0,
              ),
              Icon(
                Icons.info,
                color: isSelected ? Colors.white : Colors.black,
              )
            ],
          )),
    );
  }
}

class _ApplyCouponWidget extends StatelessWidget {
  const _ApplyCouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 14.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.5), borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        child: Row(
          children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text(
                "Apply Coupon",
                style: TextStyle(fontSize: 13.0),
              ),
            )),
            SizedBox(
              height: 40.0,
              child: TextButton(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 24.0, right: 24.0)),
                      backgroundColor: const MaterialStatePropertyAll(Color(0XFF584bf8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0))))),
                  onPressed: () {},
                  child: const Text(
                    "APPLY",
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  )),
            )
          ],
        ));
  }
}

class _ActionButtonWidget extends StatelessWidget {
  const _ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextButton(
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 24.0, right: 24.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), side: BorderSide(color: Colors.grey)))),
                onPressed: () {},
                child: const Text(
                  "Schedule",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ))),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
            child: TextButton(
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 24.0, right: 24.0)),
                    backgroundColor: const MaterialStatePropertyAll(Color(0XFF584bf8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))))),
                onPressed: () {},
                child: const Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )))
      ],
    );
  }
}
