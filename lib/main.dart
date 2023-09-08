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

      double latitudePerPixel =
          (southWest.latitude - northEast.latitude) / 3000.0;
      double longitudePerPixel =
          (southWest.longitude - northEast.longitude) / 3000.0;

      int x = 2000; // Example pixel coordinate
      int y = 2000;

      double latitude = northEast.latitude + (y * latitudePerPixel);
      double longitude = northEast.longitude + (x * longitudePerPixel);

      LatLngBounds latLngBonds = LatLngBounds(northEast, southWest);
      MapOptions mapOptions = MapOptions(
          center: LatLng(latitude, longitude),
          // onTap: (position, coordinates) {},
          // crs: con,
          // boundsOptions: FitBoundsOptions()
          // screenSize: Size(MediaQuery.of(context).size.width,
          //     MediaQuery.of(context).size.height),
          minZoom: 4,
          maxZoom: 4,
          zoom: 4,
          maxBounds: latLngBonds
          // bounds: latLngBonds,
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
        LatLng(latitude / 2049.5, longitude / 1568),
        LatLng(latitude / 2048, longitude / 1584.5),
        LatLng(latitude / 2028, longitude / 1621),
        LatLng(latitude / 1982, longitude / 1697),
        LatLng(latitude / 1947, longitude / 1746.5),
        LatLng(latitude / 1924, longitude / 1750),
        LatLng(latitude / 1916.75, longitude / 1756.5),
        LatLng(latitude / 1921.03, longitude / 1779.46),
        LatLng(latitude / 1858.56, longitude / 1845.93),
        LatLng(latitude / 1803.53, longitude / 1896.97),
        LatLng(latitude / 1763.5, longitude / 1901),
        LatLng(latitude / 1715.5, longitude / 1870),
        LatLng(latitude / 1673.5, longitude / 1844),
        LatLng(latitude / 1604, longitude / 1799),
        LatLng(latitude / 1562, longitude / 1772),
        LatLng(latitude / 1429, longitude / 1687),
        LatLng(latitude / 1423.5, longitude / 1651.5),
        LatLng(latitude / 1543.5, longitude / 1489),
        LatLng(latitude / 1564, longitude / 1485),
        LatLng(latitude / 1572, longitude / 1475),
        LatLng(latitude / 1569.92, longitude / 1453.6),
        LatLng(latitude / 1691, longitude / 1301.5),
        LatLng(latitude / 1692.75, longitude / 1300),
        LatLng(latitude / 1696.5, longitude / 1298),
        LatLng(latitude / 1700.75, longitude / 1297.25),
        LatLng(latitude / 1707.25, longitude / 1296.5),
        LatLng(latitude / 1713.25, longitude / 1298.25),
        LatLng(latitude / 1727.5, longitude / 1309.75),
        LatLng(latitude / 1769.25, longitude / 1342),

        LatLng(latitude / 1817.5, longitude / 1379),
        LatLng(latitude / 1942.25, longitude / 1475.5),
        LatLng(latitude / 2043, longitude / 1553.75),
        LatLng(latitude / 2048.25, longitude / 1559),
        LatLng(latitude / 2049.25, longitude / 1563.75),
        // const LatLng(3000/1572, 3000/1475),
        // const LatLng(30.5, 0.09), // Point A
        // const LatLng(
        //     40.3498, 0.09), // Point B (Adjusting longitude to match point A)
        // const LatLng(
        //     40.3498, 20.0), // Point C (Adjusting latitude to create a square)
        // const LatLng(
        //     30.5, 20.0), // Point D (Adjusting longitude to match point A)
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
                label: 'Test',
                points: filledPoints,
                isFilled: true,
                color: Colors.red,
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
