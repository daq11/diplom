class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :name
      t.integer :answer_type
      t.text :answer_array
      t.integer :position
      t.references :presentation, index: true

      t.timestamps
    end
  end
end
