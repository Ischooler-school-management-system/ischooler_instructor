part of 'loading_cubit.dart';

class LoadingState extends Equatable {
  final LoadingModel loading;
  const LoadingState(this.loading);

  factory LoadingState.init() {
    return LoadingState(LoadingModel.none);
  }

  LoadingState updateLoading(LoadingModel loading) {
    Madpoly.print(
      'loading = $loading,${StackTrace}',
      tag: 'loading_state > ',
      developer: "Ziad",
    );
    return LoadingState(loading);
  }

  @override
  List<Object> get props => [loading];
}
