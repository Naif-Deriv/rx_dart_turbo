import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class TextfieldBloc {
  final Sink<String> firstName;
  final Sink<String> lastName;
  final Stream<String> fullName;

  const TextfieldBloc._({
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  factory TextfieldBloc() {
    final firstNameSubject = BehaviorSubject<String>();
    final lastNameSubject = BehaviorSubject<String>();

    final resStream = Rx.combineLatest2(
      firstNameSubject.stream,
      lastNameSubject.stream,
      (a, b) => a.isEmpty || b.isEmpty
          ? 'Please enter both your first and last names'
          : 'Your name is $a $b',
    ).startWith('Please enter both your first and last names');

    return TextfieldBloc._(
      firstName: firstNameSubject.sink,
      lastName: lastNameSubject.sink,
      fullName: resStream,
    );
  }

  void dispose() {
    firstName.close();
    lastName.close();
  }
}
