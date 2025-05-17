import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

void main() async {
  final libDir = Directory('lib');
  final dartFiles = libDir
      .listSync(recursive: true)
      .where((f) => f is File && f.path.endsWith('.dart'))
      .cast<File>();

  final allStrings = <String, List<String>>{};

  for (final file in dartFiles) {
    final content = await file.readAsString();

    final result = parseString(content: content);
    final visitor = HardcodedTextExtractor();
    result.unit.accept(visitor);

    if (visitor.strings.isNotEmpty) {
      allStrings[file.path] = visitor.strings;
    }
  }

  final output = StringBuffer();
  output.writeln('"File","Text"');

  for (final entry in allStrings.entries) {
    final filePath = entry.key.replaceAll('\\', '/');
    for (final text in entry.value) {
      final safeText = text.replaceAll('"', '""');
      output.writeln('"$filePath","$safeText"');
    }
  }

  final outputFile = File('hardcoded_texts.csv');
  await outputFile.writeAsString(output.toString());
print("lenghth of all strings: ${allStrings.length}");
  print('✅ CSV file written to: ${outputFile.path}');
}

class HardcodedTextExtractor extends RecursiveAstVisitor<void> {
  final List<String> strings = [];

  static const textWidgets = [
    'Text',
    'TextSpan',
    'SelectableText',
    'RichText',
    'AppBar',
    'TextField',
    'TextFormField',
    'InputDecoration',
    'ElevatedButton',
    'OutlinedButton',
    'TextButton',
    'CupertinoButton',
    'CupertinoAlertDialog',
    'CupertinoNavigationBar',
    'CupertinoActionSheet',
    'AlertDialog',
    'SnackBar',
    'BottomNavigationBarItem',
    'BottomSheet',
    'ListTile',
    'CheckboxListTile',
    'RadioListTile',
    'SwitchListTile',
    'ExpansionTile',
    'PopupMenuItem',
    'Tooltip',
    'DrawerHeader',
    'NavigationRailDestination',
    'Tab',
    'Step',
    'SimpleDialogOption',
    'DropdownMenuItem',
    'AboutListTile',
    'Chip',
  ];

  static const textProperties = [
    'title',
    'subtitle',
    'labelText',
    'hintText',
    'helperText',
    'errorText',
    'tooltip',
    'text',
    'message',
    'content',
    'semanticLabel',
    'header',
  ];
@override
void visitInstanceCreationExpression(InstanceCreationExpression node) {
  final constructorName = node.constructorName.type.name2.toString();

  const textWidgets = [
    'Text',
    'TextSpan',
    'AppBar',
    'TextField',
    'ElevatedButton',
    'OutlinedButton',
    'TextButton',
    'CupertinoButton',
    'AlertDialog',
    'SnackBar',
    'BottomNavigationBarItem',
    'ListTile',
  ];

  if (!textWidgets.contains(constructorName)) return;

  for (final arg in node.argumentList.arguments) {
    final expressions = <Expression>[];

    if (arg is NamedExpression) {
      expressions.add(arg.expression);
    } else {
      expressions.add(arg);
    }

    for (final expr in expressions) {
      _extractTextFromExpression(expr);
    }
  }

  super.visitInstanceCreationExpression(node);
}

void _extractTextFromExpression(Expression expr) {
  // 1. نص ثابت مباشر
  if (expr is StringLiteral &&
      expr.stringValue != null &&
      expr.stringValue!.trim().isNotEmpty) {
    strings.add(expr.stringValue!);
  }

  // 2. String Interpolation: "نص ${...}"
  else if (expr is StringInterpolation) {
    for (final element in expr.elements) {
      if (element is InterpolationString &&
          element.value.trim().isNotEmpty) {
        strings.add(element.value.trim());
      }
    }
  }

  // 3. Method call على Interpolation أو على String عادي
  else if (expr is MethodInvocation) {
    final target = expr.target;

    if (target is StringInterpolation) {
      for (final element in target.elements) {
        if (element is InterpolationString &&
            element.value.trim().isNotEmpty) {
          strings.add(element.value.trim());
        }
      }
    }

    if (target is StringLiteral &&
        target.stringValue != null &&
        target.stringValue!.trim().isNotEmpty) {
      strings.add(target.stringValue!);
    }
  }

  // 4. داخل Text(...) متداخل
  else if (expr is InstanceCreationExpression &&
      expr.constructorName.type.name2.toString() == 'Text') {
    for (final innerArg in expr.argumentList.arguments) {
      _extractTextFromExpression(innerArg);
    }
  }
}
}
