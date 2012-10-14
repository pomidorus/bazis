# encoding: UTF-8

require "./lib/dataparse/person.rb"

#Admin.delete_all
#Admin.create!({:username => "a.seleznov", :name => "Андрей", :surname => "Селезнев", :email => "andrewaka39@gmail.com", :password => "testtest", :password_confirmation => "testtest" })
#
#Role.delete_all
#Role.create!({:name => "Секретарь", :desc => "Краткое описание роли секретаря. <p>С тегами</p>"})
#Role.create!({:name => "Администратор", :desc => "Краткое описание роли администратора. <p>С тегами</p>"})
#Role.create!({:name => "Финансист", :desc => "Краткое описание роли финансиста. <p>С тегами</p>"})
#Role.create!({:name => "Арендатор", :desc => "Краткое описание роли арендатора. <p>С тегами</p>"})
#Role.create!({:name => "Заместитель мера", :desc => "Краткое описание роли заместителя мера. <p>С тегами</p>"})
#Role.create!({:name => "Землеустроитель", :desc => "Краткое описание роли землеустроителя. <p>С тегами</p>"})
#Role.create!({:name => "Юрист", :desc => "Краткое описание роли юриста. <p>С тегами</p>"})
#Role.create!({:name => "Сотрудник налоговой", :desc => "Краткое описание роли сотрудника налоговой инспекции. <p>С тегами</p>"})
#
#
#secretar_id = Role.find_by_name("Секретарь").id
#finansist_id = Role.find_by_name("Финансист").id
#
#
#User.delete_all
#User.create!({:username => "a.dzekanyk", :name => "Андрей", :surname => "Дзеканюк", :photo => "dz.jpg", :role_id => secretar_id,
#              :telephone => "093 856 96 11", :email => "a.dzekanyk@gmail.com", :password => "testtest", :password_confirmation => "testtest" })
#User.create!({:username => "i.shubin", :name => "Иван", :surname => "Шубин", :photo => "sh.jpg", :role_id => secretar_id,
#              :telephone => "093 856 96 11", :email => "i.shubin@gmail.com", :password => "testtest", :password_confirmation => "testtest" })
#User.create!({:username => "o.sukhova", :name => "Оксана", :surname => "Сухова", :photo => "suh.jpg", :role_id => finansist_id,
#              :telephone => "093 856 96 11", :email => "o.sukhova@gmail.com", :password => "testtest", :password_confirmation => "testtest" })
#User.create!({:username => "e.reznikova", :name => "Екатерина", :surname => "Резникова", :photo => "rez.jpg",
#              :role_id => finansist_id, :telephone => "093 856 96 11", :email => "e.reznikova@gmail.com", :password => "testtest", :password_confirmation => "testtest" })


#VipiskaFile.delete_all
#VipiskaFile.create!({:file_name => "OFU-1009", :upload_at => '2012-10-10', :download_count => 2})
#VipiskaFile.create!({:file_name => "OFU-0809", :upload_at => '2012-10-08', :download_count => 3})
#VipiskaFile.create!({:file_name => "OFU-0709", :upload_at => '2012-10-07', :download_count => 5})
#VipiskaFile.create!({:file_name => "OFU-0609", :upload_at => '2012-10-06', :download_count => 7})
#VipiskaFile.create!({:file_name => "OFU-0509", :upload_at => '2012-10-05', :download_count => 1})

#-----------------------------------------------------------------------


Person.delete_all
parsePersonFile(PERSON_FILE)
