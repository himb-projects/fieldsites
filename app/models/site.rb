class Site < ApplicationRecord

  has_many :project_sites, inverse_of: :site
  has_many :projects, through: :project_sites

  validates :site_name, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates_uniqueness_of :site_name

  belongs_to :user
  validates :user, :presence => true

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["site_id", "site_name", "site_description", "latitude", "longitude", "color", "shared", "contact", "email"]

      all.each do |site|
        csv << [site.id, site.site_name, site.site_description, site.latitude, site.longitude, site.color, site.shared, site.user.name, site.user.email]
      end
    end
  end

  def self.search(search)
    if search
      where(['site_name LIKE ? OR site_description LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

end
