class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :document, index: true
      t.text :source
      t.integer :position

      t.timestamps
    end
  end
end
