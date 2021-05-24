import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myPhotos.dart';

class CircularProfileImage extends StatelessWidget {
  final String imageUrl;

  const CircularProfileImage({
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    final double _radius = 24.0;
    return CircleAvatar(
      radius: _radius,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: _radius - 2,
        child: CircleAvatar(
          radius: _radius - 6,
          backgroundColor: Theme.of(context).iconTheme.color,
          backgroundImage:
              (imageUrl == null || imageUrl == '' || imageUrl.isEmpty)
                  ? AssetImage(appLogo)
                  : NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
