Rails.application.config.session_store :active_record_store, { key: Rails.env.test? ? "_session_id_test" : "_session_id" }
