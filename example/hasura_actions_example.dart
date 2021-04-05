import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_hasura_actions/src/hasura_actions_base.dart';
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
