import 'dart:io';

void main(List<String> args) {
  final roots = args.isEmpty ? ['lib'] : args;
  var changed = 0;

  for (final file in _dartFiles(roots)) {
    final source = file.readAsStringSync();
    final updated = _removeStandalonePrints(source);
    if (updated != source) {
      file.writeAsStringSync(updated);
      changed++;
    }
  }

  stdout.writeln('Updated $changed Dart files.');
  final remaining = Process.runSync(
    'rg',
    ['-n', r'^\s*print\(', ...roots],
    runInShell: true,
  );
  if (remaining.stdout.toString().trim().isNotEmpty) {
    stdout.writeln('Remaining print() calls that need manual review:');
    stdout.write(remaining.stdout);
  }
}

Iterable<File> _dartFiles(List<String> roots) sync* {
  for (final root in roots) {
    final entity = FileSystemEntity.typeSync(root) == FileSystemEntityType.file
        ? File(root)
        : Directory(root);
    if (entity is File && entity.path.endsWith('.dart')) {
      yield entity;
    } else if (entity is Directory && entity.existsSync()) {
      yield* entity
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));
    }
  }
}

String _removeStandalonePrints(String source) {
  final out = StringBuffer();
  final lines = source.split('\n');

  var i = 0;
  while (i < lines.length) {
    final line = lines[i];
    if (!_startsStandalonePrint(line)) {
      out.write(i == lines.length - 1 ? line : '$line\n');
      i++;
      continue;
    }

    final statement = StringBuffer(line);
    var end = i;
    while (
        !_endsPrintStatement(statement.toString()) && end + 1 < lines.length) {
      end++;
      statement.write('\n${lines[end]}');
    }
    i = end + 1;
  }

  return out.toString();
}

bool _startsStandalonePrint(String line) {
  final trimmed = line.trimLeft();
  return trimmed.startsWith('print(');
}

bool _endsPrintStatement(String statement) {
  var parens = 0;
  var inSingle = false;
  var inDouble = false;
  var escaped = false;

  for (var i = 0; i < statement.length; i++) {
    final char = statement[i];

    if (escaped) {
      escaped = false;
      continue;
    }
    if (char == '\\') {
      escaped = true;
      continue;
    }
    if (!inDouble && char == "'") {
      inSingle = !inSingle;
      continue;
    }
    if (!inSingle && char == '"') {
      inDouble = !inDouble;
      continue;
    }
    if (inSingle || inDouble) {
      continue;
    }
    if (char == '(') {
      parens++;
    } else if (char == ')') {
      parens--;
    } else if (char == ';' && parens <= 0) {
      return true;
    }
  }

  return false;
}
