class CreateSitesProjectsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :project_sites do |t|
      t.integer :project_id
      t.integer :site_id
    end
  end
end
