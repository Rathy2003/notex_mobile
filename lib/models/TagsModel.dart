class TagsModel{
  String id;
  String name;
  String? created_at;
  String uid;

  TagsModel({required this.id,required this.name,this.created_at,required this.uid});

  Map<String,dynamic> toJson() => {"id":id,"name":name,"created_at":created_at,"uid":uid};

  factory TagsModel.fromJson(Map<String,dynamic> json){
    return TagsModel(id: json['id'], name:  json['name'], created_at: json['created_at'], uid:  json['uid']);
  }
}