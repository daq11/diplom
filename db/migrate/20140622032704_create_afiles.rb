class CreateAfiles < ActiveRecord::Migration
  def change
    create_table :afiles do |t|
      t.references :document, index: true
      t.binary :source
      t.string :path

      t.timestamps
    end
  end
end
