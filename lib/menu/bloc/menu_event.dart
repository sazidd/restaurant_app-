part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class FetchNotes extends MenuEvent {
  final int id;

  FetchNotes({this.id});

  @override
  List<Object> get props => [id];
}
