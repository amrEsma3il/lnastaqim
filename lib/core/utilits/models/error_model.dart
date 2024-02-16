

class ErrorModel {
  String? msg;
  String? field;

  ErrorModel({this.msg, this.field});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    field = json['field'];
  }

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'field': field,
      };
}
