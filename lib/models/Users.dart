/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final String username;
  final String email;
  final String imageKey;
  final String imageUrl;
  final bool isVerified;
  final TemporalDateTime createdAt;
  final List<Todo> todos;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Users._internal(
      {@required this.id,
      this.username,
      this.email,
      @required this.imageKey,
      @required this.imageUrl,
      this.isVerified,
      this.createdAt,
      this.todos});

  factory Users(
      {String id,
      String username,
      String email,
      @required String imageKey,
      @required String imageUrl,
      bool isVerified,
      TemporalDateTime createdAt,
      List<Todo> todos}) {
    return Users._internal(
        id: id == null ? UUID.getUUID() : id,
        username: username,
        email: email,
        imageKey: imageKey,
        imageUrl: imageUrl,
        isVerified: isVerified,
        createdAt: createdAt,
        todos: todos != null ? List<Todo>.unmodifiable(todos) : todos);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        imageKey == other.imageKey &&
        imageUrl == other.imageUrl &&
        isVerified == other.isVerified &&
        createdAt == other.createdAt &&
        DeepCollectionEquality().equals(todos, other.todos);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$username" + ", ");
    buffer.write("email=" + "$email" + ", ");
    buffer.write("imageKey=" + "$imageKey" + ", ");
    buffer.write("imageUrl=" + "$imageUrl" + ", ");
    buffer.write("isVerified=" +
        (isVerified != null ? isVerified.toString() : "null") +
        ", ");
    buffer.write(
        "createdAt=" + (createdAt != null ? createdAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Users copyWith(
      {String id,
      String username,
      String email,
      String imageKey,
      String imageUrl,
      bool isVerified,
      TemporalDateTime createdAt,
      List<Todo> todos}) {
    return Users(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        imageKey: imageKey ?? this.imageKey,
        imageUrl: imageUrl ?? this.imageUrl,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        todos: todos ?? this.todos);
  }

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        imageKey = json['imageKey'],
        imageUrl = json['imageUrl'],
        isVerified = json['isVerified'],
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        todos = json['todos'] is List
            ? (json['todos'] as List)
                .map((e) => Todo.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'imageKey': imageKey,
        'imageUrl': imageUrl,
        'isVerified': isVerified,
        'createdAt': createdAt?.format(),
        'todos': todos?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "users.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField IMAGEKEY = QueryField(fieldName: "imageKey");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageUrl");
  static final QueryField ISVERIFIED = QueryField(fieldName: "isVerified");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField TODOS = QueryField(
      fieldName: "todos",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Todo).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.USERNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.EMAIL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.IMAGEKEY,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.IMAGEURL,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.ISVERIFIED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Users.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Users.TODOS,
        isRequired: false,
        ofModelName: (Todo).toString(),
        associatedKey: Todo.USERID));
  });
}

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();

  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
}
