class CalendarLine < ActiveRecord::Base
  has_many :fragments, dependent: :destroy

  scope :total_bonus_amount, ->(user_id) {
    joins('LEFT JOIN fragments ON fragments.calendar_line_id = calendar_lines.id')
    .where(calendar_lines: { user_id: user_id })
    .sum('fragments.amount')
  }

end
