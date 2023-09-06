import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_hostel/components/student.dart';

final StateProvider<bool> hasInitializedProvider =
    StateProvider((ref) => false);

final StateProvider<Student> studentProvider = StateProvider((ref) =>
    const Student(id: "", image: "", firstName: "Doe", lastName: "John", email: "johndoe@mail.com"));

final StateProvider<int> dashboardTabIndexProvider = StateProvider((ref) => 0);
