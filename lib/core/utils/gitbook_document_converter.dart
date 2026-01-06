/// Converts GitBook's internal document format to Markdown
class GitBookDocumentConverter {
  /// Convert a GitBook document object to markdown string
  static String toMarkdown(Map<String, dynamic> document) {
    final nodes = document['nodes'];
    if (nodes == null || nodes is! List) {
      return '';
    }

    final buffer = StringBuffer();
    for (final node in nodes) {
      if (node is Map<String, dynamic>) {
        buffer.write(_convertNode(node));
      }
    }
    return buffer.toString().trim();
  }

  static String _convertNode(Map<String, dynamic> node) {
    final object = node['object'];
    final type = node['type'];

    if (object == 'block') {
      return _convertBlock(node, type);
    } else if (object == 'inline') {
      return _convertInline(node, type);
    } else if (object == 'text') {
      return _convertText(node);
    }

    return '';
  }

  static String _convertBlock(Map<String, dynamic> node, String? type) {
    final content = _getNodeContent(node);

    switch (type) {
      case 'heading-1':
        return '# $content\n\n';
      case 'heading-2':
        return '## $content\n\n';
      case 'heading-3':
        return '### $content\n\n';
      case 'heading-4':
        return '#### $content\n\n';
      case 'heading-5':
        return '##### $content\n\n';
      case 'heading-6':
        return '###### $content\n\n';
      case 'paragraph':
        return '$content\n\n';
      case 'blockquote':
        final lines = content.split('\n');
        return '${lines.map((l) => '> $l').join('\n')}\n\n';
      case 'code':
        return _convertCodeBlock(node);
      case 'code-line':
        return '$content\n';
      case 'list-unordered':
        return _convertList(node, ordered: false);
      case 'list-ordered':
        return _convertList(node, ordered: true);
      case 'list-item':
        return content;
      case 'hint':
        final style = node['data']?['style'] ?? 'info';
        return '> **$style**: $content\n\n';
      case 'divider':
        return '---\n\n';
      case 'table':
        return _convertTable(node);
      case 'image':
      case 'images':
        return _convertImage(node);
      default:
        // For unknown block types, just return the content
        if (content.isNotEmpty) {
          return '$content\n\n';
        }
        return '';
    }
  }

  static String _convertInline(Map<String, dynamic> node, String? type) {
    final content = _getNodeContent(node);

    switch (type) {
      case 'inline-image':
        final data = node['data'];
        final ref = data?['ref'];
        String? url;
        if (ref is Map) {
          url = ref['url']?.toString();
        }
        final alt = data?['alt']?.toString() ?? '';
        if (url != null) {
          return '![$alt]($url)';
        }
        return '';
      case 'link':
        final data = node['data'];
        final ref = data?['ref'];
        String? url;
        if (ref is Map) {
          url = ref['url']?.toString();
        }
        if (url != null) {
          return '[$content]($url)';
        }
        return content;
      default:
        return content;
    }
  }

  static String _convertText(Map<String, dynamic> node) {
    final leaves = node['leaves'];
    if (leaves == null || leaves is! List) {
      return '';
    }

    final buffer = StringBuffer();
    for (final leaf in leaves) {
      if (leaf is Map<String, dynamic>) {
        buffer.write(_convertLeaf(leaf));
      }
    }
    return buffer.toString();
  }

  static String _convertLeaf(Map<String, dynamic> leaf) {
    var text = leaf['text']?.toString() ?? '';
    final marks = leaf['marks'];

    if (marks is List && marks.isNotEmpty) {
      for (final mark in marks) {
        if (mark is Map<String, dynamic>) {
          text = _applyMark(text, mark);
        }
      }
    }

    return text;
  }

  static String _applyMark(String text, Map<String, dynamic> mark) {
    final type = mark['type'];

    switch (type) {
      case 'bold':
        return '**$text**';
      case 'italic':
        return '*$text*';
      case 'strikethrough':
        return '~~$text~~';
      case 'code':
        return '`$text`';
      case 'underline':
        // Markdown doesn't have native underline, use HTML
        return '<u>$text</u>';
      case 'color':
        // Just return text without color formatting for markdown
        return text;
      default:
        return text;
    }
  }

  static String _getNodeContent(Map<String, dynamic> node) {
    final nodes = node['nodes'];
    if (nodes == null || nodes is! List) {
      return '';
    }

    final buffer = StringBuffer();
    for (final child in nodes) {
      if (child is Map<String, dynamic>) {
        buffer.write(_convertNode(child));
      }
    }
    return buffer.toString();
  }

  static String _convertCodeBlock(Map<String, dynamic> node) {
    final data = node['data'];
    final language = data?['syntax'] ?? data?['language'] ?? '';
    final content = _getNodeContent(node);
    // Remove trailing newline from content since we add our own
    final trimmedContent = content.endsWith('\n')
        ? content.substring(0, content.length - 1)
        : content;
    return '```$language\n$trimmedContent\n```\n\n';
  }

  static String _convertList(Map<String, dynamic> node, {required bool ordered}) {
    final nodes = node['nodes'];
    if (nodes == null || nodes is! List) {
      return '';
    }

    final buffer = StringBuffer();
    var index = 1;
    for (final item in nodes) {
      if (item is Map<String, dynamic>) {
        final content = _getNodeContent(item);
        final prefix = ordered ? '$index. ' : '- ';
        buffer.write('$prefix$content\n');
        index++;
      }
    }
    buffer.write('\n');
    return buffer.toString();
  }

  static String _convertTable(Map<String, dynamic> node) {
    final nodes = node['nodes'];
    if (nodes == null || nodes is! List) {
      return '';
    }

    final buffer = StringBuffer();
    var isHeader = true;

    for (final row in nodes) {
      if (row is Map<String, dynamic>) {
        final cells = row['nodes'];
        if (cells is List) {
          final cellContents = <String>[];
          for (final cell in cells) {
            if (cell is Map<String, dynamic>) {
              cellContents.add(_getNodeContent(cell).trim());
            }
          }
          buffer.write('| ${cellContents.join(' | ')} |\n');

          // Add header separator after first row
          if (isHeader) {
            buffer.write('| ${cellContents.map((_) => '---').join(' | ')} |\n');
            isHeader = false;
          }
        }
      }
    }
    buffer.write('\n');
    return buffer.toString();
  }

  static String _convertImage(Map<String, dynamic> node) {
    final data = node['data'];
    if (data == null) return '';

    // Handle single image
    final ref = data['ref'];
    if (ref is Map) {
      final url = ref['url']?.toString();
      final alt = data['alt']?.toString() ?? '';
      if (url != null) {
        return '![$alt]($url)\n\n';
      }
    }

    // Handle multiple images
    final images = data['images'];
    if (images is List) {
      final buffer = StringBuffer();
      for (final img in images) {
        if (img is Map) {
          final imgRef = img['ref'];
          if (imgRef is Map) {
            final url = imgRef['url']?.toString();
            final alt = img['alt']?.toString() ?? '';
            if (url != null) {
              buffer.write('![$alt]($url)\n\n');
            }
          }
        }
      }
      return buffer.toString();
    }

    return '';
  }
}
