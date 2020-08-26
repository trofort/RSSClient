import 'package:easy_localization/easy_localization.dart';
import 'package:rss_client/Exceptions/AppException.dart';

class DataBaseException extends AppException {

  static final DataBaseException cannotCreateDB = DataBaseException('cant_create_database'.tr());
  static final DataBaseException cannotInsertNewItemToDB = DataBaseException('cant_insert_new_item_to_database'.tr());
  static final DataBaseException cannotLoadDB = DataBaseException('cant_load_database'.tr());
  static final DataBaseException cannotRemoveItemFromDB = DataBaseException('cant_remove_item_from_database'.tr());
  static final DataBaseException cannotUpdateItemFromDB = DataBaseException('cant_update_item_from_database'.tr());

  DataBaseException(String cause): super(cause);

}