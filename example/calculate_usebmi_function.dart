import 'package:shelf/shelf.dart';
import 'package:shelf_hasura_actions/hasura_actions.dart';

Future<Response> calculateUseBmi(ActionRequest action) async {
  return Response.ok('result": ok');
}
