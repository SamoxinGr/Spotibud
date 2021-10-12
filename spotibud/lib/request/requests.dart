import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart';



@override
Future<String> aut() async{
  var requestTokenBody= {
    'client_id': 'd938f7d239d64003907d54e49ea451ec',
    'response_type':'code',
    'redirect_uri': 'https://www.google.com/'
  };
  final Map<String, String> tokenRequestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  Response response = await http.get(Uri.https('accounts.spotify.com', '/authorize', requestTokenBody), headers: tokenRequestHeaders,);
  Map data = convert.jsonDecode(response.body);
  print(data);
  String token = data['code'];
  //response status code
  String nu = "Ok";
  return nu;
}

