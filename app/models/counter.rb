class Counter < ActiveRecord::Base

  has_one :next_counter, :class_name => 'Counter',
          :foreign_key => 'prev_id',
          :inverse_of => :prev_counter

  belongs_to :prev_counter, :class_name => 'Counter',
             :foreign_key => 'prev_id',
             :inverse_of => :next_counter

  validates :date, :warm, :cold, presence: true
	validate :validate_calculations

  scope :earlier_than, lambda { |date| where('date < ?',  date).order('date') }
  scope :data, lambda { where('id > 2') }
  scope :years, lambda { select('year').data.group('year').order('date desc') }
  scope :year, lambda { |year| data.where(year: year) }

  before_validation :recalc

  def find_prev_record
	  Counter.earlier_than(date).last
  end

  def recalc
    x = find_prev_record

    self.year = self.date.year

    unless x.nil?
      self.prev_id = x.id
      self.warm_consumption = self.warm - x.warm
      self.cold_consumption = self.cold - x.cold
			self.prev_warm_consumption = x.warm_consumption
			self.prev_cold_consumption = x.cold_consumption

      return true
    end

    false
  end

	def validate_calculations
    if prev_id.nil?
			errors.add(:date, I18n.t('activerecord.validation.message1'))
		else
			errors.add(:warm, I18n.t('activerecord.validation.message2')%{p1: self.prev_counter.warm}) if warm_consumption <= 0
      errors.add(:cold, I18n.t('activerecord.validation.message2')%{p1: self.prev_counter.cold}) if cold_consumption <= 0
		end
	end

	def self.show_index
		joins(:prev_counter)
			.select('counters.*
								, prev_counters_counters.warm_consumption as prev_warm_consumption
								, prev_counters_counters.cold_consumption as prev_cold_consumption')
			.order('counters.date desc')
	end

  def self.get_chart_array
    data.order(:date).pluck(:date, :warm_consumption, :cold_consumption).map{|d,w,c| [d.advance(:months => -1).to_time(:utc).to_i*1000, w, c]}
  end

  def show
  end

end
