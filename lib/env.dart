class Env {
  const Env._();

  static const openaiApiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const openaiOrganizationId = String.fromEnvironment('OPENAI_ORGANIZATION_ID');
}
