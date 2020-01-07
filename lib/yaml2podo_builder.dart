import 'dart:convert';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:yaml/yaml.dart' as _yaml;
import 'package:yaml2podo/version.dart';
import 'package:yaml2podo/yaml2podo_generator.dart';

Builder yaml2podoBuilder(BuilderOptions options) => Yaml2PodoBuilder();

class Yaml2PodoBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.yaml2podo.yaml': ['.yaml2podo.dart']
  };

  @override
  Future build(BuildStep buildStep) async {
    final info = buildStep.inputId.changeExtension('.dart');
    final inputId = buildStep.inputId;
    final data = await buildStep.readAsString(inputId);
    var yaml = _yaml.loadYaml(data) ?? <String, dynamic>{};
    if (yaml is! Map) {
      throw FormatException('Invalid source format: $inputId');
    }

    // TODO: Add suuport of BuilderOptions
    var camelize = true;
    var format = true;
    var immutable = true;
    var store = true;
    final generator =
        Yaml2PodoGenerator(camelize: camelize, immutable: immutable);
    final result = generator.generate(yaml as Map);
    final lines = <String>[];
    lines.add('// Generated by \'yaml2podo\'');
    lines.add('// Version: ${version}');
    lines.add('// https://pub.dev/packages/yaml2podo');
    lines.add('');
    lines.addAll(result);
    if (store) {
      lines.add('');
      lines.add('/*');
      lines.addAll(LineSplitter().convert(data).toList());
      lines.add('*/');
    }

    var code = lines.join('\n');
    if (format) {
      var formatter = DartFormatter();
      code = formatter.format(code);
    }

    await buildStep.writeAsString(info, code);
  }
}
