import 'package:flutter/material.dart';
import '../../../configs/configs.dart';
import '../../../utils/utils.dart';

class WidgetMarker extends StatefulWidget {
  WidgetMarker({Key? key, this.price}) : super(key: key);
  num? price;

  @override
  _WidgetMarkerState createState() => _WidgetMarkerState();
}

class _WidgetMarkerState extends State<WidgetMarker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: (widget.price! > 1000000000 || widget.price! < 1000000) ? 45 : 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(width: 1, color: Colors.green)),
            child: Text(AppUtils.formatMoneyShort(widget.price!),
                style: AppStyles.DEFAULT_SMALL
                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
          ),
          const Icon(
            Icons.mark_as_unread,
            size: 20,
          )
        ],
      ),
    );
  }
}
