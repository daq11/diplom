# НЕ СТАВЬТЕ ПРОБЕЛ МЕЖДУ АРГУМЕНТАМИ!!!
# rake load_document['presentation.zip','Test']

desc 'Загрузить новый документ'
task :load_document, [:filename, :comment] => :environment do |t, args|
  d = Document.new(comment: args[:comment], user: User.find_by_login('tutor'),
                   material_id: nil)
  d.create_sections_and_afiles(args[:filename])
  if d.save
    p = Presentation.new(document_id: d.id, user_id: d.user_id,
                         comment: d.comment, groups: [], 
                         last_open_slide: 0, auto_open: true)
    p.save(validate: false)
  end
end
