Dir[File.join(Rails.root, 'lib', '*.rb')].each do |f|
  load f
end
