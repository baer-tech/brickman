import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml_modify/yaml_modify.dart';

Future run(HookContext context) async {
  final logger = context.logger;

  final directory = Directory.current.path;
  List<String> folders;

  try {
    if (Platform.isWindows) {
      folders = directory.split(r'\').toList();
    } else {
      folders = directory.split('/').toList();
    }
    logger.alert(
      red.wrap(
        'Directory: $directory - $folders',
      ),
    );
    final libIndex = folders.indexWhere((folder) => folder == 'lib');
    final pubSpecFile = File('${folders.sublist(0, libIndex).join('/')}/pubspec.yaml');

    final yaml = loadYaml(pubSpecFile.readAsStringSync());

    final modifiable = getModifiableNode(yaml);
    modifiable['dependencies'] = {
      'splash': {'path': 'features/splash'}
    };

    final strYaml = toYamlString(modifiable);
    File("pubspec.yaml").writeAsStringSync(strYaml);
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
