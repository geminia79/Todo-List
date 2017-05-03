class AddProductImageColumnsToProducts < ActiveRecord::Migration[5.1]
  def up
    add_attachment :products, :product_image
  end

  def down
    remove_attachment :products, :product_image
  end
end
