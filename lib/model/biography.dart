class Biography {
  final String fullName;

  Biography(this.fullName);

  factory Biography.fromJson(final Map<String, dynamic> json) =>
      Biography(json['full-name']);

  Map<String, dynamic> toJson() => {"full-name": fullName};
}
