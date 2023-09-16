import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/roommate_info.dart';

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

final StateProvider<List<HostelInfo>> hostelsProvider = StateProvider((ref) => [
      HostelInfo(
        id: "1",
        name: "Manchester Hostel Askj",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: const [
          "Room 1",
          "Room 4",
          "Room 2",
        ],
        address: "Harmony Estate",
        description:
            "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
            "Lorem ipsum dolor sit amet, consectetur.",
        rules: const [
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet."
        ],
        hostelFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
          "Light",
          "Water",
          "Security",
        ],
        roomFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
        ],
        media: const [
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
        ],
        owner: Landowner(
          id: "12",
          image: "assets/images/watch man.jpg",
          lastName: "Julius",
          firstName: "Adeyemi",
          verified: true,
          ratings: 3.5,
          contact: "+2348012345678",
          totalRated: 234,
          dateJoined: DateTime.now(),
          address: "Ibadan, Nigeria",
        ),
      ),
      HostelInfo(
        id: "2",
        name: "Liverpool Hostel",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: const [
          "Room 1",
          "Room 4",
          "Room 2",
        ],
        address: "Harmony Estate",
        description:
            "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
            "Lorem ipsum dolor sit amet, consectetur.",
        rules: const [
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet."
        ],
        hostelFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
          "Light",
          "Water",
          "Security",
        ],
        roomFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
        ],
        media: const [
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
        ],
        owner: Landowner(
          id: "12",
          image: "assets/images/watch man.jpg",
          lastName: "Julius",
          firstName: "Adeyemi",
          verified: true,
          ratings: 3.5,
          contact: "+2348012345678",
          totalRated: 234,
          dateJoined: DateTime.now(),
          address: "Ibadan, Nigeria",
        ),
      ),
      HostelInfo(
        id: "3",
        name: "Scotland",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: const [
          "Room 1",
          "Room 4",
          "Room 2",
        ],
        address: "Harmony Estate",
        description:
            "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
            "Lorem ipsum dolor sit amet, consectetur.",
        rules: const [
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet."
        ],
        hostelFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
          "Light",
          "Water",
          "Security",
        ],
        roomFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
        ],
        media: const [
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
        ],
        owner: Landowner(
          id: "12",
          image: "assets/images/watch man.jpg",
          lastName: "Julius",
          firstName: "Adeyemi",
          verified: true,
          ratings: 3.5,
          contact: "+2348012345678",
          totalRated: 234,
          dateJoined: DateTime.now(),
          address: "Ibadan, Nigeria",
        ),
      ),
      HostelInfo(
        id: "4",
        name: "Grace Ville",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: const [
          "Room 1",
          "Room 4",
          "Room 2",
        ],
        address: "Harmony Estate",
        description:
            "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
            "Lorem ipsum dolor sit amet, consectetur.",
        rules: const [
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur.",
          "Nam utcurs usipsum dolor sit amet.",
          "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet."
        ],
        hostelFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
          "Light",
          "Water",
          "Security",
        ],
        roomFacilities: const [
          "Light",
          "Water",
          "Security",
          "None",
        ],
        media: const [
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
          "assets/images/street.jpg",
        ],
        owner: Landowner(
          id: "12",
          image: "assets/images/watch man.jpg",
          lastName: "Julius",
          firstName: "Adeyemi",
          verified: true,
          ratings: 3.5,
          contact: "+2348012345678",
          totalRated: 234,
          dateJoined: DateTime.now(),
          address: "Ibadan, Nigeria",
        ),
      )
    ]);
final StateProvider<List<RoommateInfo>> roommatesProvider =
    StateProvider((ref) {
  Student student = const Student(
    firstName: "John",
    lastName: "Doe",
    gender: "Male",
    image: "assets/images/watch man.jpg",
  );

  return [
    RoommateInfo(
      id: "Info 1",
      student: student,
      level: 100,
      location: "Harmony",
      amount: 50000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
    ),
    RoommateInfo(
      id: "Info 2",
      student: student,
      level: 300,
      location: "Isolu",
      amount: 75000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
    ),
    RoommateInfo(
      id: "Info 3",
      student: student,
      level: 200,
      location: "Accord",
      amount: 50000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
    ),
    RoommateInfo(
      id: "Info 4",
      student: student,
      level: 500,
      location: "Kofesu",
      amount: 40000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
    )
  ];
});
