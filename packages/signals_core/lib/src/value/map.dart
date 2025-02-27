part of 'value.dart';

/// A [Signal] that holds a [Map].
class MapSignal<K, V> extends Signal<Map<K, V>>
    with ValueSignalMixin
    implements Map<K, V> {
  /// Creates a [MapSignal] with the given [value].
  MapSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });

  @override
  V? operator [](Object? key) {
    return value[key];
  }

  @override
  void operator []=(K key, V value) {
    this.value[key] = value;
    set(this.value, force: true);
  }

  /// Inject: Update current signal value with iterable
  MapSignal<K, V> operator <<(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
    return this;
  }

  /// Fork: create a new signal with value is the concatenation of source signal and iterable parameter
  MapSignal<K, V> operator &(Map<K, V> other) {
    final rs = Map<K, V>.from(peek())..addAll(other);
    return MapSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  MapSignal<K, V> operator |(Signal<Map<K, V>> other) {
    final rs = Map<K, V>.from(peek())..addAll(other.peek());
    return MapSignal(rs);
  }

  @override
  void addAll(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    set(value, force: true);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return value.cast<RK, RV>();
  }

  @override
  void clear() {
    value.clear();
    set(value, force: true);
  }

  @override
  bool containsKey(Object? key) {
    return value.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return this.value.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => value.entries;

  @override
  void forEach(void Function(K key, V value) action) {
    value.forEach(action);
    set(value, force: true);
  }

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterable<K> get keys => value.keys;

  @override
  int get length => value.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return value.map<K2, V2>(convert);
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final result = value.putIfAbsent(key, ifAbsent);
    set(value, force: true);
    return result;
  }

  @override
  V? remove(Object? key) {
    final result = value.remove(key);
    set(value, force: true);
    return result;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final result = value.update(key, update, ifAbsent: ifAbsent);
    set(value, force: true);
    return result;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    set(value, force: true);
  }

  @override
  Iterable<V> get values => value.values;

  @override
  bool operator ==(Object other) {
    return other is MapSignal<K, V> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value.entries) item.hashCode
    ]);
  }

  @override
  Map<K, V> get initialValue => ValueSignalMixin.initialValueException();

  @override
  Map<K, V> get previousValue => ValueSignalMixin.previousValueException();
    
  /// Snapshot of [MapEntries]
  Map<K, V> toMap() => Map.fromIterables(keys, values);
}

/// Create an [MapSignal] from [Map]
MapSignal<K, V> mapSignal<K, V>(
  Map<K, V> map, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return MapSignal<K, V>(
    map,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalMapUtils<K, V> on Map<K, V> {
  /// Convert an existing list to [MapSignal]
  MapSignal<K, V> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return MapSignal<K, V>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
