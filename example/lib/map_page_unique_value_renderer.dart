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
      body: _buildMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController?.removeViewpointChangedListener(this);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMap() {
    var featureLayer = FeatureLayer.fromUrl(
        'https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads_Styled/FeatureServer/0');
    //var uniqueValueRenderer = Uni();

    //uniqueValueRenderer.field1 = 'TRL_NAME';
    //featureLayer.renderer = uniqueValueRenderer

    var mapView = ArcgisMapView(
      map: map,
      viewpoint: Viewpoint.fromLatLng(
          latitude: 34.105156, longitude: -118.731316, scale: 120000),
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
            FeatureLayer.fromUrl(
                'https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads_Styled/FeatureServer/0'),
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

  // ignore: unused_element
  Widget _buildMapsTypes(ScrollController scrollController) {
    var items = BasemapType.values;

    return Container(
      color: Colors.white,
      child: ListView.builder(
        controller: scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              items[index].toString(),
            ),
            onTap: () {
              setState(() {
                map = ArcGISMap.fromBasemapType(
                  basemapType: items[index],
                  longitude: 41.3678,
                  latitude: 28.5588,
                  levelOfDetail: 10,
                );
              });
              Navigator.pop(_scaffoldKey.currentContext!);
            },
          );
        },
      ),
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
