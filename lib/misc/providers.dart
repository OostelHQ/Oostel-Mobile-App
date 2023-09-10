import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_hostel/components/student.dart';

final StateProvider<bool> hasInitializedProvider =
    StateProvider((ref) => false);

final StateProvider<bool> hasMessagesProvider = StateProvider((ref) => false);

final StateProvider<bool> hasNotificationProvider =
    StateProvider((ref) => false);

final StateProvider<Student> studentProvider =
    StateProvider((ref) => const Student(
          id: "",
          image: "assets/images/watch man.jpg",
          firstName: "Doe",
          lastName: "John",
          email: "johndoe@mail.com",
          gender: "Male",
        ));

final StateProvider<int> dashboardTabIndexProvider = StateProvider((ref) => 0);
