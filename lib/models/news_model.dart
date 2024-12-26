class ResultModel {

  final String? title;
  final String? description;
  final String? content;
  final String? image_Url;


  ResultModel({
    required this.title,
    required this.description,
    required this.content,
    required this.image_Url
  });

  factory ResultModel.fromJson(Map<String, dynamic> json){
    return ResultModel(

      title: json["title"],
      description: json["description"],
      content: json["content"],
      image_Url: json["image_url"],
    );
  }

}