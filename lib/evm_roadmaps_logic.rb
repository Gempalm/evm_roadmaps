require 'date'
require 'common_logic'

class EvmRoadmapsLogic

  def self.get_versions(project_id)
    
    results = []
    
    versions = Version.where(["project_id = ?", project_id])
    if versions.nil?
      return results
    end

    versions.each do |version|

      next unless CommonLogic.is_valid_version(version.id, version.effective_date)

      vo = Hash.new

      project = Project.find(version.project_id)
      unless project.nil?
        vo[:project_identifier] = project.identifier
        vo[:project_name] = project.name
      end
      
      Rails.logger.debug "set version information"
      vo[:version_id] = version.id
      vo[:name] = version.name
      vo[:description] = version.description
      vo[:effective_date] = version.effective_date
      
      Rails.logger.debug "set closed num"
      vo[:finish_num] = CommonLogic.get_closed_num(version.id, 1)

      Rails.logger.debug "set unfinish_num"
      vo[:unfinish_num] = CommonLogic.get_closed_num(version.id, 0)

      Rails.logger.debug "set ticket num"
      vo[:ticket_num] = vo[:finish_num] + vo[:unfinish_num]

      Rails.logger.debug "set finish percentage"
      if vo[:ticket_num] != 0
        vo[:finish_percentage] = CommonLogic.size_round(vo[:finish_num].to_f / vo[:ticket_num].to_f * 100, 2)
      else
        vo[:finish_percentage] = 0
      end
      Rails.logger.debug "finish percentage = #{vo[:finish_percentage].to_s}"

      Rails.logger.debug "set unfinish percentage"
      if vo[:ticket_num] != 0
        vo[:unfinish_percentage] = CommonLogic.size_round(vo[:unfinish_num].to_f / vo[:ticket_num].to_f * 100, 2)
      else
        vo[:unfinish_percentage] = 0
      end
      Rails.logger.debug "unfinish percentage = #{vo[:unfinish_percentage].to_s}"

      Rails.logger.debug "set start date"
      vo[:start_date] = get_start_date(version.id)
      Rails.logger.debug "start date = #{vo[:start_date].to_s}"
      Rails.logger.debug "start date = #{vo[:start_date.class].to_s}"

      Rails.logger.debug "set due date"
      vo[:due_date] = get_due_date(version.id)
      Rails.logger.debug "due date = #{vo[:due_date].to_s}"
      Rails.logger.debug "due date = #{vo[:due_date.class].to_s}"
      
      Rails.logger.debug "set late"
      vo[:late] = get_late(vo[:effective_date])

      Rails.logger.debug "set done ratio"
      vo[:done_ratio] = get_all_done_ratio(version.id)
      Rails.logger.debug "done ratio = #{vo[:done_ratio].to_s}"

      Rails.logger.debug "set assigned user"
      vo[:assigned_users] = get_assigned_users(version.id)
      Rails.logger.debug "assigned user = #{vo[:assigned_users].to_s}"

      Rails.logger.debug "set budget at completion"
      vo[:budget_at_completion] = CommonLogic.size_round(get_budget_at_completion(version.id), 2)
      Rails.logger.debug "budget at completion = #{vo[:budget_at_completion].to_s}"

      Rails.logger.debug "set actual cost"
      vo[:actual_cost] = CommonLogic.size_round(get_actual_cost(version.id), 2)
      Rails.logger.debug "actual cost = #{vo[:actual_cost].to_s}"

      Rails.logger.debug "set planned value"
      vo[:planned_value] = CommonLogic.size_round(get_planned_value(version.id), 2)
      Rails.logger.debug "planned value = #{vo[:planned_value].to_s}"

      Rails.logger.debug "set earned value"
      vo[:earned_value] = CommonLogic.size_round(get_earned_value(version.id), 2)
      Rails.logger.debug "earned value = #{vo[:earned_value].to_s}"

      Rails.logger.debug "set schedule value"
      vo[:schedule_value] = CommonLogic.size_round(vo[:earned_value] - vo[:planned_value], 2)
      Rails.logger.debug "schedule value = #{vo[:schedule_value].to_s}"

      Rails.logger.debug "set cost variance"
      vo[:cost_variance] = CommonLogic.size_round(vo[:earned_value] - vo[:actual_cost], 2)
      Rails.logger.debug "cost variance = #{vo[:cost_variance].to_s}"

      Rails.logger.debug "set schedule performance index"
      if vo[:planned_value] == 0
        vo[:schedule_performance_index] = CommonLogic.size_round(0, 2)
      else
        vo[:schedule_performance_index] = CommonLogic.size_round(vo[:earned_value] / vo[:planned_value], 2)
      end
      Rails.logger.debug "schedule performance index = #{vo[:schedule_performance_index].to_s}"

      Rails.logger.debug "set cost performance index"
      if vo[:actual_cost] == 0
        vo[:cost_performance_index] = CommonLogic.size_round(0, 2)
      else
        vo[:cost_performance_index] = CommonLogic.size_round(vo[:earned_value] / vo[:actual_cost], 2)
      end
      Rails.logger.debug "cost performance index = #{vo[:cost_performance_index].to_s}"

      Rails.logger.debug "set critical ratio"
      vo[:critical_ratio] = CommonLogic.size_round(vo[:cost_performance_index] * vo[:schedule_performance_index], 2)
      Rails.logger.debug "critical ratio = #{vo[:critical_ratio].to_s}"

      Rails.logger.debug "set percent of completion"
      if vo[:budget_at_completion] == 0
        vo[:percent_of_completion] = CommonLogic.size_round(0, 2)
      else
        vo[:percent_of_completion] = CommonLogic.size_round(100 * vo[:earned_value] / vo[:budget_at_completion], 2)
      end
      Rails.logger.debug "percent of completion = #{vo[:percent_of_completion].to_s}"

      Rails.logger.debug "set to complete performance index"
      if vo[:budget_at_completion] - vo[:actual_cost] == 0
        vo[:to_complete_performance_index] = CommonLogic.size_round(0, 2)
      else
        vo[:to_complete_performance_index] = CommonLogic.size_round((vo[:budget_at_completion] - vo[:earned_value]) / (vo[:budget_at_completion] - vo[:actual_cost]), 2)
      end
      Rails.logger.debug "to complete performance index = #{vo[:to_complete_performance_index].to_s}"

      Rails.logger.debug "set estimate at completion"
      if vo[:cost_performance_index] == 0
        vo[:estimate_at_completion] = CommonLogic.size_round(0, 2)
      else
        vo[:estimate_at_completion] = CommonLogic.size_round(vo[:budget_at_completion] / vo[:cost_performance_index], 2)
      end
      Rails.logger.debug "estimate at completion = #{vo[:estimate_at_completion].to_s}"

      Rails.logger.debug "set variance at completion"
      vo[:variance_at_completion] = CommonLogic.size_round(vo[:budget_at_completion] - vo[:estimate_at_completion], 2)
      Rails.logger.debug "variance at completion = #{vo[:variance_at_completion].to_s}"
      
      Rails.logger.debug "set schedule at completion"
      if vo[:start_date].present? and vo[:effective_date].present?
        vo[:schedule_at_completion] = CommonLogic.size_round(vo[:effective_date] - vo[:start_date], 2)
      elsif vo[:start_date].present? and vo[:effective_date].blank?
        vo[:schedule_at_completion] = CommonLogic.size_round( -1 * vo[:start_date], 2)
      elsif vo[:start_date].blank? and vo[:effective_date].present?
        vo[:schedule_at_completion] = CommonLogic.size_round(vo[:effective_date], 2)
      else
        vo[:schedule_at_completion] = 0
      end
      Rails.logger.debug "schedule at completion = #{vo[:schedule_at_completion].to_s}"

      Rails.logger.debug "set time estimate at completion"
      if vo[:schedule_performance_index] == 0
        vo[:time_estimate_at_completion] = CommonLogic.size_round(0, 2)
      else
        vo[:time_estimate_at_completion] = CommonLogic.size_round(vo[:schedule_at_completion] / vo[:schedule_performance_index], 2)
      end
      Rails.logger.debug "time estimate at completion = #{vo[:time_estimate_at_completion].to_s}"

      Rails.logger.debug "set time variance at completion"
      vo[:time_variance_at_completion] = CommonLogic.size_round(vo[:schedule_at_completion] - vo[:time_estimate_at_completion], 2)
      Rails.logger.debug "time variance at completion = #{vo[:time_variance_at_completion].to_s}"

      Rails.logger.debug "set predictive completion date"
      if vo[:start_date].present?
        vo[:predictive_completion_date] = vo[:start_date] + vo[:time_estimate_at_completion]
      else
        vo[:predictive_completion_date] = nil
      end

      Rails.logger.debug "predictive completion date = #{vo[:predictive_completion_date].to_s}"

      results.push(EvmRoadmapsVo.new(vo))
      
    end

    return results
  end

  private
  def self.get_start_date(version_id)
    issue = Issue.where(["fixed_version_id = ? and start_date is not NULL", version_id]).order('start_date asc').first

    if issue.present?
      return issue.start_date
    end

    return nil
  end

  private
  def self.get_due_date(version_id)
    issue = Issue.where(["fixed_version_id = ?", version_id]).order('due_date desc').first

    if issue.present?
      return issue.due_date
    end

    return nil
  end

  private
  def self.get_all_done_ratio(version_id)
    sum = Issue.sum(:done_ratio, :conditions => ["fixed_version_id = ?", version_id])
    if sum.blank?
      sum = 0.0
    end
    Rails.logger.debug "sum = #{sum.to_s}"
    
    count = Issue.count(:all, :conditions => ["fixed_version_id = ?", version_id])
    Rails.logger.debug "count = #{count.to_s}"
    
    if count.to_i != 0
      return CommonLogic.size_round(sum / count, 2)
    end

    return 0
  end

  private
  def self.get_late(due_date)
    if due_date
      return (due_date - Date::today).to_i
    end

    return 0
  end

  private
  def self.get_assigned_users(version_id)
    return Issue.find_by_sql(
      ["select users.id, lastname, count(*) as count from issues, users
        where issues.assigned_to_id = users.id and
          fixed_version_id = :version_id
          group by assigned_to_id order by count desc",
        {:version_id => version_id}])
  end

  private
  def self.get_budget_at_completion(version_id)
    budget_at_completion = Issue.sum(:estimated_hours, :conditions => ["fixed_version_id = ?", version_id])
    
    if budget_at_completion.present?
      return budget_at_completion
    end

    return 0
  end

  private
  def self.get_planned_value(version_id)
    planned_value = Issue.sum(:estimated_hours, :conditions => ["fixed_version_id = ? and due_date < ?", version_id, Date::today])

    if planned_value.present?
      return planned_value
    end

    return 0
  end

  private
  def self.get_earned_value(version_id)
    earned_value = Issue.sum(:estimated_hours,
                             :conditions => ["fixed_version_id = ? and status_id in (?)",
                             version_id,
                             IssueStatus.where(["is_closed = ?", 1])])

    if earned_value.present?
      return earned_value
    end

    return 0
  end

  private
  def self.get_actual_cost(version_id)
    actual_cost = TimeEntry.sum(:hours, :conditions => ["issue_id in (?)", Issue.where(["fixed_version_id = ?", version_id])])

    if actual_cost.present?
      return actual_cost
    end

    return 0.0
  end

end
