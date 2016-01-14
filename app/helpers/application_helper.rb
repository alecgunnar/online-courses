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
    def push_nav_link (label, path, controllers, *submenu)
      @nav_links.push({ anchor: link_to(label, path), controllers: controllers, submenu: submenu })
    end

    def build_nav_links
      @nav_links ||= []

      push_nav_link('Overview', root_path, ['overview'])
      push_nav_link('Notifications', notifications_path, ['notifications'])
      push_nav_link('Courses', courses_path, ['courses'])
      push_nav_link('Manage Account', account_root_path, ['settings', 'd2l'], { anchor: link_to('Email Address and Password', account_root_path), controller: 'settings' }, { anchor: link_to('Elearning Authentication', account_api_auth_path), controller: 'd2l' })
    end
end
