#upload setup
# setup test photo

class TestUploadFile	

	def self.test
		header = Hanami.root.to_s
		test_image1 = Pathname(header +'/spec/test_upload.jpeg')
		File.open(test_image1)
	end

end 



