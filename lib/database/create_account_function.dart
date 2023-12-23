import 'package:greeni_care/MODEL/createAccount_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> insertAccount(CreateAccountModel value) async {
  final insertDB = await Hive.openBox<CreateAccountModel>('account');
  await insertDB.add(value);
  print('print account : ${value}');
}
