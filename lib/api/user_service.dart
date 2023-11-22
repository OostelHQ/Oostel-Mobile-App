import 'package:my_hostel/components/user.dart';
import 'base.dart';


Future<FyndaResponse> registerUser(Map<String, dynamic> map, {bool agent = false}) async {
  try {
    FormData formData = FormData.fromMap(map);
    Response response = await dio.post(
      "/authenticateuser/register-${agent ? "agent" : "user"}", data: formData);

    if(response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
      return FyndaResponse(message: response.data["message"], payload: null, success: true);
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
    Response response = await dio.post(
        "/authenticateuser/login-user", data: map);

    if(response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Login User Error: $e");
  }


  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}


Future<FyndaResponse> verifyOTP(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
        "/authenticateuser/verify-otp-email", data: map);

    if(response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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


Future<FyndaResponse> resetPassword(String email) async {
  try {
    Response response = await dio.post(
        "/authenticateuser/Send-reset-password-otp", data: {"email": email});

    if(response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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


Future<FyndaResponse> createLandlordProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
      "/user-profile/create-landlord-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> updateLandlordProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.put(
      "/user-profile/update-landlord-profile",
      options: configuration,
      data: map,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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


Future<FyndaResponse> createStudentProfile(Map<String, dynamic> map) async {
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

Future<FyndaResponse> updateStudentProfile(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post(
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


Future<FyndaResponse> getLandlordById(String ID) async {
  try {
    Response response = await dio.get(
      "/user-profile/get-landlord-by-id",
      options: configuration,
      queryParameters: {
        "landlordId": ID,
      }
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Landlord By ID Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getAgentById(String ID) async {
  try {
    Response response = await dio.get(
        "/user-profile/get-agent-by-id",
        options: configuration,
        queryParameters: {
          "agentId": ID,
        }
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Agent By ID Error: $e");
  }

  return const FyndaResponse(
    message: "An error occurred. Please try again.",
    payload: null,
    success: false,
  );
}

Future<FyndaResponse> getStudentById(String ID) async {
  try {
    Response response = await dio.get(
        "/user-profile/get-student-by-id",
        options: configuration,
        queryParameters: {
          "studentId": ID,
        }
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
    }
  } catch (e) {
    log("Get Student By ID Error: $e");
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

Future<FyndaResponse> updateProfilePicture(Map<String, dynamic> map) async {
  FormData formData = FormData.fromMap(map);
  try {
    Response response = await dio.post(
        "/user-profile/upload-user-profile-picture",
        options: configuration,
        data: formData
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      log(response.data.toString());
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

Future<FyndaResponse> profileViewCounts(String ID) async {
  try {
    Response response = await dio.post(
      "/user-profile/profile-views-count",
      options: configuration,
      queryParameters: {
        "userId":ID
      },
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