

Redmine::Plugin.register :evm_roadmaps do
  name 'Evm Roadmaps plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :evm_roadmaps do
    permission :view_evm_roadmaps, :evm_roadmaps => :index,
               :require => :member
  end

  menu :project_menu, :evm_roadmaps, { :controller => 'evm_roadmaps', :action => 'index'}, :param => :project_id
end
