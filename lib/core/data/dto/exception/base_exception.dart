abstract class BaseException with Exception {
  String? rawTitleMessage;
  String? titleMessage;
  String? rawMessage;
  String? properMessage;
  Map<String, dynamic>? additionalData;

  BaseException({this.rawTitleMessage, this.titleMessage, this.rawMessage, this.properMessage, this.additionalData});
}