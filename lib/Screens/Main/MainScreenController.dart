import 'package:flutter/material.dart';
import 'package:rss_client/Exceptions/HTMLExceptions/HTMLException.dart';
import 'package:rss_client/Services/DataBase/Storages/ChannelStorage.dart';
import 'package:rss_client/Services/RSSParserService.dart';
import 'package:rss_client/Views/CustomDialogs/ErrorDialog.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreenController {

  BuildContext context;

  Future<void> addNewSourceUrl(String sourceUrl) async {
    try {
      final channel = await RSSParserService.parseRSSChannel(sourceUrl);
      await ChannelStorage.insert(channel);
    } on HTMLException catch (error) {
      await showDialog(
          context: context,
          child: ErrorDialog(message: error.cause)
      );
    } catch (_) {
      await showDialog(
          context: context,
          child: ErrorDialog(message: 'network_problem'.tr())
      );
    }
  }

}