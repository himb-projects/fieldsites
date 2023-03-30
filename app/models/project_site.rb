class ProjectSite < ApplicationRecord
  belongs_to :project
  belongs_to :site

  accepts_nested_attributes_for :site, :reject_if => :all_blank
end
