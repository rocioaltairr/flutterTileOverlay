// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'page.dart';
//import 'dart:ui';
import 'package:flutter/services.dart';

class TileOverlayPage extends GoogleMapExampleAppPage {
  const TileOverlayPage() : super(const Icon(Icons.map), 'Tile overlay');

  @override
  Widget build(BuildContext context) {
    return const TileOverlayBody();
  }
}

class TileOverlayBody extends StatefulWidget {
  const TileOverlayBody();

  @override
  State<StatefulWidget> createState() => TileOverlayBodyState();
}

class TileOverlayBodyState extends State<TileOverlayBody> {
  TileOverlayBodyState();

  GoogleMapController? controller;
  TileOverlay? _tileOverlay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addTileOverlay();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addTileOverlay() {
    final TileOverlay tileOverlay = TileOverlay(
      tileOverlayId: const TileOverlayId('tile_overlay_1'),
      tileProvider: _DebugTileProvider(),
    );
    setState(() {
      _tileOverlay = tileOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<TileOverlay> overlays = <TileOverlay>{
      if (_tileOverlay != null) _tileOverlay!,
    };
    _addTileOverlay();
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(25.138948, 121.502828),
          zoom: 2.0,
        ),
        tileOverlays: overlays,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}

class _DebugTileProvider implements TileProvider {
  _DebugTileProvider() {
    boxPaint.isAntiAlias = true;
    boxPaint.color = Colors.transparent;
    boxPaint.style = PaintingStyle.stroke;
  }

  static const int width = 256;
  static const int height = 256;
  static final Paint boxPaint = Paint();
  static const TextStyle textStyle = TextStyle(
    color: Colors.red,
    fontSize: 20,
  );

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    print("getTile currentZoom $zoom");
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.red.withOpacity(0.3);
    //ui.Image images = await getAssetImage('assets/test.png');
    ui.Image images = await getAssetImage('assets/tiles/$zoom/$x/$y.png');
    paint.color = Color.fromRGBO(0, 0, 0, 0.8);
    canvas.drawImage(images, Offset(0, 0), paint);

    // String path = 'assets/tiles/$zoom/$x/$y.png';
    // bool directoryExists = await Directory(path).exists();
    // bool fileExists = await File(path).exists();
    // if (directoryExists || fileExists) {
    //   // do stuff
    // } else {
    //
    // }
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width.toDouble(), width.toDouble()), boxPaint);
    final ui.Picture picture = recorder.endRecording();
    final Uint8List byteData = await picture
        .toImage(width, height)
        .then((ui.Image image) =>
            image.toByteData(format: ui.ImageByteFormat.png))
        .then((ByteData? byteData) => byteData!.buffer.asUint8List());
    return Tile(width, height, byteData);
  }
}

Future<ui.Image> getAssetImage(String asset, {width, height}) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
