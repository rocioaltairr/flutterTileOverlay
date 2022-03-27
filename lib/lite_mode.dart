import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'page.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(25.2, 121.3), zoom: 15.0);

class LiteModePage extends GoogleMapExampleAppPage {
  const LiteModePage() : super(const Icon(Icons.map), 'Lite mode');

  @override
  Widget build(BuildContext context) {
    return const _LiteModeBody();
  }
}

class _LiteModeBody extends StatelessWidget {
  const _LiteModeBody();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 500.0,
            child: GoogleMap(
              initialCameraPosition: _kInitialPosition,
              liteModeEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}
