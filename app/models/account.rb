class Account < ApplicationRecord

	def normalize_slug
		self.slug = self.slug.parameterize	
	end
end
