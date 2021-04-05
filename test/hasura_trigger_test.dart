import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_hasura_actions/shelf_hasura_actions.dart';
import 'package:test/test.dart';

void main() {
  test('get response action', () async {
    final response = await hasuraTrigger(_triggers)(Request('POST', Uri.http('localhost', '/'), body: jsonHasura));

    expect(response.statusCode, 200);
    expect(response.readAsString(), completion('ok'));
  });
}

const _triggers = <String, BindCallbackTrigger>{
  'test_trigger': _myFunctionTest,
};

FutureOr<Response> _myFunctionTest(TriggerRequest action) {
  return Response.ok('ok');
}

const jsonHasura = r''' 
{
  "id": "85558393-c75d-4d2f-9c15-e80591b83894",
  "created_at": "2018-09-05T07:14:21.601701Z",
  "trigger": {
      "name": "test_trigger"
  },
  "table": {
      "schema": "public",
      "name": "users"
  },
  "event": {
      "session_variables": {
          "x-hasura-role": "admin",
          "x-hasura-allowed-roles": "['user', 'boo', 'admin']",
          "x-hasura-user-id": "1"
      },
      "op": "INSERT",
      "data": {
        "old": null,
        "new": {
            "id":"42",
            "name": "john doe"
        }
      }
  }
}

''';
