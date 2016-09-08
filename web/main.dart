import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import 'package:dnd_gui_angular2/views/main_app/main_app.dart';
import 'package:dnd_gui_angular2/services/logger_service.dart';

const String APP_NAME = "dnd_gui_angular2";
final bool _debugMode = window.location.host.contains('localhost');
final LoggerService _log = new LoggerService(appName: APP_NAME, debugMode: _debugMode);

main() {

  bootstrap(MainApp, [provide(LoggerService, useValue: _log)]);
}