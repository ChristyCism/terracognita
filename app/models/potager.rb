class Potager < ApplicationRecord
  belongs_to :user
  has_many :parcels
  has_many :choices
  has_many :vegetables, through: :choices
  validates :length, presence: true
  validates :width, presence: true
  validates :freezing, inclusion: { in: [true, false] }
  validates :orientation, presence: true
  validates :start_month, presence: true

  accepts_nested_attributes_for :choices

  after_create :create_parcels

  def create_parcels
    number_of_parcels = ['a', 'c'].include?(orientation) ? length : width
    parcel_size = ['a', 'c'].include?(orientation) ? width : length
    number_of_parcels.times do |i|
      Parcel.create(
        order_from_south: i + 1,
        potager: self,
        size: parcel_size
      )
    end
  end

  def create_vegetables_parcels
    SOLUTIONS = combinaison([], choices, number_of_parcels)
    ordered_solutions = SOLUTIONS.sort_by { |sol| score(sol) }

    # on a N parcels (number_of_parcels) (chaque parcel a un index (order_from_south)
    # on va selectionner la premiere combinaison
    # pour obtenir les vegetable_id

    # on va creer N vegetables_parcels
    # en leur attribuant un parcel_id (grace a order_from_south)
    # en leur attribuant un vegetable_id (grace a l'index de la combinaison)

    parcels.each do |order_from_south|
      vegetables_parcel = Vegetables_Parcel.new
      vegetables_parcel.parcel_id = parcel[order_from_south].id
      vegetables_parcel.vegetable_id = ordered_solutions[0][order_from_south].vegetable_id
      # on save nos vegetables_parcels
      vegetables_parcel.save
    end
  end

  # LIST OF COMBINATIONS
  # gives all possible combination of n (rows) vegetables (ex: "tomato cabbage bean")
  def combinaison(arr, legumes, rows)
    (legumes - arr).each do |legume|
      solution = arr.dup
      solution << legume
      if solution.size < rows
        combinaison(solution, legumes, rows)
      else
        SOLUTIONS << solution
      end
    end
  end

  # SCORING OF COMBINATIONS
  # scores all the combinations using the different scoring criterias
  def score(legumes)
    score_size(legumes)
  end

  # adds 100 points to combinations where all vegetables are sorted, and minus 100 to the ones who aren't
  def score_size(legumes)
    (legumes.sort_by { |l| l[:height] } == legumes) ? 100 : -100
  end

  # # fake method to
  # def score_friends(legumes)
  #   rand(10)
  # end

  # # adds 1000 points to all combinations starting with "poireau" as a first vegetable, -1000 to the others
  # def custom(legumes)
  #   legumes.first[:name] == "poireau" ? 1000 : -1000
  # end

end
