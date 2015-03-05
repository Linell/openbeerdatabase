class AddCaloriesToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :calories, :integer
  end
end
