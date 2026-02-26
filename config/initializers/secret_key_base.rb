unless Rails.application.credentials.secret_key_base.present? || ENV["SECRET_KEY_BASE"].present?
  Rails.application.config.secret_key_base = "dev_only_22cdbb646d3a24efe041e6756b0e930d975d3fe8049828f08589e2db395a7d59420ccd10e18f9b9b4d61e111942ce3126fade459b00bb692087d36e94c1c4cb7"
end
