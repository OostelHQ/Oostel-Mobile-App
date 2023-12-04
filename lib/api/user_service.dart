
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/components/landowner.dart';
import 'base.dart';

Future<FyndaResponse> registerUser(Map<String, dynamic> map,
    {bool agent = false}) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
        "/authenticateuser/register-${agent ? "agent" : "user"}",
        data: formData);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
      return FyndaResponse(
          message: response.data["message"], payload: null, success: true);
    }
  } catch (e) {
    print(e.toString());
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      token = data["data"]["token"];
      Map<String, dynamic>? userData = await _getCurrentUser();

      late User? user;
      if (data["data"]["role"] == null || userData == null) {
        user = null;
      } else {
        log(userData.toString());
        String role = data["data"]["role"];
        String name = data["data"]["fullname"], email = data["data"]["email"];
        List<String> names = name.split(" ");
        names.remove(" ");

        String id = userData["userId"];
        DateTime created = DateTime.parse(userData["createdAt"]);
        String image = userData["profilePicture"] ?? "";

        if (role == "Student") {
          user = Student(
            dateJoined: created,
            image: image,
            id: id,
            firstName: names[0],
            lastName: names[1],
            email: email,
          );
        } else if (role == "LandLord") {
          user = Landowner(
            dateJoined: created,
            dob: DateTime(1960),
            firstName: names[0],
            lastName: names[1],
            email: email,
            image: image,
            id: id,
          );
        } else if (role == "Agent") {
          user = Agent(
            dateJoined: created,
            dob: DateTime(1960),
            firstName: names[0],
            lastName: names[1],
            email: email,
            image: image,
            id: id,
          );
        } else {
          user = null;
        }
      }

      return FyndaResponse<User?>(
          message: data["message"], payload: user, success: user != null);
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

Future<FyndaResponse> verifyEmailOTP(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/authenticateuser/verify-otp-email",
      data: map,
      options: Options(
        contentType: "application/json",
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

Future<Map<String, dynamic>?> _getCurrentUser() async {
  try {
    Response response = await dio.get(
      "/authenticateuser/get-current-user",
      options: configuration,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

Future<User?> refreshUser() async {
  Map<String, dynamic>? userData = await _getCurrentUser();

  log(userData.toString());

  userData = null;

  if (userData == null) {
    return null;
  } else {
    String role = userData["roleCSV"];
    String id = userData["userId"];
    DateTime created = DateTime.parse(userData["createdAt"]);
    String image = userData["profilePicture"] ?? "";

    late User? user;

    if (role == "Student") {
      user = Student(
        dateJoined: created,
        image: image,
        id: id,
      );
    } else if (role == "LandLord") {
      user = Landowner(
        dateJoined: created,
        dob: DateTime(1960),
        image: image,
        id: id,
      );
    } else if (role == "Agent") {
      user = Agent(
        dateJoined: created,
        dob: DateTime(1960),
        image: image,
        id: id,
      );
    } else {
      user = null;
    }

    return user;
  }
}

Future<FyndaResponse> createAgentProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/create-agent-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> updateAgentProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/update-agent-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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
  log("$map");

  try {
    Response response = await dio.post(
      "/user-profile/create-student-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> getLandlordById(String id) async {
  try {
    Response response = await dio.get(
      "/user-profile/get-landlord-by-id",
      options: configuration,
      queryParameters: {
        "landlordId": id,
      },
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
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

Future<FyndaResponse<List<Student>>> getAvailableRoommates() async {
  return const FyndaResponse(
    message: "An error occurred. Please try again",
    payload: [],
    success: false,
  );
}
