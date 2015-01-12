source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

gem 'sqlite3'

# Вовсе не обязательно использовать thin вместо webrick, но мне нравится... 
gem 'thin'

# Haml вместо Erb - это, пожалуй, правильно. Хотя двумерный синтаксис
# требует большей аккуратности
gem 'haml-rails'

# Организация поиска
gem 'searchkick'

# Для работы с zip-файлами
gem 'rubyzip'

# Вместо пакет 'russian' лучше использовать 'ru_propisju'
gem 'ru_propisju'

# Для использования CAS-сервера теперь нужно сессию хранить в б/д
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

# Добавляем анимацию
gem 'animate-rails'

# Используются для получения информации по http-протоколу в формате json
gem 'httmultiparty'
gem 'multi_json'

# Без bootstrap и font-awesome сейчас не проживёшь...
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Удобно с этим пакетом формы создавать
gem 'bootstrap_form'

# Современный пакет-paginator
gem 'kaminari'

# Rails Locale Data Repository
gem 'rails-i18n'

# Без этого в production-режиме может не найтись javascript-runtime
gem 'execjs'
gem 'therubyracer', :platforms => :ruby

# Использование pry в rails-консоли
gem 'pry-rails'

# Таковы современные рекомендации
# (http://www.binarywebpark.com/setting-up-spring-rspec-for-testing-your-rails-4-application/)
group :development, :test do
  # Пакет, убирающий отладочную информацию о компиляции assets    
  gem 'quiet_assets'
  # Использование rspec-тестов
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
end
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# всё, что ниже, удалить в универе
#gem 'tzinfo-data'
#gem 'tzinfo'