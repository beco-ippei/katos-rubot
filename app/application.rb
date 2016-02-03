dir = File.expand_path('../actions', __FILE__)
Dir[File.join dir, '**', '*.rb'].each do |file|
  require file
end
