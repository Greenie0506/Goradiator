module FoursquareHelper

  def avatar(photo_url, num_items)
    css_class = if num_items <= 10
                  "normal"
                elsif num_items <= 20
                  "small"
                else
                  "tiny"
                end

    image_tag photo_url, :class => css_class
  end
end
