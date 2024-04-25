class GPTResultModel {
  final String my_html_page;
  final String share_html_page;
  final String static_html_page;

  const GPTResultModel({required this.my_html_page, required this.share_html_page, required this.static_html_page});

  static GPTResultModel fromJson(json) => GPTResultModel(
        my_html_page: json['my_html_page'],
        share_html_page: json['share_html_page'],
        static_html_page: json['static_html_page'],
      );

  Map<String, dynamic> toJson() {
    return {
      'my_html_page': my_html_page,
      'share_html_page': share_html_page,
      'static_html_page': static_html_page,
    };
  }
}
