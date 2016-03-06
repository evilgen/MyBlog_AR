class Posts < ActiveRecord::Migration
  def change
  		create_table :posts do |t|
  		t.text :autor
  		t.text :content
  		
  		t.timestamps null: false
  	end
  end
end
