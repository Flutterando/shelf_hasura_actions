import 'dart:convert';

import 'package:shelf/shelf.dart';

class TriggerRequest {
  final Event event;
  final String createdAt;
  final String id;
  final String triggerName;
  final Table table;
  final Request request;

  TriggerRequest({required this.event, required this.createdAt, required this.id, required this.table, required this.triggerName, required this.request});

  factory TriggerRequest.fromJson(String jsonText, Request request) {
    final json = jsonDecode(jsonText) as Map;
    return TriggerRequest(
      event: Event.fromJson(json['event']),
      createdAt: json['created_at'],
      id: json['id'],
      table: Table.fromJson(json['table']),
      triggerName: json['trigger']['name'],
      request: request,
    );
  }
}

class Event {
  final Map<String, dynamic> sessionVariables;
  final String op;
  final Map<String, dynamic> data;

  Event({required this.sessionVariables, required this.op, required this.data});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(data: json['data'], op: json['op'], sessionVariables: json['session_variables']);
  }
}

class Table {
  final String schema;
  final String name;

  Table({required this.schema, required this.name});

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(name: json['schema'], schema: json['name']);
  }
}
