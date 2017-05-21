class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :talk_thread
  field :text

  validates :text, presence: true
  validates :text, length: { maximum: 200 }
end
