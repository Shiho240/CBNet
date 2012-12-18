class Game < ActiveRecord::Base
  attr_accessible :game_desc, :gamename, :genre, :rating, :review
  
  validates :gamename, :presence => true
  validates :genre,    :presence => true
  validates :game_desc, :presence => true
  validates :rating,    :presence => true, :numericality => {:greater_than => 0,  :less_than_or_equal_to => 10, :message => "Games must be rated between 0 and 5."}
  validates :review,    :presence => true
  validates :user_id, :presence => true
  
  belongs_to :user
  default_scope :order => 'games.created_at DESC'
end
