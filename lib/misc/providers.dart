import 'dart:math';

import 'package:faker/faker.dart';
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
  image: "https://picsum.photos/280",
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
  image: "https://picsum.photos/290",
  id: "Landowner",
  email: "landlord@mail.com",
  contact: "09012345678",
  religion: "Islam",
  profileViews: 48,
  searchAppearances: 19,
  address: "Accord Junction#Abeokuta#Ogun State",
  verified: true,
);

final Agent defaultAgent = Agent(
  dateJoined: DateTime.now(),
  dob: DateTime(1985),
  firstName: "Smith",
  lastName: "Woods",
  gender: "Male",
  image: "https://picsum.photos/300",
  id: "Landowner",
  email: "landlord@mail.com",
  contact: "09012345678",
  religion: "Islam",
  profileViews: 48,
  searchAppearances: 19,
  address: "Accord Junction#Abeokuta#Ogun State",
);

List<HostelInfo> generateHostels(int count) {
  List<HostelInfo> hostels = [];
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  for (int i = 0; i < count; ++i) {
    int numberOfRooms = random.nextInt(10);

    HostelInfo info = HostelInfo(
      owner: defaultOwner.id,
      address: "Accord Junction#Abeokuta#Ogun State",
      id: "Hostel ID $i",
      price: random.nextInt(200000) * 1.0,
      name: faker.company.name(),
      category: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      area: random.nextInt(200) * 1.0,
      hostelFacilities: const [
        "Light",
        "Tap",
        "Well",
        "Pool",
        "Security",
      ],
      likes: random.nextInt(30),
      media: const [
        "https://picsum.photos/200",
        "https://picsum.photos/220",
        "https://picsum.photos/230",
        "https://picsum.photos/240",
        "https://picsum.photos/250"
      ],
      rooms: generateRooms(numberOfRooms),
      rules: [
        faker.lorem.sentence(),
        faker.lorem.sentence(),
        faker.lorem.sentence(),
        faker.lorem.sentence(),
      ],
      totalRooms: numberOfRooms,
      vacantRooms: random.nextBool(),
    );
    hostels.add(info);
  }
  return hostels;
}

List<RoomInfo> generateRooms(int count) {
  List<RoomInfo> rooms = [];
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  for(int i = 0; i < count; ++i) {
    RoomInfo info = RoomInfo(
      id: "Room Info $i",
      media: const [
        "https://picsum.photos/120",
        "https://picsum.photos/125",
        "https://picsum.photos/130",
        "https://picsum.photos/135",
      ],
      name: 'Room ${i + 1}',
      price: random.nextInt(200000) * 1.0,
      duration: "Yearly",
      facilities: const [
        "Light",
        "Tap Water",
        "Bathroom",
        "Toilet",
        "Kitchen",
        "Ceiling Fan",
      ],
      isRented: random.nextBool(),
    );
    rooms.add(info);
  }
  return rooms;
}


List<Student> generateRoommates(int count) {
  List<Student> roommates = [];
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  for (int i = 0; i < count; ++i) {
    Student student = Student(
      dateJoined: DateTime.now(),
      id: "Student ID $i",
      address: faker.address.neighborhood(),
      location: faker.address.neighborhood(),
      gender: random.nextBool() ? "Male" : "Female",
      image: "https://picsum.photos/210",
      lastName: faker.person.lastName(),
      firstName: faker.person.firstName(),
      email: "test@mail.com",
      amount: random.nextInt(120000) * 1.0,
      ageRange: "25-30",
      available: random.nextBool(),
      contact: faker.phoneNumber.us(),
      denomination: "Some Denomination",
      guardian: faker.phoneNumber.us(),
      hobby: faker.lorem.word(),
      level: 200,
      origin: faker.lorem.word(),
      peopleILike: [],
      profileViews: 20,
      religion: "Christianity",
      searchAppearances: 23,
      totalLikes: 12,
    );
    roommates.add(student);
  }
  return roommates;
}

final StateProvider<bool> hasInitializedProvider =
    StateProvider((ref) => false);

final StateProvider<bool> isAStudent = StateProvider(
    (ref) => ref.watch(currentUserProvider).type == UserType.student);

final StateProvider<bool> isAgent = StateProvider(
    (ref) => ref.watch(currentUserProvider).type == UserType.agent);

final StateProvider<bool> isLandlord = StateProvider(
    (ref) => ref.watch(currentUserProvider).type == UserType.landlord);

final StateProvider<bool> hasMessagesProvider = StateProvider((ref) => false);

final StateProvider<User> currentUserProvider =
    StateProvider((ref) => User(dateJoined: DateTime(1900)));

final StateProvider<int> dashboardTabIndexProvider = StateProvider((ref) => 0);

final StateProvider<bool> newNotificationProvider =
    StateProvider((ref) => false);

final StateProvider<bool> showCompleteProfileProvider =
    StateProvider((ref) => false);

final StateProvider<bool> shouldResetProvider = StateProvider((ref) => false);

void resetProviders(WidgetRef ref) {
  ref.invalidate(notificationsProvider);
  ref.invalidate(studentLikedRoommatesProvider);
  ref.invalidate(studentLikedHostelsProvider);
  ref.invalidate(filteredExploreRoommatesProvider);
  ref.invalidate(filteredExploreHostelsProvider);
  ref.invalidate(acquiredHostelsProvider);
  ref.invalidate(acquiredRoommatesProvider);
  ref.invalidate(availableHostelsProvider);
  ref.invalidate(availableRoommatesProvider);
  ref.invalidate(dashboardTabIndexProvider);
  ref.invalidate(showCompleteProfileProvider);
  ref.invalidate(currentUserProvider);
  ref.invalidate(otpOriginProvider);
  ref.invalidate(hasMessagesProvider);
  ref.invalidate(ownerHostelsProvider);
  ref.invalidate(shouldResetProvider);
}

final StateProvider<List<HostelInfo>> filteredExploreHostelsProvider =
    StateProvider((ref) => generateHostels(10));

final StateProvider<List<Student>> filteredExploreRoommatesProvider =
    StateProvider((ref) => generateRoommates(10));

final StateProvider<List<HostelInfo>> acquiredHostelsProvider =
    StateProvider((ref) => generateHostels(10));

final StateProvider<List<Student>> acquiredRoommatesProvider =
    StateProvider((ref) => generateRoommates(10));

final StateProvider<List<HostelInfo>> availableHostelsProvider =
    StateProvider((ref) => generateHostels(10));

final StateProvider<List<HostelInfo>> ownerHostelsProvider =
    StateProvider((ref) => generateHostels(10));

final StateProvider<List<Student>> availableRoommatesProvider =
    StateProvider((ref) => generateRoommates(10));

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

final StateProvider<OtpOrigin> otpOriginProvider =
    StateProvider((ref) => OtpOrigin.none);

final StateProvider<int> registrationProcessProvider =
    StateProvider((ref) => 0);

final StateProvider<List<String>> studentLikedHostelsProvider =
    StateProvider((ref) => []);

final StateProvider<List<String>> studentLikedRoommatesProvider =
    StateProvider((ref) => []);
