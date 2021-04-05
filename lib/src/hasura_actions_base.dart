import 'dart:async';
import 'package:shelf/shelf.dart';

import 'hasura_trigger.dart';
import 'hasura_request.dart';

typedef BindCallbackAction = FutureOr<Response> Function(ActionRequest action);
typedef BindCallbackTrigger = FutureOr<Response> Function(TriggerRequest action);
typedef HasuraHandler = Future<Response> Function(Request);

HasuraHandler hasuraActions(Map<String, BindCallbackAction> actions) => (Request request) => _hasuraActionProcess(request, actions);

Future<Response> _hasuraActionProcess(Request request, Map<String, BindCallbackAction> actions) async {
  if (request.method != 'POST') {
    throw Exception('Request needs to be POST');
  }

  final json = await request.readAsString();
  final action = ActionRequest.fromJson(json, request);
  if (!actions.containsKey(action.actionName)) {
    throw Exception('Action ${action.actionName} not found');
  }
  return await actions[action.actionName]!(action);
}

HasuraHandler hasuraTrigger(Map<String, BindCallbackTrigger> events) => (Request request) => _hasuraTriggerProcess(request, events);

Future<Response> _hasuraTriggerProcess(Request request, Map<String, BindCallbackTrigger> events) async {
  if (request.method != 'POST') {
    throw Exception('Request needs to be POST');
  }

  final json = await request.readAsString();
  final event = TriggerRequest.fromJson(json, request);
  if (!events.containsKey(event.triggerName)) {
    throw Exception('Action ${event.triggerName} not found');
  }
  return await events[event.triggerName]!(event);
}
