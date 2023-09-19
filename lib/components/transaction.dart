import 'package:equatable/equatable.dart';

enum TransactionStatus { none, failed, pending, success }

enum TransactionType { none, credit, debit }

class Transaction extends Equatable {
  final String id;

  final String purpose;
  final DateTime timestamp;
  final double amount;
  final TransactionStatus status;
  final TransactionType type;

  final String receiver;
  final String? hostel;
  final String? bankName;
  final String? accountNumber;
  final double vat;

  final String paymentID;

  const Transaction({
    this.id = "",
    this.purpose = "",
    required this.timestamp,
    this.amount = 0.0,
    this.vat = 0.0,
    this.receiver = "",
    this.accountNumber,
    this.bankName,
    this.paymentID = "",
    this.hostel = "",
    this.status = TransactionStatus.none,
    this.type = TransactionType.none,
  });

  @override
  List<Object?> get props => [id];

  Transaction.fromJson(Map<String, dynamic> map)
      : id = map["_id"],
        status = (map["status"] == "Failed")
            ? TransactionStatus.failed
            : (map["status"] == "Pending"
                ? TransactionStatus.pending
                : (map["status"] == "Successful"
                    ? TransactionStatus.success
                    : TransactionStatus.none)),
        timestamp = DateTime.parse(map["createdAt"]),
        amount = map["amount"],
        type = map["type"] == "Credit"
            ? TransactionType.credit
            : (map["type"] == "Debit")
                ? TransactionType.debit
                : TransactionType.none,
        bankName = map["bankName"],
        hostel = map["hostel"],
        accountNumber = map["accountName"],
        purpose = map["purpose"],
        vat = map["VAT"],
        paymentID = map["paymentID"],
        receiver = map["receiver"];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": fromStatus(status),
        "type": fromType(type),
        "createdAt": timestamp.toString(),
        "amount": amount,
        "purpose": purpose,
        "bankName": bankName,
        "hostel": hostel,
        "accountNumber": accountNumber,
        "VAT": vat,
        "paymentID": paymentID,
        "receiver": receiver,
      };
}

String fromType(TransactionType type) {
  switch (type) {
    case TransactionType.credit:
      return "Credit";
    case TransactionType.debit:
      return "Debit";
    case TransactionType.none:
      return "";
  }
}

String fromStatus(TransactionStatus status) {
  switch (status) {
    case TransactionStatus.failed:
      return "Failed";
    case TransactionStatus.pending:
      return "Pending";
    case TransactionStatus.success:
      return "Successful";
    case TransactionStatus.none:
      return "";
  }
}
