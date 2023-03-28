Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://mysite-eaw8.onrender.com'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end

  allow do 
    origins 'http://localhost:8080', 'http://localhost:8081'
    resource '*', headers: :any, 
    methods: [:get, :post, :patch, :put, :delete, :options, :head],
    credentials: true
  end
end