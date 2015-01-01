class Project < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :users, :through => :works
  belongs_to :owner, class_name: "User"

  validates :name, length: { minimum: 5 }
  validates :company, presence: true
  validates :default_rate, numericality: { only_integer: true, greater_than: 50, less_than: 10000 }
  validates :slug, uniqueness: true, length: { minimum: 3 }

  scope :lowdefaultrate, -> { where("default_rate < 100") }

  def to_s
    "#{name} (#{company})"
  end

  def self.export_csv(projects)
    CSV.generate() do |csv|
      csv << ['Name', 'Company', 'Default rate', 'Created at', 'Owner', 'Most recent work item']
      projects.each do |project|
        csv << [
          project.name,
          project.company,
          project.default_rate,
          project.created_at,
          project.user,
          project.works.order('created_at DESC').first
        ]
      end
    end
  end

end
