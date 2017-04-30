class CreateLinks < ActiveRecord::Migration[5.0]

  def change
    create_table :links do |t|
      t.string  :short_url
      t.string  :sanitized_url
      t.string  :custom_url

      t.text    :original_url,  null: false

      t.integer :http_status,   null: false, default: 0

      t.timestamps
    end
  end

end