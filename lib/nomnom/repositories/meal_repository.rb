require_relative '../image_uploader'
class MealRepository < Hanami::Repository
	prepend ImageUploader.repository(:photo)
end
