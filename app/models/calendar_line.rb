class CalendarLine < ActiveRecord::Base
  has_many :fragments, dependent: :destroy

  #scope :count_user_bonus, -> (user_id) {}
  #scope :count_user_bonus, :select => 'SELECT SUM(f.amount) FROM calendar_lines AS cl LEFT JOIN fragments as f on f.calendar_line_id = cl.id where cl.user_id = 44999'
  #scope :count_user_bonus, lambda{|n| {:joins => :fragments, :where} }

  #|n| {:joins => :bars, :group => "bars.foo_id", :having => ["count(bars.foo_id) = ?", n]}}

  # named_scope :with_n_bars, lambda {|n| {:joins => :bars, :group => "bars.foo_id", :having => ["count(bars.foo_id) = ?", n]}}
  # named_scope :with_gt_n_bars, lambda {|n| {:joins => :bars, :group => "bars.foo_id", :having => ["count(bars.foo_id) > ?", n]}}
  #

  #scope :count_user_bonus, joins(:fragments).select('SUM(amount)').where('user_id = 44999')

  #scope :count_user_bonus, lambda{sum(:amount)}
  #
  # def total_points
  #    fragments.sum(:amount)
  # end

  def total_amount
    fragments.sum(:amount)
  end
end
