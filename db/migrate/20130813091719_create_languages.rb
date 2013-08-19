class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :code, :limit => 3

      t.timestamps
    end
    add_index :languages, :code
    Language.create :name => 'English', :code => ''
    Language.create :name => 'Polski', :code => 'pl'
  end
end
