import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/misc/functions.dart';
import 'base.dart';

Future<FyndaResponse> registerUser(Map<String, dynamic> map,
    {bool agent = false}) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
        "/authenticateuser/register-${agent ? "agent" : "user"}",
        data: formData);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return FyndaResponse(
          message: response.data["message"], payload: null, success: true);
    }
  } catch (e) {
    log("Register User Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<User?>> loginUser(Map<String, dynamic> map) async {
  try {
    Response response =
        await dio.post("/authenticateuser/login-user", data: map);

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      token = data["data"]["token"];
      Map<String, dynamic>? userData = await _getCurrentUser();

      late User? user;
      if (data["data"]["role"] == null || userData == null) {
        user = null;
      } else {
        String role = data["data"]["role"];
        if (role == "Student") {
          user = _parseStudentData(userData,
              email: data['data']['email'], fullName: data['data']['fullname']);
        } else if (role == "LandLord") {
          user = parseLandlordData(userData);
        } else if (role == "Agent") {
          user = parseAgentData(userData);
        } else {
          user = null;
        }
      }

      return FyndaResponse<User?>(
        message: data["message"],
        payload: user,
        success: user != null,
      );
    }
  } catch (e) {
    log("Login User Error: $e");
  }

  return const FyndaResponse(
    message: "An unknown error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Landowner parseLandlordData(Map<String, dynamic> userData,
    {bool fromHostel = false}) {
  Map<String, dynamic>? profile = userData["landlordProfile"];

  if (fromHostel && profile != null) {
    String id = profile["landlordId"];
    DateTime created = DateTime.parse(profile["registerdOn"]);
    String name = profile["fullName"];
    String image = profile["profilePicture"];
    String location = profile["location"];
    bool verified = profile["isVerified"];
    String contact = profile["phoneNumber"] ?? "";

    List<String> names = name.split(" ");

    return Landowner(
      dateJoined: created,
      dob: DateTime(1960),
      id: id,
      firstName: names[0],
      lastName: names[1],
      image: image,
      contact: contact,
      verified: verified,
      address: location,
    );
  }

  String email = userData["userDto"]["userName"];
  String id = userData["userDto"]["userId"];
  DateTime created = DateTime.parse(userData["userDto"]["joinedDate"]);
  String contact = userData["userDto"]["phoneNumber"] ?? "";

  if (profile != null) {
    DateTime dob = profile["dateOfBirth"] == null
        ? DateTime(1960)
        : DateTime.parse(profile['dateOfBirth']);
    String religion = profile["religion"] ?? "";
    String state = profile["state"] ?? "";
    String country = profile["country"] ?? "";
    String street = profile["street"] ?? "";
    String image = profile["pictureUrl"] ?? "";

    String gender = profile["gender"] ?? "";
    String denomination = profile["denomination"] ?? "";
    int count = (profile["profileViewCount"] as num).toInt();

    return Landowner(
      firstName: profile["firstName"],
      lastName: profile['lastName'],
      id: id,
      dateJoined: created,
      dob: dob,
      contact: contact,
      email: email,
      image: image,
      religion: religion,
      gender: gender,
      denomination: denomination,
      address: "$street#$state#$country",
      profileViews: count,
    );
  }

  return Landowner(
    email: email,
    id: id,
    dob: DateTime(1960),
    dateJoined: created,
    contact: contact,
  );
}

Student _parseStudentData(Map<String, dynamic> userData,
    {String email = "", String fullName = ""}) {
  //log(userData.toString());

  String id = userData["userDto"]["userId"];
  DateTime created = DateTime.parse(userData["userDto"]["joinedDate"]);
  String contact = userData["userDto"]["phoneNumber"] ?? "";

  Map<String, dynamic>? profile = userData["studentProfile"];

  if (profile != null) {
    String fullName = profile['fullName'];
    String email = profile['email'];
    String state = profile['stateOfOrigin'] ?? "";
    bool isAvailable = profile['isAvailable'] as bool;
    String area = profile['area'] ?? "";
    double roomBudget = (profile['roomBudgetAmount'] as num).toDouble();
    String pictureUrl = profile['pictureUrl'] ?? "";
    int profileViewCount = (profile['profileViewCount'] as num).toInt();
    String gender = profile['gender'] ?? "";
    String country = profile['country'];
    String schoolLevel = profile['schoolLevel'] ?? "";
    String religion = profile['religion'] ?? "";
    String denomination = profile['denomination'] ?? "";
    String age = profile['age'] ?? "";
    String hobby = profile['hobby'] ?? "";
    String guardian = profile["guardianPhoneNumber"] ?? "";
    List<String> names = fullName.split(" ");

    //List<String> peopleILike = toStringList(profile['likedStudentIds']);
    //List<String> myLikes = toStringList(profile['studentLikedIds']);

    return Student(
      dateJoined: created,
      firstName: names[0],
      lastName: names[1],
      denomination: denomination,
      id: id,
      guardian: "0${guardian.substring(3)}",
      available: isAvailable,
      gender: gender,
      religion: religion,
      image: pictureUrl,
      hobby: hobby,
      level: int.parse(schoolLevel),
      peopleILike: [], //peopleILike,
      totalLikes: 0, //myLikes.length,
      contact: contact,
      origin: state,
      profileViews: profileViewCount,
      ageRange: age,
      amount: roomBudget,
      email: email,
    );
  }

  List<String> names = fullName.split(" ");
  return Student(
    firstName: names[0],
    lastName: names[1],
    id: id,
    dateJoined: created,
    contact: contact,
    email: email,
  );
}

Agent parseAgentData(Map<String, dynamic> userData) {
  String id = userData["userDto"]["userId"];
  DateTime created = DateTime.parse(userData["userDto"]["joinedDate"]);
  String contact = userData["userDto"]["phoneNumber"] ?? "";

  Map<String, dynamic>? profile = userData["agentProfile"];

  if (profile != null) {
    String firstName = profile['firstName'];
    String lastName = profile['lastName'];
    String email = profile['email'];
    String state = profile['stateOfOrigin'] ?? "";
    String area = profile['area'] ?? "";
    String pictureUrl = profile['pictureUrl'] ?? "";
    int profileViewCount = (profile['profileViewCount'] as num).toInt();
    String gender = profile['gender'] ?? "";
    String country = profile['country'];
    String religion = profile['religion'] ?? "";
    String denomination = profile['denomination'] ?? "";

    return Agent(
      dateJoined: created,
      dob: DateTime(1960),
      firstName: firstName,
      lastName: lastName,
      denomination: denomination,
      id: id,
      address: "$area, $state, $country",
      gender: gender,
      religion: religion,
      image: pictureUrl,
      contact: contact,
      profileViews: profileViewCount,
      email: email,
    );
  }

  List<String> names = userData["userDto"]["userName"].split(" ");
  return Agent(
    firstName: names[0],
    lastName: names[1],
    id: id,
    dob: DateTime(1960),
    dateJoined: created,
    contact: contact,
    email: "",
  );
}

Future<FyndaResponse> verifyEmailOTP(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/authenticateuser/verify-otp-email",
      data: map,
      options: Options(
        contentType: "application/json",
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
          message: "Email Verified Successfully", payload: null, success: true);
    }
  } catch (e) {
    log("Verify OTP Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> generateOTP(String email) async {
  try {
    Response response = await dio.post(
      "/authenticateuser/Send-reset-password-otp",
      data: {"email": email},
      options: Options(
        contentType: "application/json",
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
          message: "OTP Sent Successfully", payload: null, success: true);
    }
  } catch (e) {
    log("Send OTP Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> resetPassword(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/authenticateuser/reset-password",
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
          message: "Password Reset Successfully", payload: null, success: true);
    }
  } catch (e) {
    log("Reset Password Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> deleteAccount(String id) async {
  try {
    Response response = await dio.delete(
      "/user-delete/delete-user-account",
      queryParameters: {"userId": id},
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
        message: "Success",
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Delete User Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<Map<String, dynamic>?> _getCurrentUser() async {
  try {
    Response response = await dio.get(
      "/authenticateuser/get-current-user",
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return response.data["data"];
    }
  } catch (e) {
    log("Current User Error: $e");
  }

  return null;
}

Future<FyndaResponse> createLandlordProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/create-landlord-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
        message: "Profile Created Successfully",
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Create Landlord Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> updateLandlordProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = ""}) async {
  try {
    Response response = await dio.put(
      "/user-profile/update-landlord-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      if (profilePictureFilePath.isNotEmpty) {
        FyndaResponse resp = await updateProfilePicture(
            id: map["userId"], filePath: profilePictureFilePath);
        return resp;
      } else {
        return const FyndaResponse(
          message: "Profile Updated",
          payload: null,
          success: true,
        );
      }
    }
  } catch (e) {
    log("Update Landlord Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<User?>> refreshUser(UserType type,
    {String fullName = "", String email = ""}) async {
  Map<String, dynamic>? userData = await _getCurrentUser();

  late User? user;
  if (userData == null) {
    user = null;
  } else {
    if (type == UserType.student) {
      user = _parseStudentData(userData);
    } else if (type == UserType.landlord) {
      user = parseLandlordData(userData);
    } else if (type == UserType.agent) {
      user = parseAgentData(userData);
    } else {
      user = null;
    }
  }

  return FyndaResponse(
    message:
        user == null ? "An error occurred when refreshing your profile" : "",
    payload: user,
    success: user != null,
  );
}

Future<FyndaResponse> _createAgentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = ""}) async {
  try {
    Response response = await dio.post(
      "/user-profile/create-agent-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());

      if (profilePictureFilePath.isNotEmpty) {
        FyndaResponse resp = await updateProfilePicture(
          id: map["userId"],
          filePath: profilePictureFilePath,
        );
        return resp;
      } else {
        return const FyndaResponse(
          message: "Profile Created",
          payload: null,
          success: true,
        );
      }
    }
  } catch (e) {
    log("Create Agent Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> agentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = "", required int completionLevel}) async {
  if (completionLevel <= 20) {
    return _createAgentProfile(map,
        profilePictureFilePath: profilePictureFilePath);
  } else {
    return _updateAgentProfile(map,
        profilePictureFilePath: profilePictureFilePath);
  }
}

Future<FyndaResponse> _updateAgentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = ""}) async {
  try {
    Response response = await dio.post(
      "/user-profile/update-agent-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());

      if (profilePictureFilePath.isNotEmpty) {
        FyndaResponse resp = await updateProfilePicture(
          id: map["userId"],
          filePath: profilePictureFilePath,
        );
        return resp;
      } else {
        return const FyndaResponse(
          message: "Profile Updated",
          payload: null,
          success: true,
        );
      }
    }
  } catch (e) {
    log("Update Agent Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> _createStudentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = ""}) async {
  log(map.toString());

  try {
    Response response = await dio.post(
      "/user-profile/create-student-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      if (profilePictureFilePath.isNotEmpty) {
        FyndaResponse resp = await updateProfilePicture(
          id: map["userId"],
          filePath: profilePictureFilePath,
        );
        return resp;
      } else {
        return const FyndaResponse(
          message: "Success",
          payload: null,
          success: true,
        );
      }
    }
  } catch (e) {
    log("Create Student Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> studentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = "", required int completionLevel}) async {
  if (completionLevel <= 20) {
    return _createStudentProfile(map,
        profilePictureFilePath: profilePictureFilePath);
  } else {
    return _updateStudentProfile(map,
        profilePictureFilePath: profilePictureFilePath);
  }
}

Future<FyndaResponse> _updateStudentProfile(Map<String, dynamic> map,
    {String profilePictureFilePath = ""}) async {
  try {
    Response response = await dio.put(
      "/user-profile/update-student-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      if (profilePictureFilePath.isNotEmpty) {
        FyndaResponse resp = await updateProfilePicture(
          id: map["userId"],
          filePath: profilePictureFilePath,
        );
        return resp;
      } else {
        return const FyndaResponse(
          message: "Success",
          payload: null,
          success: true,
        );
      }
    }
  } catch (e) {
    log("Update Student Profile Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<User?>> getLandlordById(String id) async {
  try {
    Response response = await dio.get(
      "/user-profile/get-landlord-by-id",
      options: configuration,
      queryParameters: {
        "landlordId": id,
      },
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      Landowner owner =
          parseLandlordData(response.data["data"] as Map<String, dynamic>);
      return FyndaResponse(
        message: "Success",
        payload: owner,
        success: true,
      );
    }
  } catch (e) {
    log("Get Landlord By id Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getAgentById(String id) async {
  try {
    Response response = await dio.get("/user-profile/get-agent-by-id",
        options: configuration,
        queryParameters: {
          "agentId": id,
        });

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Agent By id Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getStudentById(String id) async {
  try {
    Response response = await dio.get("/user-profile/get-student-by-id",
        options: configuration,
        queryParameters: {
          "studentId": id,
        });

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return FyndaResponse(
        message: "Success",
        payload: _parseStudentData(response.data["data"]),
        success: true,
      );
    }
  } catch (e) {
    log("Get Student By id Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> inviteAgent(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/send-an-invitation-code",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Invite Agent Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> acceptInvite(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/accept-landlord-invitation",
      options: configuration,
      queryParameters: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Accept Invitation Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> updateProfilePicture(
    {required String id, required String filePath}) async {
  FormData formData = FormData();
  formData.files
      .addAll([MapEntry("file", await MultipartFile.fromFile(filePath))]);
  formData.fields.add(MapEntry("userId", id));

  try {
    Response response = await dio.put(
      "/user-profile/upload-user-profile-picture",
      options: configuration,
      data: formData,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      return const FyndaResponse(
        message: "Profile Picture Updated",
        payload: null,
        success: true,
      );
    }
  } catch (e) {
    log("Upload Profile Picture Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> openToRoommate(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/open-to-roommate",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Open To Roommate Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> profileViewCounts(String id) async {
  try {
    Response response = await dio.post(
      "/user-profile/profile-views-count",
      options: configuration,
      queryParameters: {"userId": id},
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Profile View Counts Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> likeStudentProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/like-student-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Like Student Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse<List<String>>> getLikedStudents(String studentId) async {
  try {
    Response response = await dio.get(
      "/user-profile/get-my-liked-students",
      options: configuration,
      queryParameters: {"userId": studentId},
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Liked Students Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}

Future<FyndaResponse> getStudentLikedUsers(String studentId) async {
  try {
    Response response = await dio.get(
      "/user-profile/get-a-student-liked-users",
      options: configuration,
      queryParameters: {"studentId": studentId},
    );

    if (response.statusCode! >= 200 && response.statusCode! <= 201) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Student Liked Users Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: [],
    success: false,
  );
}

Future<FyndaResponse<List<Student>>> getAvailableRoommates() async {
  return const FyndaResponse(
    message: "An error occurred. Please try again",
    payload: [],
    success: false,
  );
}
