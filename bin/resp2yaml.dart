import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as _path;
import 'package:yaml2podo/resp2yaml.dart';
import 'package:yaml2podo/version.dart';

void main(List<String> args) {
  var argParser = ArgParser();
  argParser.addFlag('help',
      defaultsTo: false, help: 'Displays help information');
  argParser.addOption('out', help: 'Output file name');
  ArgResults argResults;
  void usage() {
    print('Usage: resp2yaml [options] path/to/resposnse.json');
  }

  void error(String message) {
    usage();
    print(message);
    exit(0);
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

  if (argResults.rest.isEmpty) {
    error('Missing json request data file name(s)');
  }

  var outputFullPath = argResults['out'] as String;
  var fileNames = argResults.rest;
  if (outputFullPath == null) {
    if (fileNames.length > 1) {
      error('Missing output file name');
    }

    var inputFileName = fileNames[0];
    var outputFileName = _path.basenameWithoutExtension(inputFileName);
    var dirName = _path.dirname(inputFileName);
    outputFullPath = _path.join(dirName, outputFileName + '.yaml');
  }

  var lines = <String>[];
  lines.add('# Generated by \'resp2yaml\'');
  lines.add('# Version: ${version}');
  lines.add('# https://pub.dev/packages/yaml2podo');
  lines.add('');
  for (var fileName in fileNames) {
    var inputFile = File(fileName);
    var text = inputFile.readAsStringSync();
    var jsonObject = jsonDecode(text);
    var generator = Resp2YamlGenerator();
    var name = _path.basenameWithoutExtension(fileName);
    lines.add('# ${fileName}');
    var result = generator.generate(jsonObject, [name]);
    lines.addAll(result);
  }

  var outputFile = File(outputFullPath);
  outputFile.writeAsStringSync(lines.join('\n'));
}
