require "administrate/base_dashboard"

class PhotoPathDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    graduation_album: Field::BelongsTo,
    id: Field::Number,
    path: Field::String,
    image_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    s3_file_name: Field::String,
    happy_score: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    graduation_album
    id
    path
    image_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    graduation_album
    id
    path
    image_id
    created_at
    updated_at
    s3_file_name
    happy_score
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    graduation_album
    path
    image_id
    s3_file_name
    happy_score
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how photo paths are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(photo_path)
  #   "PhotoPath ##{photo_path.id}"
  # end
end
