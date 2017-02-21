module ApplicationHelper
  def show_tags(tag_list)
    tag_list.join(", ")
  end
end
