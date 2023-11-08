import 'package:flutter_gpt_workspace/env.dart';

class GptCore {
  const GptCore({
    required this.openaiApiKey,
    required this.openaiOrganizationId,
  });

  const GptCore.fromEnv()
      : openaiApiKey = Env.openaiApiKey,
        openaiOrganizationId = Env.openaiOrganizationId;

  final String openaiApiKey;
  final String openaiOrganizationId;
}
