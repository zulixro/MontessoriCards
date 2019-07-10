class UpdateCategoryIdToPresent < ActiveRecord::Migration[5.2]
  def change
    change_column :cards, :category_id, :integer, null: false
  end
end
