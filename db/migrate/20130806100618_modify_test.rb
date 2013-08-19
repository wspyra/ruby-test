class ModifyTest < ActiveRecord::Migration
  def up
    add_column('tests', 'visible', :boolean, :default => true)
    add_index('tests', 'visible')
  end

  def down
    remove_column('tests', 'visible')
  end
end
