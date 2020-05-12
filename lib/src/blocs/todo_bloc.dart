
import 'package:rxdart/rxdart.dart';
import 'package:todoflutterapp/src/models/result.dart';
import 'package:todoflutterapp/src/resource/repository.dart';


class TodosBloc {
  final _repository = Repository();
  final _todosFetcher = PublishSubject<Result>();

  Observable<Result> get allTodos => _todosFetcher.stream;

  fetchAllTodos() async {
    Result itemModel = await _repository.fetchAllTodo();
    _todosFetcher.sink.add(itemModel);
  }

  dispose() {
    _todosFetcher.close();
  }
}

final bloc = TodosBloc();