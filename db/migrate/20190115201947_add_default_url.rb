class AddDefaultUrl < ActiveRecord::Migration[5.2]
  def change
    change_column :cards, :url, :string, default: "default_pic.jpg"
  end
end
