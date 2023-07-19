// ignore_for_file: avoid_print

import 'package:arcgis_maps_flutter/arcgis_maps_flutter.dart';
import 'package:flutter/material.dart';
// ignore_for_file: unused_field

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
        strokeStyle: SimpleLineSymbolStyle.dash);
    var polygonSymbol2 = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer2'),
        fillColor: Colors.deepOrange);
    var polygonSymbol3 = const Polygon(
        polygonId: PolygonId('uniqueValueRenderer3'), fillColor: Colors.yellow);

    var uniqueValueInfos = [
      UniqueValueInfo(
          values: [1],
          description: "description",
          symbol: polygonSymbol,
          label: 'Key 1'),
      UniqueValueInfo(
          values: [2],
          description: "description2",
          symbol: polygonSymbol2,
          label: 'Key 2'),
      UniqueValueInfo(
          values: [3],
          description: "description3",
          symbol: polygonSymbol3,
          label: 'Key 3'),
    ];
    var uniqueValueRenderer = UniqueValueRenderer(
        fieldNames: const ["UniqueKey"],
        uniqueValues: uniqueValueInfos,
        type: "UniqueValueRenderer");

    var featureLayer = FeatureLayer.fromUrl(
        'https://services1.arcgis.com/wQnFk5ouCfPzTlPw/arcgis/rest/services/FlutterHex/FeatureServer/0',
        renderer: uniqueValueRenderer);

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
