class TalkThread
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_user_id
  field :second_user_id
  has_many :comment

  scope :current_users_thread, ->(to_user_id, current_user_id)do
    where(:first_user.all  => [to_user_id, current_user_id],
          :second_user.all => [to_user_id, current_user_id]
    )
  end
end
