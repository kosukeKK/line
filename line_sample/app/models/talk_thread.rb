class TalkThread
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_user_id
  field :second_user_id

  has_many :comment, dependent: :destroy
end
