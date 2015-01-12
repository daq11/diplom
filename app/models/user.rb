class User < ActiveRecord::Base
  has_many  :documents
  has_many  :presentations
  serialize :groups, Array
end
