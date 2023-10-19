class ViewpointChangedNotifier {
  final List<ViewpointChangedListener> _listeners = [];

  void addListener(ViewpointChangedListener listener) {
    _listeners.add(listener);
  }

  void removeListener(ViewpointChangedListener listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener.viewpointChanged();
    }
  }
}
// Scale did change?