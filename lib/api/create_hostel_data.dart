import 'package:my_hostel/api/file_manager.dart';

class HostelCreationData {

  static const String _stepIndex = "fyndaStepIndex";

  static Future<int?> getStepIndex() async {
    int? step = await FileManager.loadInt(_stepIndex);
    return step;
  }

  static Future<void> clear() async {
    await FileManager.saveInt("fyndaHostelCategory", -1);
    await FileManager.save("fyndaHostelName", "");
    await FileManager.save("fyndaHostelDescription", "");
    await FileManager.saveInt("fyndaHostelTotalRooms", -1);
    await FileManager.save("fyndaHostelStreet", "");
    await FileManager.save("fyndaHostelJunction", "");
    await FileManager.save("fyndaHostelState", "");
    await FileManager.save("fyndaHostelCountry", "");
    await FileManager.saveStringList("fyndaHostelRules", []);
    await FileManager.saveStringList("fyndaHostelFacilities", []);
    await FileManager.saveStringList("fyndaHostelMedia", []);
    await FileManager.saveBool("fyndaHostelRoomVacancy", false);


    await _clearRooms();

    await FileManager.saveInt(_stepIndex, 0);
  }


  static Future<void> saveStepOneData(Map<String, dynamic> data) async {
    await clear();

    await FileManager.saveInt("fyndaHostelCategory", data["hostelCategory"]);
    await FileManager.saveInt(_stepIndex, 1);
  }

  static Future<Map<String, dynamic>> loadStepOneData() async {
    int? val = await FileManager.loadInt("fyndaHostelCategory");
    return {"hostelCategory": val};
  }

  static Future<void> saveStepTwoData(Map<String, dynamic> data) async {
    await saveStepOneData(data);

    await FileManager.save("fyndaHostelName", data["hostelName"]);
    await FileManager.save("fyndaHostelDescription", data["hostelDescription"]);
    await FileManager.saveInt("fyndaHostelTotalRooms", data["totalRoom"]);
    await FileManager.saveInt(_stepIndex, 2);
  }

  static Future<Map<String, dynamic>> loadStepTwoData() async {
    String? name = await FileManager.load("fyndaHostelName");
    String? description = await FileManager.load("fyndaHostelDescription");
    int? rooms = await FileManager.loadInt("fyndaHostelTotalRooms");

    return {
      "hostelName": name,
      "hostelDescription": description,
      "totalRoom": rooms,
    };
  }

  static Future<void> saveStepThreeData(Map<String, dynamic> data) async {
    await saveStepTwoData(data);

    await FileManager.save("fyndaHostelStreet", data["street"]);
    await FileManager.save("fyndaHostelJunction", data["junction"]);
    await FileManager.save("fyndaHostelState", data["state"]);
    await FileManager.save("fyndaHostelCountry", data["country"]);
    await FileManager.saveInt(_stepIndex, 3);
  }

  static Future<Map<String, dynamic>> loadStepThreeData() async {
    String? street = await FileManager.load("fyndaHostelStreet");
    String? junction = await FileManager.load("fyndaHostelJunction");
    String? state = await FileManager.load("fyndaHostelState");
    String? country = await FileManager.load("fyndaHostelCountry");


    return {
      "street": street,
      "junction": junction,
      "state": state,
      "country" : country,
    };
  }

  static Future<void> saveStepFourData(Map<String, dynamic> data) async {
    await saveStepThreeData(data);

    await FileManager.save("fyndaHostelRules", data["RuleAndRegulation"]);
    await FileManager.saveInt(_stepIndex, 4);
  }

  static Future<Map<String, dynamic>> loadStepFourData() async {
    List<String>? rules = await FileManager.loadStringList("fyndaHostelRules");
    return {
      "RuleAndRegulation": rules,
    };
  }


  static Future<void> saveStepFiveData(Map<String, dynamic> data) async {
    await saveStepFourData(data);

    await FileManager.save("fyndaHostelFacilities", data["FacilityName"]);
    await FileManager.saveInt(_stepIndex, 5);
  }

  static Future<Map<String, dynamic>> loadStepFiveData() async {
    List<String>? rules = await FileManager.loadStringList("fyndaHostelFacilities");
    return {
      "FacilityName": rules,
    };
  }

  static Future<void> saveStepSixData(Map<String, dynamic> data) async {
    await saveStepFiveData(data);

    SingleFileResponse response = data["media"].first as SingleFileResponse;

    await FileManager.save("fyndaHostelMedia", data["media"]);
    await FileManager.saveInt(_stepIndex, 6);
  }

