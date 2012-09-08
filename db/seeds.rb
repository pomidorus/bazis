# encoding: UTF-8

User.delete_all

User.create!({:username => "a.dzekanyk", :name => "Андрей", :surname => "Дзеканюк", :photo => "dz.jpg", :role_id => 1,
              :telephone => "093 856 96 11", :email => "a.dzekanyk@gmail.com", :password => "testtest", :password_confirmation => "testtest" })

User.create!({:username => "i.shubin", :name => "Иван", :surname => "Шубин", :photo => "sh.jpg", :role_id => 1,
              :telephone => "093 856 96 11", :email => "i.shubin@gmail.com", :password => "testtest", :password_confirmation => "testtest" })

User.create!({:username => "o.sukhova", :name => "Оксана", :surname => "Сухова", :photo => "suh.jpg", :role_id => 3,
              :telephone => "093 856 96 11", :email => "o.sukhova@gmail.com", :password => "testtest", :password_confirmation => "testtest" })

User.create!({:username => "e.reznikova", :name => "Екатерина", :surname => "Резникова", :photo => "rez.jpg",
              :role_id => 3, :telephone => "093 856 96 11", :email => "e.reznikova@gmail.com", :password => "testtest", :password_confirmation => "testtest" })


Admin.delete_all
Admin.create!({:username => "a.seleznov", :name => "Андрей", :surname => "Селезнев", :email => "andrewaka39@gmail.com", :password => "testtest", :password_confirmation => "testtest" })

Role.delete_all
Role.create!({:name => "Секретарь", :desc => "Краткое описание роли секретаря. <p>С тегами</p>"})
Role.create!({:name => "Администратор", :desc => "Краткое описание роли администратора. <p>С тегами</p>"})
Role.create!({:name => "Финансист", :desc => "Краткое описание роли финансиста. <p>С тегами</p>"})
Role.create!({:name => "Арендатор", :desc => "Краткое описание роли арендатора. <p>С тегами</p>"})
Role.create!({:name => "Заместитель мера", :desc => "Краткое описание роли заместителя мера. <p>С тегами</p>"})
Role.create!({:name => "Землеустроитель", :desc => "Краткое описание роли землеустроителя. <p>С тегами</p>"})
Role.create!({:name => "Юрист", :desc => "Краткое описание роли юриста. <p>С тегами</p>"})
Role.create!({:name => "Сотрудник налоговой", :desc => "Краткое описание роли сотрудника налоговой инспекции. <p>С тегами</p>"})
