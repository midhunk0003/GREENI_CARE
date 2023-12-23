import 'package:greeni_care/MODEL/createAccount_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const ACCOUNT_DB_NAME = 'account';

abstract class AddAccountDBFunction {
  Future<void> insertAccount(CreateAccountModel values);
  Future<CreateAccountModel?> getAccount();
  Future<void> updateAccount(CreateAccountModel values, id);
}

class ACCOUNTDB implements AddAccountDBFunction {
  @override
  Future<void> insertAccount(CreateAccountModel values) async {
    final _accountDB = await Hive.openBox<CreateAccountModel>(ACCOUNT_DB_NAME);
    await _accountDB.put(values.id, values);

    print('account value in greene : ${values.toString()}');
  }

  @override
  Future<CreateAccountModel?> getAccount() async {
    // final accountDB = await Hive.openBox<CreateAccountModel>(ACCOUNT_DB_NAME);
    final userBox = Hive.box<CreateAccountModel>('account');
// Fetch the user from Hive
    final fetchedUser = userBox.get(1);
    return fetchedUser;
  }

  @override
  Future<void> updateAccount(CreateAccountModel values, id) async {
    print(' id :$id');
    print('update value : $values');
    final _accountDB = await Hive.openBox<CreateAccountModel>(ACCOUNT_DB_NAME);
    await _accountDB.put(values.id, values);
  }
}
