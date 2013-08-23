class Container < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/assets/missing.png'

  attr_accessible :id, :name, :data, :position, :visible, :addons_attributes, :image, :delete_image

  attr_protected :image_file_name, :image_content_type, :image_file_size

  validates_presence_of :name, :position
  validates_uniqueness_of :name

  has_many :addons, :dependent => :destroy
  accepts_nested_attributes_for :addons, :reject_if => :all_blank, :allow_destroy => true

  attr_accessor :delete_image

  before_validation { image.clear if delete_image == '1' }

  acts_as_list

end
