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
      final Transformation transformation = Transformation();
      LatLng northEast = transformation.transform(0, 0);
      LatLng southWest = transformation.transform(3000, 3000);

      LatLngBounds latLngBonds = LatLngBounds(northEast, southWest);
      List<List<num>> polygon = [
        [2049.5, 1568],
        [2048, 1584.5],
        [2028, 1621],
        [1982, 1697],
        [1947, 1746.5],
        [1924.5, 1750],
        [1916.75, 1756.5],
        [1921.03, 1779.46],
        [1858.56, 1845.93],
        [1803.53, 1896.97],
        [1763.5, 1901],
        [1715.5, 1870],
        [1673.5, 1844],
        [1604, 1799],
        [1562, 1772],
        [1429, 1687],
        [1423.5, 1651.5],
        [1543.5, 1489],
        [1564, 1485],
        [1572, 1475],
        [1569.92, 1453.6],
        [1691, 1301.5],
        [1692.75, 1300],
        [1696.5, 1298],
        [1700.75, 1297.25],
        [1707.25, 1296.5],
        [1713.25, 1298.25],
        [1727.5, 1309.75],
        [1769.25, 1342],
        [1817.5, 1379],
        [1942.25, 1475.5],
        [2043, 1553.75],
        [2048.25, 1559],
        [2049.25, 1563.75]
      ];
      List<LatLng> polygonLatLng = [];
      for (var point in polygon) {
        polygonLatLng.add(transformation.transform(point[0], point[1]));
      }
      MapOptions mapOptions = MapOptions(
          onTap: (position, coordinates) {
            final a1 = transformation.untransform(
                coordinates.latitude, coordinates.longitude);
            final bool isPolygon =
                transformation._pointInPolygon(a1[0], a1[1], polygon);
            debugPrint(isPolygon.toString());
          },
          // crs: con,
          // boundsOptions: FitBoundsOptions()
          // screenSize: Size(MediaQuery.of(context).size.width,
          //     MediaQuery.of(context).size.height),
          // screenSize: Size(
          //   MediaQuery.of(context).size.width,
          //   MediaQuery.of(context).size.height,
          // ),
          minZoom: 2,
          maxZoom: 4,
          zoom: 2,
          maxBounds: latLngBonds,
          // bounds: latLngBonds,
          center: transformation.transform(1500, 1500),
          crs: const Epsg4326());

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

      // lng y axis
      // final originalPoints1 = <LatLng>[
      //   transformation.transform(0, 0),
      //   transformation.transform(1500, 0),
      //   transformation.transform(3000, 3000),
      //   transformation.transform(0, 1500),
      // ];
      // final originalPoints2 = <LatLng>[
      //   transformation.transform(2049.5, 1568),
      //   transformation.transform(1982, 1697),
      //   transformation.transform(1700.75, 1297.25),
      //   transformation.transform(1572, 1475),
      //   // transformation.transform(2028, 1621),
      //   // transformation.transform(2049, 1568),
      //   // transformation.transform(2049, 1568),
      //   // transformation.transform(0, 3000),
      // ];
      // print(originalPoints2);
      return FlutterMap(
        options: mapOptions,
        nonRotatedChildren: [
          OverlayImageLayer(
            overlayImages: overlayImages,
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                  label: 'Test',
                  points: polygonLatLng,
                  isFilled: true,
                  color: Colors.red.withOpacity(0.4),
                  labelStyle: const TextStyle(color: Colors.white)
                  // borderColor: Colors.yellow,
                  // borderStrokeWidth: 4,
                  ),
            ],
          ),
        ],
      );
    }

    return flutterMap();
  }
}

class Transformation {
  final num northEastLat = 90;
  final num northEastLng = 180;
  final num southWestLat = -90;
  final num southWestLng = 0;
  final num imageHeight = 3000;
  final num imageWidth = 3000;

  transform(num x, num y, {double scale = 1.0}) {
    return LatLng(
        southWestLat + (x / imageWidth) * (northEastLat - southWestLat),
        southWestLng + (y / imageHeight) * (northEastLng - southWestLng));
  }

  untransform(num lat, num lng, {double scale = 1.0}) {
    final latitudePerPixel = (northEastLat - southWestLat) / imageHeight;
    final longitudePerPixel = (northEastLng - southWestLng) / imageWidth;
    return [
      ((lat - southWestLat) / latitudePerPixel).round(),
      ((lng - southWestLng) / longitudePerPixel).round()
    ];
  }

  bool _pointInPolygon(num x, num y, List<List<num>> points) {
    int numPoints = points.length;
    bool inside = false;

    for (int i = 0, j = numPoints - 1; i < numPoints; j = i++) {
      num xi = points[i][0];
      num yi = points[i][1];
      num xj = points[j][0];
      num yj = points[j][1];

      bool intersect =
          ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);

      if (intersect) {
        inside = !inside;
      }
    }

    return inside;
  }
}
