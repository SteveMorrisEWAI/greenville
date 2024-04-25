class PostGPTResult {
  final String client_uuid;
  final String brand_id;
  final String prompt;
  final String output_flag;
  final bool generate;

  const PostGPTResult({required this.client_uuid, required this.brand_id, required this.prompt, required this.output_flag, required this.generate});

  static PostGPTResult fromJson(json) => PostGPTResult(
        client_uuid: json('client_uuid'),
        brand_id: json('brand_id'),
        prompt: json('prompt'),
        output_flag: json('output_flag'),
        generate: json('generate')
      );

  Map<String, dynamic> toJson() {
    return {
      'client_uuid': client_uuid,
      'brand_id': brand_id,
      'prompt': prompt,
      'output_flag': output_flag,
      'generate': generate
    };
  }
}
