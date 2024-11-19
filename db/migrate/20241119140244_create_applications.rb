class CreateApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :joboffer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
