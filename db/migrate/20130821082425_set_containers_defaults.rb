class SetContainersDefaults < ActiveRecord::Migration
  def change
    change_column_default :containers, :position, 0
    change_column_default :containers, :status_upload, JOB_STATUSES[:new]
    change_column_default :containers, :status_mail, JOB_STATUSES[:new]
  end
end
