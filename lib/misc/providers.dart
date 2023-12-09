import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/components/conversation.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/notification.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';

final Student defaultStudent = Student(
  firstName: "John",
  lastName: "Doe",
  gender: "Male",
  image: "assets/images/watch man.jpg",
  id: "Info 4",
  level: 300,
  email: "johndoe@mail.com",
  location: "Kofesu",
  amount: 50000,
  available: true,
  origin: "Ebonyi",
  denomination: "Christ Apostolic Church",
  hobby: "Singing and dancing",
  ageRange: "21 - 25",
  religion: "Christianity",
  dateJoined: DateTime.now(),
  searchAppearances: 19,
  profileViews: 48,
  contact: "09012345678",
);

final Landowner defaultOwner = Landowner(
  dateJoined: DateTime.now(),
  dob: DateTime(1985),
  firstName: "Smith",
  lastName: "Woods",
  gender: "Male",
  image: "assets/images/watch man.jpg",
  id: "Landowner",
  email: "landlord@mail.com",
  contact: "09012345678",
  religion: "Islam",
  profileViews: 48,
  searchAppearances: 19,
  address: "Abeokuta, Ogun State",
  verified: true,
);

final Agent defaultAgent = Agent(
  dateJoined: DateTime.now(),
  dob: DateTime(1985),
  firstName: "Smith",
  lastName: "Woods",
  gender: "Male",
  image: "assets/images/watch man.jpg",
  id: "Landowner",
  email: "landlord@mail.com",
  contact: "09012345678",
  religion: "Islam",
  profileViews: 48,
  searchAppearances: 19,
  address: "Abeokuta, Ogun State",
  verified: true,
);

final StateProvider<bool> hasInitializedProvider =
    StateProvider((ref) => false);

final StateProvider<bool> isAStudent =
    StateProvider((ref) => ref.watch(currentUserProvider).type == UserType.student);

final StateProvider<bool> isAgent =
StateProvider((ref) => ref.watch(currentUserProvider).type == UserType.agent);

final StateProvider<bool> isLandlord =
StateProvider((ref) => ref.watch(currentUserProvider).type == UserType.landlord);

final StateProvider<bool> hasMessagesProvider = StateProvider((ref) => false);

final StateProvider<User> currentUserProvider =
    StateProvider((ref) => User(dateJoined: DateTime(1900)));

final StateProvider<int> dashboardTabIndexProvider = StateProvider((ref) => 0);

final StateProvider<bool> newNotificationProvider = StateProvider((ref) => false);

final StateProvider<bool> showCompleteProfileProvider = StateProvider((ref) => false);

void resetProviders(WidgetRef ref) {
  ref.invalidate(availableHostelsProvider);
  ref.invalidate(availableRoommatesProvider);
  ref.invalidate(dashboardTabIndexProvider);
  ref.invalidate(showCompleteProfileProvider);
  ref.invalidate(currentUserProvider);
  ref.invalidate(otpOriginProvider);
  ref.invalidate(hasMessagesProvider);
}


final StateProvider<List<HostelInfo>> filteredExploreHostelsProvider = StateProvider((ref) => []);
final StateProvider<List<Student>> filteredExploreRoommatesProvider = StateProvider((ref) => []);


