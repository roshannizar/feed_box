class PostModel {
  final String uid;
  final String title;
  final String fullname;
  final String description;
  final String date;
  final String documentId;
  final String video;
  final String image;
  final String postUrl;

  PostModel(
      {this.uid,
      this.fullname,
      this.title,
      this.description,
      this.date,
      this.documentId,
      this.video,
      this.image,
      this.postUrl});
}
