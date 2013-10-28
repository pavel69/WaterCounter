class Counter < ActiveRecord::Base

  has_one :next_counter, :class_name => 'Counter',
          :foreign_key => "prev_id",
          :inverse_of => :prev_counter

  belongs_to :prev_counter, :class_name => 'Counter',
             :foreign_key => "prev_id",
             :inverse_of => :next_counter

  validates :date, :warm, :cold, presence: true
	validate :validate_calculations

  scope :earlier_than, lambda { |date| where('date < ?',  date).order('date') }

  before_validation :recalc

  def find_prev_record
	  Counter.earlier_than(date).last
  end

  def recalc
    x = find_prev_record

    unless x.nil?
      self.prev_id = x.id
      self.warm_consumption = self.warm - x.warm
      self.cold_consumption = self.cold - x.cold
    end    
  end

  def diff_consumption
    if self.prev_counter.nil?
      {
          warm: nil,
          cold: nil
      }
    else
      {
          warm: (self.warm_consumption||0) - (self.prev_counter.warm_consumption||0),
          cold: (self.cold_consumption||0) - (self.prev_counter.cold_consumption||0)
      }
    end

  end

	def validate_calculations
    if prev_id.nil?
			errors.add(:date, I18n.t('activerecord.validation.message1'))
		else
			errors.add(:warm, I18n.t('activerecord.validation.message2')%{p1: self.prev_counter.warm}) if warm_consumption <= 0
      errors.add(:cold, I18n.t('activerecord.validation.message2')%{p1: self.prev_counter.cold}) if cold_consumption <= 0
		end
	end

  def show
  end

end
