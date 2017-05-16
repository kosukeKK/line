class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author
  field :text
end
