enum ResizeHandlerPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  bool get isLeft => this == topLeft || this == bottomLeft;
  bool get isTop => this == topLeft || this == topRight;
  bool get affectsWidth => true;
  bool get affectsHeight => true;
}
