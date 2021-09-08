class DefaultPhoto {
  final String imgId;
  final String imgPath;

  DefaultPhoto({required this.imgId, required this.imgPath});

  factory DefaultPhoto.fromJson(Map<String, dynamic> json) {
    return DefaultPhoto(
      imgId: json['img_id'],
      imgPath: json['img_path'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'img_id': this.imgId,
      'img_path': this.imgPath,
    };
  }
}
