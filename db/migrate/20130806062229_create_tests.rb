class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string 'name'
      t.text 'data'
      t.integer 'position'
      t.timestamps
    end
    add_index('tests', 'position')
  end
end
