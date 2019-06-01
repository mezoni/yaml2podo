import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as _path;
import 'package:yaml/yaml.dart' as _yaml;
import 'package:yaml2podo/yaml2podo.dart';

void main(List<String> args) {
  var argParser = ArgParser();
  argParser.addFlag('camelize',
      defaultsTo: true, help: 'Allows caramelization of property names');
  argParser.addFlag('help',
      defaultsTo: false, help: 'Displays help information');
  ArgResults argResults;
  void usage() {
    print('Usage: yaml2podo [options] path/to/json/objects.yaml');
  }

  try {
    argResults = argParser.parse(args);
  } on FormatException {
    usage();
    exit(-1);
  }

  if (argResults['help'] as bool) {
    usage();
    print(argParser.usage);
    exit(0);
  }

  if (argResults.rest.length != 1) {
    usage();
    print('Missing json objects prototype file name');
    exit(0);
  }

  var camelize = argResults['camelize'] as bool;
  var inputFileName = argResults.rest[0];
  var inputFile = File(inputFileName);
  var data = inputFile.readAsStringSync();
  var source = _yaml.loadYaml(data);
  var generator = Yaml2PodoGenerator(camelize: camelize);
  var result = generator.generate(source as Map);
  var dirName = _path.dirname(inputFileName);
  var outputFileName = _path.basenameWithoutExtension(inputFileName);
  outputFileName = _path.join(dirName, outputFileName + '.dart');
  var outputFile = File(outputFileName);
  var lines = <String>[];
  lines.add(
      '// Generated by \'yaml2podo\', https://pub.dev/packages/yaml2podo');
  lines.add('');
  lines.addAll(result);
  var formatter = new DartFormatter();
  var code = formatter.format(lines.join('\n'));
  outputFile.writeAsStringSync(code);
}
