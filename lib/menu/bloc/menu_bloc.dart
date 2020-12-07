import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../menu.dart';
import '../repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> with ChangeNotifier {
  Repository repository;
  MenuBloc({this.repository}) : super(MenuInitial());

  toastShow() {
    Fluttertoast.showToast(
        msg: "There is no more Data Availabel",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchNotes && !_hasReachedMax(state)) {
      if (currentState is MenuInitial) {
        yield MenuLoading();
        try {
          final notes = await repository.fetchNotes(event.id);
          print('notes: { $notes }');
          yield MenuSuccess(notes: notes, hasReachedMax: false);
        } catch (_) {
          toastShow();
          // yield MenuFailure(error: 'No data available');
        }
      } else if (currentState is MenuSuccess) {
        try {
          final notes = await repository.fetchNotes(event.id + 1);
          print('notes: { $notes }');
          yield notes.isEmpty
              ? MenuSuccess(notes: <Menu>[], hasReachedMax: true)
              : MenuSuccess(
                  notes: currentState.notes + notes, hasReachedMax: false);
        } catch (_) {
          toastShow();
          //yield MenuFailure(error: 'No data available');
        }
      }
    }
  }
}

bool _hasReachedMax(MenuState state) =>
    state is MenuSuccess && state.hasReachedMax;
