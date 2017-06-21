require_relative '../image_uploader'
class Meal < Hanami::Entity
	include ImageUploader[:photo]
end
