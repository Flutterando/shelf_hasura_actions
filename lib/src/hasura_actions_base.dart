//@dart=2.9
import 'dart:async';
import 'package:shelf/shelf.dart';

import 'hasura_request.dart';

typedef BindCallback = FutureOr<Response> Function(ActionRequest action);
typedef HasuraHandler = Future<Response> Function(Request);

HasuraHandler hasuraActions(Map<String, BindCallback> actions) => (Request request) => _hasuraActionProcess(request, actions);

Future<Response> _hasuraActionProcess(Request request, Map<String, BindCallback> actions) async {
  if (request.method != 'POST') {
    throw Exception('Request needs to be POST');
  }

  final json = await request.readAsString();
  final action = ActionRequest.fromJson(json, request);
  if (!actions.containsKey(action.actionName)) {
    throw Exception('Action ${action.actionName} not found');
  }
  return await actions[action.actionName](action);
}
