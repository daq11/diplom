class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user, index: true
      t.string :comment
      t.integer :material_id

      t.timestamps
    end
  end
end
