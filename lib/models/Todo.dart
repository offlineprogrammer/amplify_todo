/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Todo type in your schema. */
@immutable
class Todo extends Model {
  static const classType = const _TodoModelType();
  final String id;
  final String name;
  final TemporalTimestamp createdAt;
  final TemporalTimestamp updatedAt;
  final bool isDone;
  final String userId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Todo._internal(
      {@required this.id,
      @required this.name,
      this.createdAt,
      this.updatedAt,
      this.isDone,
      this.userId});

  factory Todo(
      {String id,
      @required String name,
      TemporalTimestamp createdAt,
      TemporalTimestamp updatedAt,
      bool isDone,
      String userId}) {
    return Todo._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isDone: isDone,
        userId: userId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isDone == other.isDone &&
        userId == other.userId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Todo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toString() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.toString() : "null") +
        ", ");
    buffer.write(
        "isDone=" + (isDone != null ? isDone.toString() : "null") + ", ");
    buffer.write("userId=" + "$userId");
    buffer.write("}");

    return buffer.toString();
  }

  Todo copyWith(
      {String id,
      String name,
      TemporalTimestamp createdAt,
      TemporalTimestamp updatedAt,
      bool isDone,
      String userId}) {
    return Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDone: isDone ?? this.isDone,
        userId: userId ?? this.userId);
  }

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        createdAt = json['createdAt'] != null
            ? TemporalTimestamp.fromSeconds(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalTimestamp.fromSeconds(json['updatedAt'])
            : null,
        isDone = json['isDone'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt?.toSeconds(),
        'updatedAt': updatedAt?.toSeconds(),
        'isDone': isDone,
        'userId': userId
      };

  static final QueryField ID = QueryField(fieldName: "todo.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static final QueryField ISDONE = QueryField(fieldName: "isDone");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Todo";
    modelSchemaDefinition.pluralName = "Todos";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Todo.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Todo.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Todo.UPDATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Todo.ISDONE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Todo.USERID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();

  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
}
