class CalendarLine < ActiveRecord::Base
  has_many :fragments, dependent: :destroy
end
