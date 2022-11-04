import 'package:mobx/mobx.dart';
import 'package:overwatched/models/serie.dart';
import 'package:overwatched/repositories/serie_repository.dart';

import '../models/login_request.dart';
import '../repositories/user_repository.dart';

//flutter pub run build_runner build
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {

  UserRepository repository = UserRepository();

  @observable
  bool isLoading = true;

  @action
  Future<void> create(LoginRequest user) async {
    isLoading = true;
    await repository.register(user);
  }

  @action
  Future<void> login(LoginRequest user) async {
    isLoading = true;
    await repository.login(user);
  }

}