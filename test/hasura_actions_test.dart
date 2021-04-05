import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_hasura_actions/shelf_hasura_actions.dart';
import 'package:test/test.dart';

void main() {
  test('get response action', () async {
    final response = await hasuraActions(_actions)(Request('POST', Uri.http('localhost', '/'), body: jsonHasura));

    expect(response.statusCode, 200);
    expect(response.readAsString(), completion('ok'));
  });
}

const _actions = <String, BindCallbackAction>{
  'testAction': _myFunctionTest,
};

FutureOr<Response> _myFunctionTest(ActionRequest action) {
  return Response.ok('ok');
}

const jsonHasura = r''' 
{
  "action": {
    "name": "testAction"
  },
  "input": {
		"person": {
			"arg1": 80,
			"arg2": 80
		}
	},
  "session_variables": {
    "x-hasura-user-id": "<session-user-id>",
    "x-hasura-role": "<session-user-role>"
  }
}

''';
