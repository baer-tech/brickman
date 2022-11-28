import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml_modify/yaml_modify.dart';

Future run(HookContext context) async {
  await _runEditLocalPubspec(context);
  await _runEditRootPubspec(context);
  await _runFlutterPubGet(context);
}

Future<void> _runEditRootPubspec(HookContext context) async {
  final logger = context.logger;

  try {
    File file = File("../pubspec.yaml");

    final yaml = loadYaml(file.readAsStringSync());

    final modifiable = getModifiableNode(yaml);
    modifiable['dependencies'] = {
      ...modifiable['dependencies'],
      'splash': {'path': 'features/splash'}
    };

    final strYaml = toYamlString(modifiable);
    File("../pubspec.yaml").writeAsStringSync(strYaml);
  } on FileSystemException catch (_) {
    logger.alert(
      red.wrap(
        'Could not find pubspec.yaml',
      ),
    );

    throw Exception();
  } on Exception catch (e) {
    throw e;
  }
}

Future<void> _runEditLocalPubspec(HookContext context) async {
  final logger = context.logger;

  try {
    File file = File("./pubspec.yaml");

    final yaml = loadYaml(file.readAsStringSync());

    final modifiable = getModifiableNode(yaml);
    modifiable['dependencies'] = {
      ...modifiable['dependencies'],
      "${context.vars['project_name']}": {'path': '../..'}
    };

    final strYaml = toYamlString(modifiable);
    File("./pubspec.yaml").writeAsStringSync(strYaml);
  } on FileSystemException catch (_) {
    logger.alert(
      red.wrap(
        'Could not find pubspec.yaml',
      ),
    );

    throw Exception();
  } on Exception catch (e) {
    throw e;
  }
}

Future<void> _runFlutterPubGet(HookContext context) async {
  final flutterPubGetProgress = context.logger.progress(
    'running "flutter pub get"',
  );
  final result = await Process.start(
    'flutter',
    ['pub', 'get'],
    workingDirectory: context.vars['project_name'],
  );

  final exitCode = await result.exitCode;

  if (exitCode == 0) {
    flutterPubGetProgress.complete('Flutter pub get successfully finished.');
  } else {
    final errorBytes = await result.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    flutterPubGetProgress.complete(
      'Flutter pub get had an error $error.',
    );
    exit(exitCode);
  }
}
