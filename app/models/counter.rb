class Counter < ActiveRecord::Base
  attr_reader :prev_date
  attr_reader :prev_warm
  attr_reader :prev_cold
  attr_reader :diff_warm
  attr_reader :diff_cold

  validates :date, :warm, :cold, presence: true
	validate :validate_calculations

  scope :earlier_than, lambda { |date| where('date < ?',  date).order("date") }

  before_validation :recalc

  def find_prev_record
	Counter.earlier_than(date).last
  end

  def self.prev_record_test(date)
    where("date < ?",  date).order("date").last
  end

  def recalc
    x = find_prev_record

    unless x.nil?
      self.prev_id = x.id
      self.warm_consumption = self.warm - x.warm
      self.cold_consumption = self.cold - x.cold
    end    
  end

	def validate_calculations
    if prev_id.nil?
			errors.add(:date, "previos record not fount")
		else
			errors.add(:warm, "warm value error") if warm_consumption <= 0
			errors.add(:cold, "cold value error %{p1}"%{p1: self.prev_counter.cold} ) if cold_consumption <= 0
		end
	end

  def show
    @x = Counter.where("date < ?",  date).order("date").last
    @prev_date = @x.date
    @prev_warm = @x.warm
    @prev_cold = @x.cold
    @diff_warm     = warm - @prev_warm
    @diff_cold     = cold - @prev_cold
  end

  has_one :next_counter, :class_name => 'Counter',
           :foreign_key => "prev_id",
           :inverse_of => :prev_counter

  belongs_to :prev_counter, :class_name => 'Counter',
             :foreign_key => "prev_id",
             :inverse_of => :next_counter

end
