// To parse this JSON data, do
//
//     final withdrawMoneyModel = withdrawMoneyModelFromJson(jsonString);

import 'dart:convert';

WithdrawMoneyModel withdrawMoneyModelFromJson(String str) =>
    WithdrawMoneyModel.fromJson(json.decode(str));

String withdrawMoneyModelToJson(WithdrawMoneyModel data) =>
    json.encode(data.toJson());

class WithdrawMoneyModel {
  String? id;
  String? userId;
  String? type;
  dynamic amount;
  dynamic trxId;
  dynamic referenceWalletBillId;
  dynamic sendMoneyDetailsId;
  String? withdrawRequestQueueId;
  bool? isOrder;
  String? createdBy;
  String? createdAt;
  int? v;
  List<dynamic>? withdrawrequestDetails;

  WithdrawMoneyModel({
    this.id,
    this.userId,
    this.type,
    this.amount,
    this.trxId,
    this.referenceWalletBillId,
    this.sendMoneyDetailsId,
    this.withdrawRequestQueueId,
    this.isOrder,
    this.createdBy,
    this.createdAt,
    this.v,
    this.withdrawrequestDetails,
  });

  WithdrawMoneyModel copyWith({
    String? id,
    String? userId,
    String? type,
    dynamic amount,
    dynamic trxId,
    dynamic referenceWalletBillId,
    dynamic sendMoneyDetailsId,
    String? withdrawRequestQueueId,
    bool? isOrder,
    String? createdBy,
    String? createdAt,
    DateTime? updatedAt,
    int? v,
    List<dynamic>? withdrawrequestDetails,
  }) =>
      WithdrawMoneyModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        trxId: trxId ?? this.trxId,
        referenceWalletBillId:
            referenceWalletBillId ?? this.referenceWalletBillId,
        sendMoneyDetailsId: sendMoneyDetailsId ?? this.sendMoneyDetailsId,
        withdrawRequestQueueId:
            withdrawRequestQueueId ?? this.withdrawRequestQueueId,
        isOrder: isOrder ?? this.isOrder,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        withdrawrequestDetails:
            withdrawrequestDetails ?? this.withdrawrequestDetails,
      );

  factory WithdrawMoneyModel.fromJson(Map<String, dynamic> json) =>
      WithdrawMoneyModel(
        id: json['_id'],
        userId: json['user_id'],
        type: json['type'],
        amount: json['amount'],
        trxId: json['trxId'],
        referenceWalletBillId: json['reference_wallet_bill_id'],
        sendMoneyDetailsId: json['send_money_details_id'],
        withdrawRequestQueueId: json['withdraw_request_queue_id'],
        isOrder: json['is_order'],
        createdBy: json['created_by'],
        createdAt: json['createdAt'],
        v: json['__v'],
        withdrawrequestDetails: json['withdrawrequestDetails'] == null
            ? []
            : List<dynamic>.from(json['withdrawrequestDetails']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user_id': userId,
        'type': type,
        'amount': amount,
        'trxId': trxId,
        'reference_wallet_bill_id': referenceWalletBillId,
        'send_money_details_id': sendMoneyDetailsId,
        'withdraw_request_queue_id': withdrawRequestQueueId,
        'is_order': isOrder,
        'created_by': createdBy,
        'createdAt': createdAt,
        '__v': v,
        'withdrawrequestDetails': withdrawrequestDetails == null
            ? []
            : List<dynamic>.from(withdrawrequestDetails!.map((x) => x)),
      };
}
