class EvmRoadmapsController < ApplicationController
  unloadable
  menu_item :evm_roadmaps
  before_filter :find_project, :authorize

  def index
    @results = []
    
    # 親プロジェクト
    logger.debug("get versions from parent project.")
    versions = EvmRoadmapsLogic.get_versions(@project.id)
    unless versions.nil?
      @results.concat(versions)
    end

    logger.debug("parent versions results = #{@results.size.to_s}")

    # 子プロジェクト
    logger.debug("get versions from child project.")
    projects = Project.where(["parent_id = ?", @project.id])
    unless projects.nil?
      projects.each do |child_project|
        versions = EvmRoadmapsLogic.get_versions(child_project.id)
        if versions
          @results.concat(versions)
        end
      end
    end

    @results = @results.sort{|aa, bb|
      aa.name <=> bb.name
    }

    logger.debug("child versions results = #{@results.size.to_s}")
  end

private
  def find_project
    @project_id = params[:project_id]
    @project = Project.find(@project_id)
  rescue ActiveRecord::RecordNotFound
    render_404
  end 
end
