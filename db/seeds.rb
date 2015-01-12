# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(login: 'tutor', fio: 'Иван Петрович Сидоров', roles: 'admin tutor')
User.create(login: 'stud1', fio: 'Михаил Степанович Гусев', groups: ['141131'])
User.create(login: 'stud2', fio: 'Елена Николаевна Мишина', groups: ['141132'])

%w(141131 141132).each do |group|
  Group.create(name: group)
end
