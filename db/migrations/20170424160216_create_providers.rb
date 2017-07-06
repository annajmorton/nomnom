Hanami::Model.migration do
  change do
    create_table :providers do
      primary_key :id

      column :name, String, null: true
      column :email, String, null: false, uniquie: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
