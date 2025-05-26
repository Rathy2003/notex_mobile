class NoteModel{
  String id;
  String title;
  String tags;
  String content;
  String uid;
  String? sharing;
  String? created_at;

  NoteModel({required this.id,required this.title,required this.content,required this.tags,required this.uid,this.sharing,this.created_at});

  Map<String,dynamic> toJson() => {"id":id,"title":title,"content":content,"tags":tags,"uid":uid,"created_at":created_at};

  factory NoteModel.fromJson(Map<String,dynamic> json){
    return NoteModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        tags: json['tags'],
        uid: json['uid'],
        sharing: json['sharing'],
        created_at: json['created_at']
    );
  }
}