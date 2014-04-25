# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_session_store, {
  key: '_dummy_session',
  secure: Rails.env.production?,
  httponly: true,
  cookie_only: false,
  redis: {
    db: 2,
    expire_after: 3600,
    key_prefix: 'dummy:session:',
  }
}
