import 'dart:async';
import 'package:flutter/foundation.dart';
import 'result.dart';

/// Defines a command action that returns a [Result] of type [T].
/// Used by [Command0] for actions without arguments.
typedef CommandAction0<T> = Future<Result<T>> Function();

/// Defines a command action that returns a [Result] of type [T].
/// Takes an argument of type [A].
/// Used by [Command1] for actions with one argument.
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

/// Defines a command action that returns a [Result] of type [T].
/// Takes two arguments of type [A] and [B].
/// Used by [Command2] for actions with two arguments.
typedef CommandAction2<T, A, B> = Future<Result<T>> Function(A, B);

/// Defines a command action that returns a [Result] of type [T].
/// Takes three arguments of type [A], [B], and [C].
/// Used by [Command3] for actions with three arguments.
typedef CommandAction3<T, A, B, C> = Future<Result<T>> Function(A, B, C);

/// Facilitates interaction with a view model.
///
/// Encapsulates an action,
/// exposes its running and error states,
/// and ensures that it can't be launched again until it finishes.
///
/// Use [Command0] for actions without arguments.
/// Use [Command1] for actions with one argument.
///
/// Actions must return a [Result] of type [T].
///
/// Consume the action result by listening to changes,
/// then call [clearResult] when the state is consumed.
abstract class Command<T> extends ChangeNotifier {
  bool _running = false;

  /// Whether the action is running.
  bool get running => _running;

  Result<T>? _result;

  /// Whether the action completed with a failure.
  bool get hasFailure => _result is Failure<T>;

  /// Whether the action completed successfully.
  bool get hasSuccess => _result is Success<T>;

  /// The result of the most recent action.
  Result<T>? get result => _result;

  /// Clears the most recent action's result.
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Execute the provided [action], notifying listeners and
  /// setting the running and result states as necessary.
  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// A [Command] that accepts no arguments.
final class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  Future<void> execute() async {
    await _execute(_action);
  }
}

/// A [Command] that accepts one argument.
final class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}

final class Command2<T, A, B> extends Command<T> {
  Command2(this._action);

  final CommandAction2<T, A, B> _action;

  Future<void> execute(A argument, B argument2) async {
    await _execute(() => _action(argument, argument2));
  }
}

final class Command3<T, A, B, C> extends Command<T> {
  Command3(this._action);

  final CommandAction3<T, A, B, C> _action;

  Future<void> execute(A argument, B argument2, C argument3) async {
    await _execute(() => _action(argument, argument2, argument3));
  }
}
