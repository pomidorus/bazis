task :cleanvpf do
  system "rake db:rollback VERSION=20120909230123"
  system "rake db:migrate VERSION=20120909230123"
end

task :printa do
  puts Person.all
end