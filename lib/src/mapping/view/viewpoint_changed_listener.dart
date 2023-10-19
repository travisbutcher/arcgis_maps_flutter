part of arcgis_maps_flutter;

// Scale change notifier 

// is this supposed to implement or extend ChangeNotifier?
abstract class ViewpointChangedListener{
  void viewpointChanged();
}


// Scale did change?
  // notify listeners