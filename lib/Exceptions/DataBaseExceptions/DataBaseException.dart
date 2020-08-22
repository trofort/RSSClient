
class DataBaseException implements Exception {

  static final DataBaseException cannotCreateDB = DataBaseException('Can\'t create database.');
  static final DataBaseException cannotInsertNewItemToDB = DataBaseException('Can\'t insert new item to database.');
  static final DataBaseException cannotLoadDB = DataBaseException('Can\'t load database.');
  static final DataBaseException cannotRemoveItemFromDB = DataBaseException('Can\'t remove channel from database.');

  String cause;
  DataBaseException(this.cause);
}