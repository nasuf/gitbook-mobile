import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';

/// Avatar widget for displaying user profile picture or initials
class UserAvatar extends StatelessWidget {
  final User? user;
  final double size;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.user,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget avatar;

    if (user?.photoUrl != null && user!.photoUrl!.isNotEmpty) {
      avatar = CachedNetworkImage(
        imageUrl: user!.photoUrl!,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: size / 2,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => _buildInitialsAvatar(theme),
        errorWidget: (context, url, error) => _buildInitialsAvatar(theme),
      );
    } else {
      avatar = _buildInitialsAvatar(theme);
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildInitialsAvatar(ThemeData theme) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Text(
        user?.initials ?? '?',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
