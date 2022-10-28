// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SerieStore on _SerieStore, Store {
  late final _$seriesAtom = Atom(name: '_SerieStore.series', context: context);

  @override
  ObservableList<Serie> get series {
    _$seriesAtom.reportRead();
    return super.series;
  }

  @override
  set series(ObservableList<Serie> value) {
    _$seriesAtom.reportWrite(value, super.series, () {
      super.series = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SerieStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$refreshAsyncAction =
      AsyncAction('_SerieStore.refresh', context: context);

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  late final _$createAsyncAction =
      AsyncAction('_SerieStore.create', context: context);

  @override
  Future<void> create(Serie serie) {
    return _$createAsyncAction.run(() => super.create(serie));
  }

  late final _$updateAsyncAction =
      AsyncAction('_SerieStore.update', context: context);

  @override
  Future<void> update(Serie serie) {
    return _$updateAsyncAction.run(() => super.update(serie));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_SerieStore.delete', context: context);

  @override
  Future<void> delete(Serie serie) {
    return _$deleteAsyncAction.run(() => super.delete(serie));
  }

  @override
  String toString() {
    return '''
series: ${series},
isLoading: ${isLoading}
    ''';
  }
}
