import 'dart:convert';
import 'dart:io';

import 'package:app_reference_architecture/entities/receipt.dart';
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'checkout_service.g.dart';

final httpClient = HttpClient();

@Inherited()
class CheckoutService {
  final String backendUrl;

  CheckoutService({this.backendUrl});

  Future<Receipt> checkout({int fruitsCount, int vegetablesCount}) async {
    final req = await httpClient.openUrl(
      'POST',
      Uri.parse('$backendUrl/fruits/checkout'),
    );

    req.headers.add('Content-Type', 'application/json');

    final reqBody = json.encode({
      'fruits': fruitsCount,
      'vegetables': vegetablesCount,
    });

    req.write(reqBody);

    final res = await req.close();

    if (res.statusCode == 200) {
      final responseText = await utf8.decodeStream(res);
      final data = json.decode(responseText);

      return Receipt()
        ..fruitsCount = data['fruits']
        ..vegetablesCount = data['vegetables'];
    } else {
      throw new Exception('Something went wrong');
    }
  }
}