final StateProvider<List<HostelInfo>> acquiredHostelsProvider =
    StateProvider((ref) => [
          HostelInfo(
            id: "1",
            name: "Manchester Hostel",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "2",
            name: "Liverpool Hostel",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "3",
            name: "Scotland",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "4",
            name: "Grace Ville",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "5",
            name: "Manchester Hostel Askj",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "6",
            name: "Liverpool Hostel",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "7",
            name: "Scotland",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          ),
          HostelInfo(
            id: "8",
            name: "Grace Ville",
            area: 2500,
            price: 100000,
            address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
            rooms: const [
              RoomInfo(
                name: "Room 1",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 1 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 2",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 2 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 3",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 3 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 4",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 4 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              ),
              RoomInfo(
                name: "Room 5",
                facilities: [
                  "Light",
                  "Water",
                  "Security",
                  "None",
                ],
                id: "Room 5 ID",
                media: [
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                  "assets/images/street.jpg",
                ],
                price: 100000,
              )
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
            owner: defaultOwner.id,
          )
        ],
    );

final StateProvider<List<Student>> acquiredRoommatesProvider =
    StateProvider((ref) {
  return [];
});

final StateProvider<List<HostelInfo>> availableHostelsProvider =
    StateProvider((ref) => []);

final StateProvider<List<HostelInfo>> ownerHostelsProvider = StateProvider(
  (ref) => [
    HostelInfo(
        id: "11",
      likes: 0,
        name: "Manchester Hostel",
        area: 2500,
        price: 100000,
        address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
      roomsLeft: const ["Room 1 ID", "Room 2 ID", "Room 3 ID", "Room 4 ID", "Room 5 ID"],
        rooms: const [
          RoomInfo(
            name: "Room 1",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 1 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 2",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 2 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 3",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 3 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 4",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 4 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 5",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 5 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          )
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
      owner: defaultOwner.id,
    ),
    HostelInfo(
        id: "12",
        name: "Liverpool Hostel",
        area: 2500,
        price: 100000,
        address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
        roomsLeft: const ["Room 1 ID", "Room 2 ID", "Room 3 ID", "Room 4 ID", "Room 5 ID"],
        rooms: const [
          RoomInfo(
            name: "Room 1",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 1 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 2",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 2 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 3",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 3 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 4",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 4 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 5",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 5 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          )
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
      owner: defaultOwner.id,
        ),
    HostelInfo(
        id: "13",
        name: "Scotland",
        area: 2500,
        price: 100000,
        address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
        roomsLeft: const ["Room 1 ID", "Room 2 ID", "Room 3 ID", "Room 4 ID", "Room 5 ID"],
        rooms: const [
          RoomInfo(
            name: "Room 1",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 1 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 2",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 2 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 3",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 3 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 4",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 4 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 5",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 5 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          )
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
      owner: defaultOwner.id,
    ),
    HostelInfo(
        id: "14",
        name: "Grace Ville",
        area: 2500,
        price: 100000,
        address: "21, Shale Close#Harmony Estate#Ogun State#Nigeria",
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
        roomsLeft: const ["Room 1 ID", "Room 2 ID", "Room 3 ID", "Room 4 ID", "Room 5 ID"],
        rooms: const [
          RoomInfo(
            name: "Room 1",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 1 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 2",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 2 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 3",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 3 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 4",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 4 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          ),
          RoomInfo(
            name: "Room 5",
            facilities: [
              "Light",
              "Water",
              "Security",
              "None",
            ],
            id: "Room 5 ID",
            media: [
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
              "assets/images/street.jpg",
            ],
            price: 100000,
          )
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
        owner: defaultOwner.id,
    )
  ],
);

final StateProvider<List<Student>> availableRoommatesProvider =
    StateProvider((ref) {
  return [
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 11",
      level: 100,
      location: "Harmony",
      amount: 50000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 12",
      level: 300,
      location: "Isolu",
      amount: 75000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 13",
      level: 200,
      location: "Accord",
      amount: 50000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 14",
      level: 500,
      location: "Kofesu",
      amount: 40000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "15 - 20",
      religion: "Christianity",
      dateJoined: DateTime.now(),
      profileViews: 48,
      searchAppearances: 19,
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 15",
      level: 100,
      location: "Harmony",
      amount: 50000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 16",
      level: 300,
      location: "Isolu",
      amount: 75000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 17",
      level: 200,
      location: "Accord",
      amount: 50000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 18",
      level: 500,
      location: "Kofesu",
      amount: 40000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "15 - 20",
      religion: "Christianity",
      dateJoined: DateTime.now(),
      profileViews: 48,
      searchAppearances: 19,
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 19",
      level: 100,
      location: "Harmony",
      amount: 50000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 20",
      level: 300,
      location: "Isolu",
      amount: 75000,
      available: true,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 21",
      level: 200,
      location: "Accord",
      amount: 50000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "23 - 30",
      religion: "Christianity",
      dateJoined: DateTime.now(),
    ),
    Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
      id: "Info 22",
      level: 500,
      location: "Kofesu",
      amount: 40000,
      available: false,
      origin: "Ebonyi",
      denomination: "Christ Apostolic Church",
      hobby: "Singing and dancing",
      ageRange: "15 - 20",
      religion: "Christianity",
      dateJoined: DateTime.now(),
      profileViews: 48,
      searchAppearances: 19,
    ),
  ];
});

final StateProvider<List<String>> roomTypesProvider = StateProvider((ref) => [
      "Self Contained",
      "One-Room",
      "Face-To-Face",
      "Flat",
    ]);

final StateProvider<List<String>> locationProvider = StateProvider((ref) => [
      "Kofesu",
      "Camp",
      "Accord",
      "Harmony",
      "Agbede",
      "Oluwo",
      "Isolu",
      "Funis"
    ]);

final StateProvider<List<String>> banksProvider = StateProvider((ref) => [
      "Kofesu",
      "Camp",
      "Accord",
      "Harmony",
      "Agbede",
      "Oluwo",
      "Isolu",
      "Funis"
    ]);

final StateProvider<List<NotificationData>> notificationsProvider =
    StateProvider((ref) => [
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
          NotificationData(
            image: "assets/images/watch man.jpg",
            timestamp: DateTime.now(),
            message:
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet...",
          ),
        ]);

final StateProvider<List<Receipt>> receiptsProvider = StateProvider(
  (ref) => [
    Receipt(
      timestamp: DateTime.now(),
      studentName: "Adedigba Rejoice",
      hostel: "Manchester Hostel",
      id: "12345",
      amountInWords: "One Hundred Thousand Naira (NGN 100,000)",
      landOwnerName: "Adeyemi Julius",
      reference: "202384024BG",
    ),
    Receipt(
      timestamp: DateTime.now(),
      studentName: "Adedigba Rejoice",
      hostel: "Manchester Hostel",
      id: "12345",
      amountInWords: "One Hundred Thousand Naira (NGN 100,000)",
      landOwnerName: "Adeyemi Julius",
      reference: "202384024BG",
    ),
    Receipt(
      timestamp: DateTime.now(),
      studentName: "Adedigba Rejoice",
      hostel: "Manchester Hostel",
      id: "12345",
      amountInWords: "One Hundred Thousand Naira (NGN 100,000)",
      landOwnerName: "Adeyemi Julius",
      reference: "202384024BG",
    )
  ],
);

final StateProvider<List<Transaction>> studentTransactionsProvider =
    StateProvider(
  (ref) => [
    Transaction(
      timestamp: DateTime.now(),
      type: TransactionType.credit,
      purpose: "Top-up Wallet",
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Top-up Wallet",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Hostel Payment",
      type: TransactionType.debit,
      amount: 90000,
      receiver: "AKINWOYE OLUWAPELUMI",
      status: TransactionStatus.pending,
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Top-up Wallet",
      type: TransactionType.credit,
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Top-up Wallet",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Hostel Payment",
      type: TransactionType.debit,
      amount: 90000,
      status: TransactionStatus.pending,
      receiver: "AKINWOYE OLUWAPELUMI",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Top-up Wallet",
      type: TransactionType.credit,
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Top-up Wallet",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Hostel Payment",
      type: TransactionType.debit,
      amount: 90000,
      receiver: "AKINWOYE OLUWAPELUMI",
      status: TransactionStatus.pending,
      paymentID: "791798480928989DE",
    ),
  ],
);

final StateProvider<List<Transaction>> ownerTransactionsProvider =
    StateProvider(
  (ref) => [
    Transaction(
      timestamp: DateTime.now(),
      type: TransactionType.credit,
      purpose: "Money Received",
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Money Received",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Withdrawal",
      type: TransactionType.debit,
      amount: 90000,
      receiver: "AKINWOYE OLUWAPELUMI",
      status: TransactionStatus.pending,
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Money Received",
      type: TransactionType.credit,
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Money Received",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Withdrawal",
      type: TransactionType.debit,
      amount: 90000,
      status: TransactionStatus.pending,
      receiver: "AKINWOYE OLUWAPELUMI",
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Money Received",
      type: TransactionType.credit,
      amount: 150000,
      status: TransactionStatus.success,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Money Received",
      type: TransactionType.credit,
      amount: 100000,
      status: TransactionStatus.failed,
      receiver: "AKINWOYE OLUWAPELUMI",
      hostel: "Manchester Hostel",
      paymentID: "791798480928989DE",
    ),
    Transaction(
      timestamp: DateTime.now(),
      purpose: "Withdrawal",
      type: TransactionType.debit,
      amount: 90000,
      receiver: "AKINWOYE OLUWAPELUMI",
      status: TransactionStatus.pending,
      bankName: "First Bank of Nigeria",
      accountNumber: "3130201234",
      paymentID: "791798480928989DE",
    ),
  ],
);

final StateProvider<double> expensesProvider = StateProvider((ref) => 65000);

final StateProvider<double> walletProvider = StateProvider((ref) => 65000);

final StateProvider<List<Conversation>> conversationsProvider = StateProvider(
  (ref) => [
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "0",
      unreadMessages: 0,
      target: "Manchester Hostel",
    ),
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "1",
      unreadMessages: 3,
      target: "Liverpool Hostel",
    ),
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "2",
      unreadMessages: 0,
      target: "Custom Hostel",
    ),
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "3",
      unreadMessages: 10,
      target: "Some Hostel",
    ),
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "4",
      unreadMessages: 1,
      target: "Fourth Hostel",
    ),
    Conversation(
      timeStamp: DateTime.now(),
      lastMessage: "Hi. How far?",
      otherUser: "123",
      id: "5",
      unreadMessages: 6,
      target: "Last Hostel",
    ),
  ],
);

final StateProvider<OtpOrigin> otpOriginProvider = StateProvider((ref) => OtpOrigin.none);
final StateProvider<int> registrationProcessProvider = StateProvider((ref) => 0);
