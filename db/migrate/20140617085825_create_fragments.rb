class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.belongs_to :calendar_line
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
