module PapersHelper
  include ActsAsTaggableOn::TagsHelper

  def author_shorten(author)
    return author if author.empty?
    shortens = author.split(" and ").map do |name|
      names = name.split(/[\s-]/)
      family = names.pop
      personal = names.map { |n| n[0].to_s + ". "}.join
      personal + family
    end
    last = shortens.pop
    shortens.join(", ") << ", and " << last
  end
end
