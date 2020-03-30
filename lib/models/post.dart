class Post {
  final String uid;
  final String title;
  final String fullname;
  final String description;
  final String date;
  final String documentId;
  final String comments;
  final String share;
  final String postUrl;

  Post(
      {this.uid,
      this.fullname,
      this.title,
      this.description,
      this.date,
      this.documentId,
      this.comments,
      this.share,
      this.postUrl});
}
