class AddImageToTest < ActiveRecord::Migration
  def change
    add_attachment :containers, :image
  end
end
