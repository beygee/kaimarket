import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PhotoButton extends StatelessWidget {
  // 사진소스파일.
  final Asset asset;
  // 삭제누를때 활성화함수
  final VoidCallback onPressed;

  PhotoButton({this.asset, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          AssetThumb(
            asset: asset,
            width: screenAwareSize(55.0, context).toInt(),
            height: screenAwareSize(55.0, context).toInt(),
          ),
          Container(
              width: screenAwareSize(55.0, context),
              height: screenAwareSize(55.0, context),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 38,
                      left: 40,
                    ),
                    child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.remove_circle, size: 22.0),
                      color: Colors.black,
                    ),
                  ))),
        ],
      ),
    );
  }
}
