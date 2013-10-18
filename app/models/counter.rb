class Counter < ActiveRecord::Base
  attr_reader :prev_date
  attr_reader :prev_warm
  attr_reader :prev_cold
  attr_reader :diff_warm
  attr_reader :diff_cold

  validates :date, :warm, :cold, presence: true

  scope :last_n_days, lambda { |days| where('updated < ?' , days) }

  def z
    puts 'sssss'
  end

  def self.prev_record_test(date)
    where("date < ?",  date).order("date").last
  end

  def show
    @x = Counter.where("date < ?",  date).order("date").last
    @prev_date = @x.date
    @prev_warm = @x.warm
    @prev_cold = @x.cold
    @diff_warm     = warm - @prev_warm
    @diff_cold     = cold - @prev_cold
  end

  #has_many :replies, :class_name => 'Micropost',
  #         :foreign_key => "in_reply_to",
  #         :inverse_of => :replied_post
  #belongs_to :replied_post, :class_name => 'Micropost',
  #           :foreign_key => "in_reply_to",
  #           :inverse_of => :replies

end
