class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.text    :original_url, null: false
      t.string  :short_url
      t.string  :sanitized_url
      t.string  :custom_url
      t.integer :http_status

      t.timestamps
    end
  end
end
