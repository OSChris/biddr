class Auction < ActiveRecord::Base

  belongs_to :user

  validates :title, :details, :end_date, presence: true
  validates :reserve, numericality: {greater_than: 0}

  has_many :bids, dependent: :destroy

  after_save :reserve_met?

  # State Machine 

  state_machine :state, initial: :published do 
    event :meeting_reserve do 
      transition published: :reserve_met
    end
    event :winning do 
      transition reserve_met: :won
    end
    event :cancel do 
      transition published: :cancelled
    end
    event :not_meeting_reserve do 
      transition published: :reserve_not_met
    end
  end

  # End State Machine

  def set_current_price
    self.current_price = self.bids.maximum(:amount) + 1
    self.save
  end

  private

  def reserve_met?
    if self.current_price > self.reserve
      self.meeting_reserve
    end
  end
end
