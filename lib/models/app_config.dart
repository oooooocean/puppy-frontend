/// maxPetCount : "5"
/// maxIntroduction : "200"
/// maxTopicTitle : "50"
/// maxTopicDescription : "200"
/// maxCommentDescription : "200"

class AppConfigModel {
  AppConfigModel({
      String? maxPetCount, 
      String? maxIntroduction, 
      String? maxTopicTitle, 
      String? maxTopicDescription,
      String? maxCommentDescription,}){
    _maxPetCount = maxPetCount;
    _maxIntroduction = maxIntroduction;
    _maxTopicTitle = maxTopicTitle;
    _maxTopicDescription = maxTopicDescription;
    _maxCommentDescription = maxCommentDescription;
}

  AppConfigModel.fromJson(dynamic json) {
    _maxPetCount = json['maxPetCount'];
    _maxIntroduction = json['maxIntroduction'];
    _maxTopicTitle = json['maxTopicTitle'];
    _maxTopicDescription = json['maxTopicDescription'];
    _maxCommentDescription = json['maxCommentDescription'];
  }
  String? _maxPetCount;
  String? _maxIntroduction;
  String? _maxTopicTitle;
  String? _maxTopicDescription;
  String? _maxCommentDescription;

  String? get maxPetCount => _maxPetCount;
  String? get maxIntroduction => _maxIntroduction;
  String? get maxTopicTitle => _maxTopicTitle;
  String? get maxTopicDescription => _maxTopicDescription;
  String? get maxCommentDescription => _maxCommentDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxPetCount'] = _maxPetCount;
    map['maxIntroduction'] = _maxIntroduction;
    map['maxTopicTitle'] = _maxTopicTitle;
    map['maxTopicDescription'] = _maxTopicDescription;
    map['maxCommentDescription'] = _maxCommentDescription;
    return map;
  }

}