class AddImageToTest < ActiveRecord::Migration
  def change
    add_attachment :tests, :image
  end
end
