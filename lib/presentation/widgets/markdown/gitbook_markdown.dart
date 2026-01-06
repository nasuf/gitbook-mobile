import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

/// GitBook-style markdown renderer with custom blocks support
class GitBookMarkdown extends StatelessWidget {
  final String data;
  final String? spaceId;
  final void Function(String pageId)? onInternalLinkTap;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;

  const GitBookMarkdown({
    super.key,
    required this.data,
    this.spaceId,
    this.onInternalLinkTap,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Markdown(
      data: _preprocessMarkdown(data),
      selectable: true,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? const EdgeInsets.all(16),
      styleSheet: _buildStyleSheet(theme),
      builders: {
        'code': _CodeBlockBuilder(isDark: isDark),
        'pre': _CodeBlockBuilder(isDark: isDark),
      },
      imageBuilder: (uri, title, alt) => _buildImage(context, uri, title, alt),
      onTapLink: (text, href, title) => _handleLinkTap(context, href),
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
    );
  }

  /// Preprocess markdown to handle GitBook-specific syntax
  String _preprocessMarkdown(String markdown) {
    var result = markdown;

    // Convert GitBook hint blocks to custom format
    result = _convertHintBlocks(result);

    // Convert GitBook tabs to custom format
    result = _convertTabBlocks(result);

    return result;
  }

  /// Convert GitBook hint blocks ({% hint style="info" %} ... {% endhint %})
  String _convertHintBlocks(String markdown) {
    final hintPattern = RegExp(
      r'\{% hint style="(\w+)" %\}(.*?)\{% endhint %\}',
      dotAll: true,
    );

    return markdown.replaceAllMapped(hintPattern, (match) {
      final style = match.group(1) ?? 'info';
      final content = match.group(2)?.trim() ?? '';
      return '\n> **$style**: $content\n';
    });
  }

  /// Convert GitBook tabs
  String _convertTabBlocks(String markdown) {
    // Simplified tab handling - convert to headers
    final tabPattern = RegExp(
      r'\{% tab title="([^"]+)" %\}(.*?)\{% endtab %\}',
      dotAll: true,
    );

    return markdown.replaceAllMapped(tabPattern, (match) {
      final title = match.group(1) ?? 'Tab';
      final content = match.group(2)?.trim() ?? '';
      return '\n#### $title\n$content\n';
    });
  }

  MarkdownStyleSheet _buildStyleSheet(ThemeData theme) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return MarkdownStyleSheet(
      // Headers
      h1: textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      h2: textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      h3: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      h4: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      h5: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      h6: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),

      // Body text
      p: textTheme.bodyLarge?.copyWith(
        height: 1.6,
        color: colorScheme.onSurface,
      ),

      // Links
      a: textTheme.bodyLarge?.copyWith(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
      ),

      // Inline code only (code blocks use custom builder)
      code: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        color: colorScheme.primary,
        backgroundColor: colorScheme.surfaceContainerHighest,
      ),
      // Remove default code block decoration - we use custom builder
      codeblockDecoration: const BoxDecoration(),
      codeblockPadding: EdgeInsets.zero,

      // Blockquote
      blockquote: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),

      // Lists
      listBullet: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      listIndent: 24,

      // Table
      tableHead: textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      tableBody: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      tableBorder: TableBorder.all(
        color: colorScheme.outlineVariant,
        width: 1,
      ),
      tableHeadAlign: TextAlign.left,
      tableCellsPadding: const EdgeInsets.all(8),

      // Horizontal rule
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),

      // Checkbox
      checkbox: textTheme.bodyLarge?.copyWith(
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    Uri uri,
    String? title,
    String? alt,
  ) {
    final theme = Theme.of(context);

    // Handle different image sources
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: uri.toString(),
            placeholder: (context, url) => Container(
              height: 200,
              color: theme.colorScheme.surfaceContainerHighest,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: 100,
              color: theme.colorScheme.errorContainer,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.broken_image,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alt ?? 'Image failed to load',
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    // Fallback for unsupported schemes
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.image, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              alt ?? uri.toString(),
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLinkTap(BuildContext context, String? href) async {
    if (href == null || href.isEmpty) return;

    // Check if it's an internal link
    if (_isInternalLink(href)) {
      final pageId = _extractPageId(href);
      if (pageId != null && onInternalLinkTap != null) {
        onInternalLinkTap!(pageId);
        return;
      }
    }

    // External link - open in browser
    final uri = Uri.tryParse(href);
    if (uri != null) {
      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cannot open link: $href')),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error opening link: $e')),
          );
        }
      }
    }
  }

  bool _isInternalLink(String href) {
    // Check for relative links or GitBook internal links
    if (href.startsWith('/') || href.startsWith('./') || href.startsWith('../')) {
      return true;
    }
    // Check for GitBook domain links
    if (href.contains('gitbook.io') || href.contains('gitbook.com')) {
      return true;
    }
    return false;
  }

  String? _extractPageId(String href) {
    // Extract page ID from href
    // This is simplified - actual implementation depends on GitBook URL structure
    final uri = Uri.tryParse(href);
    if (uri != null) {
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last;
      }
    }
    return null;
  }
}

/// Custom code block builder with syntax highlighting
class _CodeBlockBuilder extends MarkdownElementBuilder {
  final bool isDark;

  _CodeBlockBuilder({required this.isDark});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String code = element.textContent;
    String? language;

    // Extract language from code block
    if (element.attributes.containsKey('class')) {
      final className = element.attributes['class'] ?? '';
      if (className.startsWith('language-')) {
        language = className.substring(9);
      }
    }

    return _SyntaxHighlightedCode(
      code: code,
      language: language,
      isDark: isDark,
    );
  }
}

/// Syntax highlighted code block widget
class _SyntaxHighlightedCode extends StatelessWidget {
  final String code;
  final String? language;
  final bool isDark;

  const _SyntaxHighlightedCode({
    required this.code,
    this.language,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final codeTheme = isDark ? atomOneDarkTheme : githubTheme;
    // Darker background colors for better visibility
    final bgColor = isDark ? const Color(0xFF1A1A2E) : const Color(0xFFE8ECF0);
    final headerColor = isDark ? const Color(0xFF252542) : const Color(0xFFDCE1E8);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Language header with copy button
          if (language != null && language!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: headerColor,
              ),
              child: Row(
                children: [
                  Text(
                    language!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  _CopyButton(code: code),
                ],
              ),
            ),
          // Code content - use Text directly for simple rendering
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _buildCodeContent(codeTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeContent(Map<String, TextStyle> codeTheme) {
    // Use HighlightView but override its container styling
    return HighlightView(
      code.trimRight(),
      language: language ?? 'plaintext',
      theme: {
        ...codeTheme,
        'root': TextStyle(
          backgroundColor: Colors.transparent,
          color: codeTheme['root']?.color,
        ),
      },
      padding: EdgeInsets.zero,
      textStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        height: 1.5,
      ),
    );
  }
}

/// Copy button for code blocks
class _CopyButton extends StatefulWidget {
  final String code;

  const _CopyButton({required this.code});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: _copyToClipboard,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _copied ? Icons.check : Icons.copy,
              size: 14,
              color: _copied
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              _copied ? 'Copied!' : 'Copy',
              style: TextStyle(
                fontSize: 12,
                color: _copied
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
