// ignore_for_file: avoid_print

import 'package:arcgis_maps_flutter/arcgis_maps_flutter.dart';
import 'package:flutter/material.dart';
// ignore_for_file: unused_field

// scale change notifier

class MapUniqueValuePage extends StatefulWidget {
  const MapUniqueValuePage({Key? key}) : super(key: key);

  @override
  State<MapUniqueValuePage> createState() => _MapUniqueValuePageState();
}

class _MapUniqueValuePageState extends State<MapUniqueValuePage>
    implements ViewpointChangedListener {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool _showLayers = false;
  ArcGISMap map = ArcGISMap.openStreetMap();
  ArcgisMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          title: const Text("Unique Value Renderer"),
        ),
        body: _buildMap());
  }

  Widget _buildMap() {
    var polygonSymbol = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer'),
        fillColor: Colors.blue,
        strokeWidth: 5,
        strokeColor: Colors.pink,
        strokeStyle: SimpleLineSymbolStyle.dash
      );
    
    var polygonSymbol2 = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer2'),
        fillColor: Colors.deepOrange,
        strokeWidth: 10,
        strokeColor: Colors.black12,
        strokeStyle: SimpleLineSymbolStyle.dashDot
      );
    
    var polygonSymbol3 = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer3'), 
        fillColor: Colors.yellow,
        strokeWidth: 15,
        strokeColor: Colors.black26, 
        strokeStyle: SimpleLineSymbolStyle.solid
      );
    
    var polygonSymbol4 = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer4'),
        fillColor: Colors.deepPurple,
        strokeWidth: 20,
        strokeColor: Colors.red,
        strokeStyle: SimpleLineSymbolStyle.dashDotDot
      );

    //create couple line symbols
    var lineSymbol1 = const Polyline(
      polylineId: PolylineId('uniqueValueRendererLine1'),
      color: Colors.deepOrange,
      style: SimpleLineSymbolStyle.dash,
      width: 2
    );
    var lineSymbol2 = const Polyline(
      polylineId: PolylineId('uniqueValueRendererLine2'),
      color: Colors.red,
      style: SimpleLineSymbolStyle.dashDot,
      width: 4
    );
    var lineSymbol3 = const Polyline(
      polylineId: PolylineId('uniqueValueRendererLine3'),
      color: Colors.blue,
      style: SimpleLineSymbolStyle.longDash,
      width: 6
    );
    var lineSymbol4 = const Polyline(
      polylineId: PolylineId('uniqueValueRendererLine4'),
      color: Colors.amber,
      style: SimpleLineSymbolStyle.dot,
      width: 10
    );

    //create couple point symbols
    var pointSymbol1 = const Point(
      pointId: PointId("UniquePoint1"),
      color: Colors.white,
      style: SimpleMarkerSymbolStyle.circle,
      size: 5
    );
    var pointSymbol2 = const Point(
      pointId: PointId("UniquePoint2"),
      color: Colors.black,
      style: SimpleMarkerSymbolStyle.cross,
      size: 10
    );
    var pointSymbol3 = const Point(
      pointId: PointId("UniquePoint3"),
      color: Colors.blue,
      style: SimpleMarkerSymbolStyle.diamond,
      size: 15
    );
    var pointSymbol4 = const Point(
      pointId: PointId("UniquePoint4"),
      color: Colors.yellow,
      style: SimpleMarkerSymbolStyle.square,
      size: 20
    );

    var uniqueValueInfos = [
      // UniqueValueInfo(
      //     values: ["PA1"],
      //     description: "PolyDesc1",
      //     symbol: polygonSymbol,
      //     label: 'PL1'),
      // UniqueValueInfo(
      //     values: ["PA2"],
      //     description: "description2",
      //     symbol: polygonSymbol2,
      //     label: 'Key 2'),
      // UniqueValueInfo(
      //     values: ["PA3"],
      //     description: "description3",
      //     symbol: polygonSymbol3,
      //     label: 'Key 3'),
      // UniqueValueInfo(
      //     values: ["PA4"],
      //     description: "description4",
      //     symbol: polygonSymbol4,
      //     label: 'Key 4')
      // UniqueValueInfo(
      //   values: ["1"], 
      //   label: 'L1', 
      //   description: 'description5', 
      //   symbol: lineSymbol1),
      // UniqueValueInfo(
      //   values: ["2"], 
      //   label: 'L2', 
      //   description: 'description6', 
      //   symbol: lineSymbol2),
      // UniqueValueInfo(
      //   values: ["3"], 
      //   label: 'Key6', 
      //   description: 'description7', 
      //   symbol: lineSymbol3),
      // UniqueValueInfo(
      //   values: ["4"], 
      //   label: 'Key7', 
      //   description: 'description8', 
      //   symbol: lineSymbol4)
      UniqueValueInfo(
          values: ["P4"],
          description: "description4",
          symbol: pointSymbol1,
          label: 'Point1'),
      UniqueValueInfo(
          values: ["P2"],
          description: "description2",
          symbol: pointSymbol2,
          label: 'Point2'),
      UniqueValueInfo(
          values: ["P3"],
          description: "description3",
          symbol: pointSymbol3,
          label: 'Point3'),
      UniqueValueInfo(
          values: ["P1"],
          description: "description1",
          symbol: pointSymbol4,
          label: 'Point4')
    ];
    var uniqueValueRenderer = UniqueValueRenderer(
        fieldNames: const ["Attribut"], 
        uniqueValues: uniqueValueInfos,
        type: "UniqueValueRenderer");

    // Lines
    // var featureLayer = FeatureLayer.fromUrl(
    //     "https://services1.arcgis.com/wQnFk5ouCfPzTlPw/arcgis/rest/services/DFW_App_Testing/FeatureServer/1",
    //     renderer: uniqueValueRenderer);
   
   // Points
   var featureLayer = FeatureLayer.fromUrl(
        "https://services1.arcgis.com/wQnFk5ouCfPzTlPw/arcgis/rest/services/DFW_App_Testing/FeatureServer/0",
        renderer: uniqueValueRenderer);

    // Polygons
    // var featureLayer = FeatureLayer.fromUrl(
    //     "https://services1.arcgis.com/wQnFk5ouCfPzTlPw/arcgis/rest/services/DFW_App_Testing/FeatureServer/2",
    //     renderer: uniqueValueRenderer);

    var mapView = ArcgisMapView(
      map: map,
      viewpoint: Viewpoint.fromLatLng(
          latitude: 34.105156, longitude: -118.731316, scale: 360000),
      onMapLoaded: (error) {
        if (error != null) {
          print(error);
        } else {
          print('map loaded.');
        }
      },
      operationalLayers: {
        GroupLayer(
          layerId: const LayerId('Group'),
          layers: {
            featureLayer,
          },
        ),
      },
      onLayerLoaded: (layer, error) {
        if (error != null) {
          print('Failed to load $layer:$error');
        } else {
          print('Loaded layer $layer');
        }
      },
    );

    return Stack(
      children: [mapView],
    );
  }

  void onMapCreated(ArcgisMapController mapController) {
    _mapController = mapController;
    setState(() {});
  }

  @override
  void viewpointChanged() async {
    final rotation = await _mapController!.getMapRotation();
    print('viewpointChanged -> map rotation $rotation}');
  }
}
