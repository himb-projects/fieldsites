class Project < ApplicationRecord


  has_many :project_sites, inverse_of: :project
  has_many :sites, :through => :project_sites, :class_name => 'Site'

  accepts_nested_attributes_for :sites
  accepts_nested_attributes_for :project_sites, :allow_destroy => true

  belongs_to :user

  validates :project_name, :presence => true
  validates_uniqueness_of :project_name

  validates :user, :presence => true


  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["project_id", "project_name", "project_details", "permit", "start_date", "end_date", "site_id", "contact", "email"]

      all.each do |project|
        csv << [project.id, project.project_name, project.project_details, project.permit, project.start_date, project.end_date, project.user.id, project.user.name, project.user.email]
      end
    end
  end

end
