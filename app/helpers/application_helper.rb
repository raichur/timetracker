module ApplicationHelper

  def nav_items
    [
      {
        displaytext: 'Companies',
        controllername: 'companies',
        linkurl: companies_path
      },
      {
        displaytext: 'Projects',
        controllername: 'projects',
        linkurl: projects_path
      },
      {
        displaytext: 'Works',
        controllername: 'works',
        linkurl: works_path
      }
    ]
  end

  def display_nav_item(displaytext, controllername, linkurl)
    raw("<li#{controller_name == controllername ? ' class="active"' : ''}>#{link_to displaytext, linkurl}</li>")
  end

  def user_logged_in_msg
    str = ''
    if user_signed_in?
      str += "<li id=userinfo>#{link_to('Logout', destroy_user_session_path, :method => :delete)}</li><li>#{link_to(current_user, edit_user_registration_path)}</li>"
    else
      str += "<li id=userinfo#{controller_name == 'users' ? ' class="active"' : ''}>#{link_to('Login', new_user_session_path)}</li><li#{controller_name == 'users' ? ' class="active"' : ''}>#{link_to('Register', new_user_registration_path)}</li>"
    end
    raw(str)
  end

end
