class AddImageToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :image, foreign_key: { to_table: :active_storage_attachments }
  end
end

