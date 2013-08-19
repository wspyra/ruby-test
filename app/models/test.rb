class Test < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/assets/missing.png'

  attr_accessible :id, :name, :data, :position, :visible, :test_addons_attributes, :image, :delete_image

  attr_protected :image_file_name, :image_content_type, :image_file_size

  validates_presence_of :name, :position, :on => :create
  validates_uniqueness_of :name

  has_many :test_addons, :dependent => :destroy
  accepts_nested_attributes_for :test_addons, :reject_if => :all_blank, :allow_destroy => true

  acts_as_list

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end

  def delete_image
    !!@delete_image
  end

  alias_method :delete_image?, :delete_image

end
