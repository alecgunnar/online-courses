module ApplicationHelper
  @page_title
  @nav_links

  def title (pg_title)
    @page_title = pg_title
  end

  def globalNavLinks
    build_nav_links
    @nav_links
  end

  private
    def push_nav_link (label, path, controllers)
      @nav_links.push({ anchor: link_to(label, path), controllers: controllers })
    end

    def build_nav_links
      @nav_links ||= []

      push_nav_link 'Overview', root_path, ['overview']
      push_nav_link 'Notifications', notifications_path, ['notifications']
      push_nav_link 'Courses', courses_path, ['courses']
      push_nav_link 'Settings', settings_path, ['settings']
    end
end
