class Potager < ApplicationRecord
  belongs_to :user, optional: true
  has_many :parcels
  has_many :choices
  has_many :vegetables, through: :choices

  validates :length, presence: true, if: :active_or_dimension?
  validates :width, presence: true, if: :active_or_dimension?
  # validates :freezing, inclusion: { in: [true, false] }
  validates :orientation, presence: true, if: :active_or_orientation?
  validates :start_month, presence: true, if: :active_or_start_month?

  accepts_nested_attributes_for :choices

  def create_vegetables_parcels
    @solutions = []
    generate_solutions([], vegetables, parcels.count)
    ordered_solutions = @solutions.sort_by { |sol| score(sol) }

    # on a N parcels (number_of_parcels) (chaque parcel a un index (order_from_south)
    # on va selectionner la premiere combinaison
    # pour obtenir les vegetable_id

    # on va creer N vegetables_parcels
    # en leur attribuant un parcel_id (grace a order_from_south)
    # en leur attribuant un vegetable_id (grace a l'index de la combinaison)

    best_solution = ordered_solutions.last

    parcels.each_with_index do |parcel, order_from_south|
      parcel.vegetables_parcel.destroy if parcel.vegetables_parcel
      vegetable = best_solution[order_from_south]
      # ap "distance au soleil : #{order_from_south}"
      # ap "name: #{v.name}, height: #{v.height}"

      VegetablesParcel.create!(vegetable: vegetable, parcel: parcel)
    end
  end




  # # fake method to
  # def score_friends(vegetables)
  #   rand(10)
  # end

  # # adds 1000 points to all combinations starting with "poireau" as a first vegetable, -1000 to the others
  # def custom(vegetables)
  #   vegetables.first[:name] == "poireau" ? 1000 : -1000
  # end

  private

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

    # on save nos vegetables_parcels

  end

  # LIST OF COMBINATIONS
  # gives all possible combination of n (rows) vegetables (ex: "tomato cabbage bean")
  def generate_solutions(arr, vegetables, rows)
    (vegetables - arr).each do |legume|
      solution = arr.dup
      solution << legume
      if solution.size < rows
        generate_solutions(solution, vegetables, rows)
      else
        @solutions << solution
      end
    end
  end

  # SCORING OF COMBINATIONS
  # scores all the combinations using the different scoring criterias
  def score(vegetables)
    score_size(vegetables)
  end

  # adds 100 points to combinations where all vegetables are sorted, and minus 100 to the ones who aren't
  def score_size(vegetables)
    (vegetables.sort_by { |v| v.height } == vegetables) ? 100 : -100
  end

  # # fake method to
  # def score_friends(legumes)
  #   rand(10)
  # end

  # # adds 1000 points to all combinations starting with "poireau" as a first vegetable, -1000 to the others
  # def custom(legumes)
  #   legumes.first[:name] == "poireau" ? 1000 : -1000
  # end

  def active?
    status == 'active'
  end

  def active_or_dimension?
    status.include?('def_dimension') || active?
  end

  def active_or_orientation?
    status.include?('def_orientation') || active?
  end

  def active_or_start_month?
    status.include?('def_start_month') || active?
  end

end
