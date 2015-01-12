class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :document, index: true
      t.references :user, index: true
      t.string :comment
      t.text :groups
      t.integer :last_open_slide
      t.boolean :auto_open

      t.timestamps
    end
  end
end
