class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  #belongs_to :user
  field :author
  field :text
end
