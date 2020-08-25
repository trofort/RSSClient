
import 'package:rss_client/Exceptions/AppException.dart';

class DataBaseException extends AppException {

  static final DataBaseException cannotCreateDB = DataBaseException('Can\'t create database.');
  static final DataBaseException cannotInsertNewItemToDB = DataBaseException('Can\'t insert new item to database.');
  static final DataBaseException cannotLoadDB = DataBaseException('Can\'t load database.');
  static final DataBaseException cannotRemoveItemFromDB = DataBaseException('Can\'t remove item from database.');
  static final DataBaseException cannotUpdateItemFromDB = DataBaseException('Can\'t update item from database.');

  DataBaseException(String cause): super(cause);

}