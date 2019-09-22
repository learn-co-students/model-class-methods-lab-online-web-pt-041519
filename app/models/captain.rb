class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).to_a
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct.to_a
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).to_a
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id)).to_a
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id)).to_a
  end

end
