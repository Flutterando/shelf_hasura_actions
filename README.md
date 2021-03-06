# shelf_hasura_actions

Shelf Middleware for Hasura Action. See [Hasura Action Doc](https://hasura.io/docs/latest/graphql/core/actions/index.html)

## Usage Action

A simple usage example :

```dart
import 'package:shelf_hasura_actions/shelf_hasura_actions.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'calculate_usebmi_function.dart' as bmi;

void main() async {
  //get handler
  final hasuraHandler = hasuraActions(_actions);

  // just put in shelf pipeline
  var server = await io.serve(hasuraHandler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}


//my actions list
const _actions = <String, BindCallbackAction>{
  'bmiAction': bmi.calculateUseBmi,
};
```

## Action Function example:

```dart
import 'package:shelf_hasura_actions/src/hasura_request.dart';
import 'package:shelf/shelf.dart';

Future<Response> calculateUseBmi(ActionRequest action) async {
  return Response.ok('result": ok');
}
```

## Usage Trigger

A simple usage example :

```dart
import 'package:shelf_hasura_actions/shelf_hasura_actions.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'calculate_usebmi_function.dart' as bmi;

void main() async {
  //get handler
  final hasuraHandler = hasuraTrigger(_actions);

  // just put in shelf pipeline
  var server = await io.serve(hasuraHandler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}


//my actions list
const _actions = <String, BindCallbackTrigger>{
  'bmiAction': bmi.calculateUseBmi,
};
```

## Trigger Function example:

```dart
import 'package:shelf_hasura_actions/src/hasura_request.dart';
import 'package:shelf/shelf.dart';

Future<Response> calculateUseBmi(TriggerRequest action) async {
  return Response.ok('result": ok');
}
```




## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

