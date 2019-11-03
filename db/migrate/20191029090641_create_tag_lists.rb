class CreateTagLists < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_lists do |t|
	t.belongs_to :gosssip, index: true
	t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
