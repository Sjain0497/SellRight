
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:sell_right/helpers/custom_trace.dart';
import 'package:http/http.dart' as http;
import '../repository/user_repository.dart' as userRepo;
import '../models/PlanPayment.dart';
Future<PlanPayment> createPlanDetaiil(String amount,String planType) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}plan_paymen_details';
  print("planRegisterUrl..$url");
//  print("registerUrlUser..$user");
  // print("registerUrlUser..${(user.toMap())}");

  final client = new http.Client();
  final response = await client.post(
      url,
      //headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      //body: json.encode(user.toMap()),
      body: {
        "plan":planType,
        "price":amount,
        "vid":userRepo.currentUser.value.id
      }
  );
  // print("RegisterResponse....${response.body}");
  print("PlanResponse....${response.body}");
  if (response.statusCode == 200) {
    //setCurrentUser(response.body);
   // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return PlanPayment.fromJSON(json.decode(response.body)['data']);
}