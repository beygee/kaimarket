import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AssetFull extends StatefulWidget {
  final Asset asset;
  final BoxFit fit;
  final double width;
  final double height;

  AssetFull(
      {@required this.asset, this.fit, this.width = 50.0, this.height = 50.0});

  @override
  AssetFullState createState() => AssetFullState();
}

class AssetFullState extends State<AssetFull> {
  ByteData _thumbData;
  Asset get asset => widget.asset;

  @override
  void initState() {
    super.initState();
    this._loadThumb();
  }

  @override
  void didUpdateWidget(AssetFull oldWidget) {
    if (oldWidget.asset.identifier != widget.asset.identifier) {
      this._loadThumb();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadThumb() async {
    setState(() {
      _thumbData = null;
    });

    ByteData thumbData = await asset.requestThumbnail(
      asset.originalWidth,
      asset.originalHeight,
      quality: 100,
    );

    if (this.mounted) {
      setState(() {
        _thumbData = thumbData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbData == null) {
      return Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: SpinKitDoubleBounce(color: Colors.red, size: 30),
        ),
      );
    }

    return Image.memory(
      _thumbData.buffer.asUint8List(),
      key: ValueKey(asset.identifier),
      fit: widget.fit ?? BoxFit.cover,
      gaplessPlayback: true,
      width: widget.width,
      height: widget.height,
    );
  }
}