module ApplicationHelper
  def title (pg_title)
    @page_title = pg_title
  end

  def description (pg_description)
    @page_description = pg_description
  end

  def back_path (label, path)
    @back_path = {
        label: label,
        path: path
    }
  end
end
