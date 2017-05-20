json.data(@data) { |d| json.extract!(d, :user_id, :text) }
