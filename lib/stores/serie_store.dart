import 'package:mobx/mobx.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/repositories/serie_repository.dart';

//flutter pub run build_runner build
part 'serie_store.g.dart';

class SerieStore = _SerieStore with _$SerieStore;

abstract class _SerieStore with Store {
  _SerieStore() {
    refresh();
  }

  SerieRepository repository = SerieRepository();

  @observable
  ObservableList<Serie> series = ObservableList();

  @observable
  bool isLoading = true;

  @action
  Future<void> refresh() async {
    series.addAll(await repository.list());
    isLoading = false;
  }

  @action
  Future<void> create(Serie serie) async {
    isLoading = true;
    await repository.create(serie);
    refresh();
  }

  @action
  Future<void> update(Serie serie) async {
    isLoading = true;
    await repository.update(serie);
    refresh();
  }

  @action
  Future<void> delete(Serie serie) async {
    isLoading = true;
    await repository.delete(serie);
    refresh();
  }
}