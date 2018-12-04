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
    ap vegetables.count
    ap vegetables.uniq.count
    nb_vegs = vegetables.uniq.count
    nb_parcels = parcels.count
    mini = nb_vegs < nb_parcels ? nb_vegs : nb_parcels

    ap "nb_vegs: #{nb_vegs}"
    ap "nb_parcels: #{nb_parcels}"
    ap "mini: #{mini}"

    ######################################### FIND BEST SOLUTION
    generate_solutions([], vegetables.uniq, mini)

    ordered_solutions = @solutions.sort_by { |sol| score(sol) }
    best_solution = ordered_solutions.last


    ################################## FILL PARCELS WITH VEGS
    distribution = parcels_distribution(vegetables.uniq.count, parcels.count)
    parcels_array = parcels.to_a

    i = 0
    best_solution.each_with_index do |vege, index|
      distribution[index].times do
        VegetablesParcel.create!(vegetable: vege, parcel: parcels_array[i])
        i += 1
      end
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


  private


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

  def parcels_distribution(nb_vegs, nb_parcels)
    mini = nb_vegs < nb_parcels ? nb_vegs : nb_parcels
    parcels_size = nb_parcels / mini
    nb_parcels_extra = nb_parcels % mini
    results = []

    mini.times do |i|
      results << parcels_size + (i < nb_parcels_extra ? 1 : 0)
    end
    results
  end
end
