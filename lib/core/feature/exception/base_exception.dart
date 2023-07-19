abstract class BaseException with Exception {
  String? rawTitleMessage;
  String? titleMessage;
  String? rawMessage;
  String? message;
  Map<String, dynamic>? additionalData;

  BaseException({this.rawTitleMessage, this.titleMessage, this.rawMessage, this.message, this.additionalData});
}