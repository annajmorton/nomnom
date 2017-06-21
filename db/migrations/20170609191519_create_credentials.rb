Hanami::Model.migration do
  change do
    create_table :credentials do
      primary_key :id

      foreign_key :provider_id, :providers, on_delete: :cascade, null: false

      column :provider, String, null: false
      column :crypted_password, String
      column :external_id, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
