if Rails.env.development?
  %w[event group session workshop].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end