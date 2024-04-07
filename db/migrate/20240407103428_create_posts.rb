class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.string:title, null:false
      t.integer:phase, null:false
      t.string:body, null:false
      t.string:way, null:false
      t.string:investment, null:false
      t.timestamps
    end
  end
end
