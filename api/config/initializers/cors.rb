Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' ## <= 修正。* でフルオープンにする。

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