  static Future<Map<String, dynamic>> loadStepSixData() async {
    List<String>? rules = await FileManager.loadStringList("fyndaHostelMedia");
    return {
      "medias": rules,
    };
  }

  static Future<void> saveStepSixHalfData(Map<String, dynamic> data) async {
    await saveStepSixData(data);

    SingleFileResponse response = data["media"].first as SingleFileResponse;

    await FileManager.save("fyndaHostelMedia", data["media"]);
    await FileManager.saveInt(_stepIndex, 7);
  }

  static Future<Map<String, dynamic>> loadStepSixHalfData() async {
    List<String>? rules = await FileManager.loadStringList("fyndaHostelMedia");
    return {
      "medias": rules,
    };
  }

  static Future<void> saveStepSevenData(Map<String, dynamic> data) async {
    await saveStepSixHalfData(data);

    await FileManager.save("fyndaHostelRoomVacancy", data["isAnyRoomVacant"]);
    await FileManager.saveInt(_stepIndex, 8);
  }

  static Future<Map<String, dynamic>> loadStepSevenData() async {
    bool? vacancy = await FileManager.loadBool("fyndaHostelRoomVacancy");
    return {"isAnyRoomVacant": vacancy};
  }


  static Future<void> saveStepEightData(Map<String, dynamic> data) async {
    await saveStepSevenData(data);

    List<Map<String, dynamic>> rooms = data["rooms"] as List<Map<String, dynamic>>;

    await FileManager.saveInt("fyndaHostelRooms", rooms.length);

    for(int i = 0; i < rooms.length; ++i) {
      await _saveRoom(rooms[i], i);
    }

    await FileManager.saveInt(_stepIndex, 9);
  }

  static Future<Map<String, dynamic>> loadStepEightData() async {
    int? total = await FileManager.loadInt("fyndaHostelRooms");
    if(total == null || total <= 0) {
      return {"rooms" : []};
    }

    List<Map<String, dynamic>> rooms = [];

    for(int i = 0; i < total; ++i) {
      Map<String, dynamic> room = await _loadRoom(i);
      rooms.add(room);
    }

    return {"rooms": rooms};
  }


  static Future<void> _saveRoom(Map<String, dynamic> data, int index) async {
    await FileManager.save("room${index}Name", data["name"]);
    await FileManager.saveDouble("room${index}Price", data["price"]);
    await FileManager.saveStringList("room${index}Facilities", data["facilities"]);
    await FileManager.save("room${index}Duration", data["duration"]);
    await FileManager.saveDouble("room${index}Size", data["roomSize"]);
  }

  static Future<Map<String, dynamic>> _loadRoom(int index) async {
    String? name = await FileManager.load("room${index}Name");
    double? price = await FileManager.loadDouble("room${index}Price");
    double? size = await FileManager.loadDouble("room${index}Size");
    List<String>? facilities = await FileManager.loadStringList("room${index}Facilities");
    String? duration = await FileManager.load("room${index}Duration");


    return {
      "name": name,
      "price": price,
      "facilities": facilities,
      "duration": duration,
      "roomSize": size,
    };
  }

  static Future<void> _clearRooms() async {
    int? total = await FileManager.loadInt("fyndaHostelRooms");
    if(total == null || total <= 0) {
      return;
    }

    for(int i = 0; i < total; ++i) {
      await _clearRoom(i);
    }

    await FileManager.saveInt("fyndaHostelRooms", 0);
  }

  static Future<void> _clearRoom(int index) async {
    await FileManager.save("room${index}Name", "");
    await FileManager.saveDouble("room${index}Price", 0.0);
    await FileManager.saveDouble("room${index}Size", 0.0);
    await FileManager.saveStringList("room${index}Facilities", []);
    await FileManager.save("room${index}Duration", "");
  }


  static Future<void> saveStepTenData(Map<String, dynamic> data) async {
    await saveStepEightData(data);
    await FileManager.saveInt(_stepIndex, 10);
  }

  static Future<Map<String, dynamic>> loadStepTenData() async {
    Map<String, dynamic> data = {};
    data.addAll(await loadStepOneData());
    data.addAll(await loadStepTwoData());
    data.addAll(await loadStepThreeData());
    data.addAll(await loadStepFourData());
    data.addAll(await loadStepFiveData());
    data.addAll(await loadStepSixData());
    data.addAll(await loadStepSixHalfData());
    data.addAll(await loadStepSevenData());
    data.addAll(await loadStepEightData());
    return data;
  }
}
