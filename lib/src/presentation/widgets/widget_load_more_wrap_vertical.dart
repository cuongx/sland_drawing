import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../presentation.dart';

typedef Future<List> DataRequesterWrap(int offset);
typedef Future<List> InitRequesterWrap();
typedef Widget ItemBuilderWrap(List data, BuildContext context, int index);

class WidgetLoadMoreWrapVertical<T> extends StatefulWidget {
  WidgetLoadMoreWrapVertical.build(
      {Key? key,
      required this.itemBuilder,
      required this.dataRequester,
      required this.initRequester,
      this.padding,
      this.styleError,
      this.loadingColor,
      this.loadingColorBackground,
      this.widgetError}):
        super(key: key);

  final TextStyle? styleError;
  final ItemBuilderWrap itemBuilder;
  final DataRequesterWrap dataRequester;
  final InitRequesterWrap initRequester;
  final EdgeInsets? padding;
  final Color? loadingColor;
  final Color? loadingColorBackground;
  final Widget? widgetError;

  @override
  State createState() => new WidgetLoadMoreWrapVerticalState<T>();
}

class WidgetLoadMoreWrapVerticalState<T>
    extends State<WidgetLoadMoreWrapVertical> {
  bool isPerformingRequest = false;
  ScrollController _controller = new ScrollController();
  List<T>? _dataList;
  List<Widget>? children;

  @override
  void initState() {
    super.initState();
    this.onRefresh();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    children = _dataList
        ?.map((e) =>
            widget.itemBuilder(_dataList!, context, _dataList!.indexOf(e)))
        .toList();
    return this._dataList == null
        ? loadingProgress()
        : (this._dataList!.length > 0
            ? RefreshIndicator(
                color: widget.loadingColor ?? AppColors.primary,
                onRefresh: this.onRefresh,
                child: SingleChildScrollView(
                  controller: _controller,
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: Wrap(
                    children: children! +
                        [opacityLoadingProgress(isPerformingRequest)],
                  ),
                ),
              )
            : RefreshIndicator(
                color: widget.loadingColor ?? AppColors.primary,
                onRefresh: this.onRefresh,
                child: Stack(
                  children: [
                    ListView(),
                    Center(
                        child: widget.widgetError ??
                            Text(
                              "Không có dữ liệu",
                            )),
                  ],
                ),
              ));
  }

  Future<Null> onRefresh() async {
    if (mounted) this.setState(() => this._dataList = null);
    List initDataList = await widget.initRequester();
    if (mounted) this.setState(() => this._dataList = initDataList as List<T>);
    return;
  }

  _loadMore() async {
    if (mounted) {
      this.setState(() => isPerformingRequest = true);
      int currentSize = 0;
      if (_dataList != null) currentSize = _dataList!.length;

      List<T> newDataList = await widget.dataRequester(currentSize) as List<T>;
      if (newDataList.length == 0) {
        double edge = 50.0;
        double offsetFromBottom =
            _controller.position.maxScrollExtent - _controller.position.pixels;
        if (offsetFromBottom < edge) {
          _controller.animateTo(_controller.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      } else {
        _dataList!.addAll(newDataList);
      }
      if (mounted) this.setState(() => isPerformingRequest = false);
    }
  }

  Widget loadingProgress() {
    return Center(
      child: WidgetCircleProgress(
        color: widget.loadingColor,
        colorBackground: widget.loadingColorBackground,
      ),
    );
  }

  Widget opacityLoadingProgress(isPerformingRequest) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: WidgetCircleProgress(
            color: widget.loadingColor,
            colorBackground: widget.loadingColorBackground,
          ),
        ),
      ),
    );
  }
}
