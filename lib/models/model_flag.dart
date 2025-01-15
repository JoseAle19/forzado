// To parse this JSON data, do
//
//     final modelFlag = modelFlagFromJson(jsonString);

import 'dart:convert';

ModelFlag modelFlagFromJson(String str) => ModelFlag.fromJson(json.decode(str));

String modelFlagToJson(ModelFlag data) => json.encode(data.toJson());

class ModelFlag {
    final bool success;
    final Values values;

    ModelFlag({
        required this.success,
        required this.values,
    });

    factory ModelFlag.fromJson(Map<String, dynamic> json) => ModelFlag(
        success: json["success"],
        values: Values.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": values.toJson(),
    };
}

class Values {
    final bool aplicaReglaRiesgoBajo;

    Values({
        required this.aplicaReglaRiesgoBajo,
    });

    factory Values.fromJson(Map<String, dynamic> json) => Values(
        aplicaReglaRiesgoBajo: json["aplicaReglaRiesgoBajo"],
    );

    Map<String, dynamic> toJson() => {
        "aplicaReglaRiesgoBajo": aplicaReglaRiesgoBajo,
    };
}
