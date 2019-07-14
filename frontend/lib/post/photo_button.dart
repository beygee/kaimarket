import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:week_3/post/asset_full.dart';

class PhotoButton extends StatelessWidget {
  // 사진소스파일.
  final String url;
  // 삭제누를때 활성화함수
  final VoidCallback onPressed;

  PhotoButton({Key key, this.url, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: <Widget>[
        Image.network(
          'http://${hostUrl}${url}',
          fit: BoxFit.cover,
          width: screenAwareSize(50.0, context),
          height: screenAwareSize(50.0, context),
        ),
        // AssetFull(
        //   asset: asset,
        //   fit: BoxFit.cover,
        //   width: screenAwareSize(50.0, context),
        //   height: screenAwareSize(50.0, context),
        // ),
        Transform.translate(
          offset: Offset(
              screenAwareSize(20.0, context), screenAwareSize(-20.0, context)),
          child: IconButton(
            onPressed: onPressed,
            icon:
                Icon(Icons.remove_circle, size: screenAwareSize(20.0, context)),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
