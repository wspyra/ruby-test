class CreateTestAddons < ActiveRecord::Migration
  def change
    create_table :test_addons do |t|
      t.references 'test'
      t.string 'name'
      t.string 'value'
      t.timestamps
    end
    add_index('test_addons', 'test_id')
  end
end
