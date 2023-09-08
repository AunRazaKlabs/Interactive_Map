import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InteractiveMap(),
    );
  }
}

class InteractiveMap extends StatelessWidget {
  const InteractiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterMap flutterMap() {
      // double imageHeight = 3000.0;
      // double imageWidth = 3000.0;

      LatLng northEast = const LatLng(0, 0.0);
      LatLng southWest = const LatLng(90.0, 180.0);

      LatLngBounds latLngBonds = LatLngBounds(northEast, southWest);
      MapOptions mapOptions = MapOptions(
        // center:  LatLng(0, northEast.longitude),
        // onTap: (position, coordinates) {},
        // crs: con,
        // boundsOptions: FitBoundsOptions()
        adaptiveBoundaries: false,
        screenSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        minZoom: 1,
        maxZoom: 4,
        bounds: latLngBonds,
        // crs: CrsSimple(),/
      );

      var overlayImages = <OverlayImage>[
        OverlayImage(
          bounds: latLngBonds,
          opacity: 1,
          imageProvider:
              const AssetImage('assets/map_images/deerat-outer.jpeg'),
          // imageProvider:
          //     const AssetImage('assets/map_images/almasyyanmap-white2.jpg'),
        ),
      ];
      final filledPoints = <LatLng>[
        const LatLng(30.5, 0.09), // Point A
        const LatLng(
            40.3498, 0.09), // Point B (Adjusting longitude to match point A)
        const LatLng(
            40.3498, 10.0), // Point C (Adjusting latitude to create a square)
        const LatLng(
            30.5, 10.0), // Point D (Adjusting longitude to match point A)
      ];
      return FlutterMap(
        options: mapOptions,
        nonRotatedChildren: [
          // TileLayer(
          //   tileProvider: (),
          //   maxZoom: 22,
          //   backgroundColor: Colors.red,
          // urlTemplate: 'assets/map_images/almasyyanmap-white2.jpg',
          //   urlTemplate:
          //       'https://cdn.pixabay.com/photo/2017/10/31/09/55/dream-job-2904780_1280.jpg',
          // ),
          OverlayImageLayer(
            overlayImages: overlayImages,
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                points: filledPoints,
                isFilled: true,
                color: Colors.purple,
                // borderColor: Colors.yellow,
                // borderStrokeWidth: 4,
              ),
            ],
          ),
        ],
      );
    }

    return flutterMap();
    // return FlutterMap(
    //   options: MapOptions(
    //     center: const LatLng(26.24028, 50.65392),
    //     onTap: (position, coordinates) {
    //       debugPrint(position.toString());
    //       debugPrint(coordinates.toString());
    //     },
    //     maxZoom: 22,
    //     zoom: 22,
    //   ),
    //   children: [
    //     TileLayer(
    //       tileProvider: NetworkTileProvider(),
    //       maxZoom: 22,
    //       backgroundColor: Colors.red,
    //       // urlTemplate: 'assets/map_images/almasyyanmap-white2.jpg',
    //       urlTemplate:
    //           'https://cdn.pixabay.com/photo/2017/10/31/09/55/dream-job-2904780_1280.jpg',
    //     ),
    //     OverlayImageLayer(
    //       overlayImages: <OverlayImage>[
    //         OverlayImage(
    //           bounds: LatLngBounds(const LatLng(90, 150), const LatLng(90, 0)),
    //           opacity: 1,
    //           imageProvider:
    //               const AssetImage('assets/map_images/almasyyanmap-white2.jpg'),
    //         ),
    //       ],
    //     )
    // TileLayer(
    //   urlTemplate: 'assets/map_images/almasyyanmap-white2.jpg',
    //   userAgentPackageName: 'com.example.app',
    // ),
    // CircleLayer(
    //   circles: [
    //     CircleMarker(
    //       point: const LatLng(26.24028, 50.65392),
    //       radius: 3,
    //       useRadiusInMeter: true,
    //     ),
    //   ],
    // ),
    // PolygonLayer(
    //   polygons: [
    //     Polygon(
    //       points: [
    //         const LatLng(30, 40),
    //         const LatLng(20, 50),
    //         const LatLng(25, 45)
    //       ],
    //       color: Colors.blue,
    //       isFilled: true,
    //     ),
    //   ],
    // ),
    //   ],
    // );
  }
}
