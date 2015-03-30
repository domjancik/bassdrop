module WelcomeHelper
  WELCOME_VARIANTS = [
      'Welcome',
      'Hello',
      'Hi',
      'Hey',
      '\'Sup',
      'Howdy',
      'How are ya',
      'Party?',
      'Tea?',
      'I like kittens',
  ] # TODO move to DB

  def welcome_text
    variant = Random.rand WELCOME_VARIANTS.size
    WELCOME_VARIANTS[variant]
  end
end