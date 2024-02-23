Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.development?
    allow do
      origins "http://localhost:3001"
      resource '*', credentials: true, headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
end
