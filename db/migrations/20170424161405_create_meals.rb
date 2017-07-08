Hanami::Model.migration do
  change do
    create_table :meals do
      primary_key :id

      foreign_key :provider_id, :providers, on_delete: :cascade, null: false
      column :photo_data, String, default: ''
      column :title, String, null: false, size: 10
      column :description, String, null: false, size: 150
      column :servings, Integer, null: false
      column :quantity, Integer, null: false
      column :pickup_location, String, null: false, size: 150

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
