part of 'generic_cubit.dart';

abstract class GenericCubitState<T> extends Equatable {
  final T data;
  final bool changed;
  final String? error;
  const GenericCubitState(
      {required this.data, required this.changed, this.error});
}

class GenericInitialState<T> extends GenericCubitState<T> {
  const GenericInitialState(T data)
      : super(data: data, changed: false, error: null);

  @override
  List<Object> get props => [changed];
}

class GenericLoadingState<T> extends GenericCubitState<T> {
  const GenericLoadingState({required T data, required bool changed})
      : super(data: data, changed: changed);

  @override
  List<Object> get props => [changed];
}

class GenericDimissLoadingState<T> extends GenericCubitState<T> {
  const GenericDimissLoadingState({required T data, required bool changed})
      : super(data: data, changed: changed);

  @override
  List<Object> get props => [changed];
}

class GenericUpdatedState<T> extends GenericCubitState<T> {
  const GenericUpdatedState(T data, bool changed)
      : super(data: data, changed: changed, error: null);

  @override
  List<Object> get props => [changed];
}

class GenericErrorState<T> extends GenericCubitState<T> {
  const GenericErrorState(
      {required data, required String error, required super.changed})
      : super(data: data, error: error);
  @override
  List<Object> get props => [changed];
}
