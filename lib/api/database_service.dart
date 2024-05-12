import 'package:my_hostel/components/message.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static Database? _database;

  static Future<void> init() async {
    DatabaseManager._database = await openDatabase(
      "fynda.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE Messages (id INTEGER PRIMARY KEY AUTOINCREMENT, serverID TEXT NOT NULL, sender TEXT NOT NULL, receiver TEXT NOT NULL, message TEXT NOT NULL, timestamp INTEGER NOT NULL )");
      },
    );
  }

  static Future<List<Message>> getMessagesBetween(
      String currentUser, String otherUser) async {
    List<Map<String, dynamic>>? response = await _database?.query(
      "Messages",
      where: "(sender = ? AND receiver = ?) OR (sender = ? AND receiver = ?)",
      whereArgs: [currentUser, otherUser, otherUser, currentUser],
      orderBy: "timestamp ASC",
    );
    if (response == null) return [];

    List<Message> messages = [];
    for (var element in response) {
      Message msg = _fromJson(element);
      messages.add(msg);
    }

    return messages;
  }

  static Message _fromJson(Map<String, dynamic> element) => Message(
        id: element["serverID"],
        senderId: element["sender"],
        receiverId: element["receiver"],
        content: element["message"],
        media: "",
        dateSent:
            DateTime.fromMillisecondsSinceEpoch(element["timestamp"] as int),
      );

  static Map<String, dynamic> _toJson(Message message) => {
        'serverID': message.id,
        'sender': message.senderId,
        'receiver': message.receiverId,
        'message': message.content,
        'timestamp': message.dateSent.millisecondsSinceEpoch
      };

  static Future<void> addMessage(Message message) async {
    await _database?.insert("Messages", _toJson(message));
  }

  static Future<void> addMessageRaw(String id, String sender, String receiver,
      String message, DateTime time) async {
    await _database?.insert(
      "Messages",
      {
        'serverID': id,
        'sender': sender,
        'receiver': receiver,
        'message': message,
        'timestamp': time.millisecondsSinceEpoch
      },
    );
  }

  static Future<void> addMessages(List<Message> messages) async {
    List<Map<String, dynamic>> data =
        messages.map((msg) => _toJson(msg)).toList();

    await _database?.transaction((txn) async {
      for (var element in data) {
        await txn.insert("Messages", element);
      }
    });
  }

  static Future<void> clearAllMessages() async {
    await _database?.delete("Messages");
  }
}
