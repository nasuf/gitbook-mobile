import 'package:flutter/material.dart';

/// GitBook Hint block styles
enum HintStyle {
  info,
  success,
  warning,
  danger,
}

/// GitBook Hint block widget
class GitBookHint extends StatelessWidget {
  final HintStyle style;
  final String? title;
  final String content;
  final Widget? child;

  const GitBookHint({
    super.key,
    this.style = HintStyle.info,
    this.title,
    required this.content,
    this.child,
  });

  factory GitBookHint.info({
    Key? key,
    String? title,
    required String content,
    Widget? child,
  }) {
    return GitBookHint(
      key: key,
      style: HintStyle.info,
      title: title,
      content: content,
      child: child,
    );
  }

  factory GitBookHint.success({
    Key? key,
    String? title,
    required String content,
    Widget? child,
  }) {
    return GitBookHint(
      key: key,
      style: HintStyle.success,
      title: title,
      content: content,
      child: child,
    );
  }

  factory GitBookHint.warning({
    Key? key,
    String? title,
    required String content,
    Widget? child,
  }) {
    return GitBookHint(
      key: key,
      style: HintStyle.warning,
      title: title,
      content: content,
      child: child,
    );
  }

  factory GitBookHint.danger({
    Key? key,
    String? title,
    required String content,
    Widget? child,
  }) {
    return GitBookHint(
      key: key,
      style: HintStyle.danger,
      title: title,
      content: content,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors(theme);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: colors.borderColor,
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              colors.icon,
              color: colors.iconColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (child != null)
                    child!
                  else
                    Text(
                      content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.textColor,
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _HintColors _getColors(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    switch (style) {
      case HintStyle.info:
        return _HintColors(
          backgroundColor: isDark
              ? Colors.blue.shade900.withValues(alpha: 0.3)
              : Colors.blue.shade50,
          borderColor: Colors.blue,
          iconColor: Colors.blue,
          titleColor: isDark ? Colors.blue.shade200 : Colors.blue.shade800,
          textColor: isDark ? Colors.blue.shade100 : Colors.blue.shade900,
          icon: Icons.info_outline,
        );
      case HintStyle.success:
        return _HintColors(
          backgroundColor: isDark
              ? Colors.green.shade900.withValues(alpha: 0.3)
              : Colors.green.shade50,
          borderColor: Colors.green,
          iconColor: Colors.green,
          titleColor: isDark ? Colors.green.shade200 : Colors.green.shade800,
          textColor: isDark ? Colors.green.shade100 : Colors.green.shade900,
          icon: Icons.check_circle_outline,
        );
      case HintStyle.warning:
        return _HintColors(
          backgroundColor: isDark
              ? Colors.orange.shade900.withValues(alpha: 0.3)
              : Colors.orange.shade50,
          borderColor: Colors.orange,
          iconColor: Colors.orange,
          titleColor: isDark ? Colors.orange.shade200 : Colors.orange.shade800,
          textColor: isDark ? Colors.orange.shade100 : Colors.orange.shade900,
          icon: Icons.warning_amber_outlined,
        );
      case HintStyle.danger:
        return _HintColors(
          backgroundColor: isDark
              ? Colors.red.shade900.withValues(alpha: 0.3)
              : Colors.red.shade50,
          borderColor: Colors.red,
          iconColor: Colors.red,
          titleColor: isDark ? Colors.red.shade200 : Colors.red.shade800,
          textColor: isDark ? Colors.red.shade100 : Colors.red.shade900,
          icon: Icons.error_outline,
        );
    }
  }
}

class _HintColors {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color titleColor;
  final Color textColor;
  final IconData icon;

  const _HintColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.titleColor,
    required this.textColor,
    required this.icon,
  });
}

/// GitBook Tabs widget
class GitBookTabs extends StatefulWidget {
  final List<GitBookTab> tabs;

  const GitBookTabs({
    super.key,
    required this.tabs,
  });

  @override
  State<GitBookTabs> createState() => _GitBookTabsState();
}

class _GitBookTabsState extends State<GitBookTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: widget.tabs.map((tab) => Tab(text: tab.title)).toList(),
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: theme.colorScheme.outlineVariant,
          ),
          SizedBox(
            height: 200, // Default height, can be made dynamic
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs.map((tab) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: tab.content,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Single tab for GitBookTabs
class GitBookTab {
  final String title;
  final Widget content;

  const GitBookTab({
    required this.title,
    required this.content,
  });
}

/// GitBook Expandable/Collapsible section
class GitBookExpandable extends StatefulWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  const GitBookExpandable({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  State<GitBookExpandable> createState() => _GitBookExpandableState();
}

class _GitBookExpandableState extends State<GitBookExpandable> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(7),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: widget.content,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

/// GitBook Embed widget for external content
class GitBookEmbed extends StatelessWidget {
  final String url;
  final String? title;
  final double aspectRatio;

  const GitBookEmbed({
    super.key,
    required this.url,
    this.title,
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // For now, show a placeholder for embeds
    // Full embed support would require webview
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              title ?? 'Embedded Content',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                // Open URL in browser
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}

/// GitBook File download block
class GitBookFile extends StatelessWidget {
  final String filename;
  final String? url;
  final String? size;

  const GitBookFile({
    super.key,
    required this.filename,
    this.url,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getFileIcon(filename),
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(
          filename,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: size != null ? Text(size!) : null,
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: url != null
              ? () {
                  // Download file
                }
              : null,
        ),
      ),
    );
  }

  IconData _getFileIcon(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'zip':
      case 'rar':
      case '7z':
        return Icons.folder_zip;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'svg':
        return Icons.image;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Icons.video_file;
      case 'mp3':
      case 'wav':
      case 'ogg':
        return Icons.audio_file;
      default:
        return Icons.insert_drive_file;
    }
  }
}
