class CalendarLine < ActiveRecord::Base
  has_many :fragments, dependent: :destroy

  def total_amount
    fragments.sum(:amount)
  end
end
