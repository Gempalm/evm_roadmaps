# To change this template, choose Tools | Templates
# and open the template in the editor.

class EvmRoadmapsVo

  def initialize(param)

    if param[:project_identifier].nil?
      @project_identifier = nil
    else
      @project_identifier = param[:project_identifier]
    end

    if param[:project_name].nil?
      @project_name = nil
    else
      @project_name = param[:project_name]
    end

    if param[:version_id].nil?
      @version_id = nil
    else
      @version_id = param[:version_id]
    end

    if param[:name].nil?
      @name = nil
    else
      @name = param[:name]
    end

    if param[:description].nil?
      @description = nil
    else
      @description = param[:description]
    end

    if param[:effective_date].nil?
      @effective_date = nil
    else
      @effective_date = param[:effective_date]
    end

    if param[:ticket_num].nil?
      @ticket_num = 0
    else
      @ticket_num = param[:ticket_num]
    end

    if param[:finish_num].nil?
      @finish_num = 0
    else
      @finish_num = param[:finish_num]
    end

    if param[:unfinish_num].nil?
      @unfinish_num = 0
    else
      @unfinish_num = param[:unfinish_num]
    end

    if param[:finish_percentage].nil?
      @finish_percentage = 0.00
    else
      @finish_percentage = param[:finish_percentage]
    end

    if param[:unfinish_percentage].nil?
      @unfinish_percentage = 0.00
    else
      @unfinish_percentage = param[:unfinish_percentage]
    end

    if param[:done_ratio].nil?
      @done_ratio = 0.00
    else
      @done_ratio = param[:done_ratio]
    end

    if param[:start_date].nil?
      @start_date = nil
    else
      @start_date = param[:start_date]
    end

    if param[:due_date].nil?
      @due_date = nil
    else
      @due_date = param[:due_date]
    end

    if param[:late].nil?
      @late = 0
    else
      @late = param[:late]
    end

    if param[:assigned_users].nil?
      @assigned_users = nil
    else
      @assigned_users = param[:assigned_users]
    end

    #完了時総予算…BAC(budget_at_completion)
    if param[:budget_at_completion].nil?
      @budget_at_completion = 0.00
    else
      @budget_at_completion = param[:budget_at_completion]
    end

    #投入実績値…AC(actual_cost)
    if param[:actual_cost].nil?
      @actual_cost = 0.00
    else
      @actual_cost = param[:actual_cost]
    end

    #出来高計画値…PV(planned_value)
    if param[:planned_value].nil?
      @planned_value = 0.00
    else
      @planned_value = param[:planned_value]
    end

    #出来高実績値…EV(earned_value)
    if param[:earned_value].nil?
      @earned_value = 0.00
    else
      @earned_value = param[:earned_value]
    end

    #スケジュール差異…SV(schedule_value) = EV - PV
    if param[:schedule_value].nil?
      @schedule_value = 0.00
    else
      @schedule_value = param[:schedule_value]
    end

    #コスト差異…CV(cost_variance) = EV - AC
    if param[:cost_variance].nil?
      @cost_variance = 0.00
    else
      @cost_variance = param[:cost_variance]
    end

    #スケジュール効率指数…SPI(schedule_performance_index) = EV / PV
    if param[:schedule_performance_index].nil?
      @schedule_performance_index = 0.00
    else
      @schedule_performance_index = param[:schedule_performance_index]
    end

    #コスト効率指数…CPI(cost_performance_index) = EV / AC
    if param[:cost_performance_index].nil?
      @cost_performance_index = 0.00
    else
      @cost_performance_index = param[:cost_performance_index]
    end

    #危険度指数…CR(critical_ratio) = CPI * SPI
    if param[:critical_ratio].nil?
      @critical_ratio = 0.00
    else
      @critical_ratio = param[:critical_ratio]
    end

    #出来高パーセント…PC(percent_of_completion) = 100 * EV / BAC
    if param[:percent_of_completion].nil?
      @percent_of_completion = 0.00
    else
      @percent_of_completion = param[:percent_of_completion]
    end

    #残作業効率指数…TCPI(to_complete_performance_index) = (BAC-EV) / (BAC-AC)
    if param[:to_complete_performance_index].nil?
      @to_complete_performance_index = 0.00
    else
      @to_complete_performance_index = param[:to_complete_performance_index]
    end

    #完成時総コスト見積もり…EAC(estimate_at_completion) = BAC / CPI
    if param[:estimate_at_completion].nil?
      @estimate_at_completion = 0.00
    else
      @estimate_at_completion = param[:estimate_at_completion]
    end

    #完成時コスト差異…VAC(variance_at_completion) = BAC - EAC
    if param[:variance_at_completion].nil?
      @variance_at_completion = 0.00
    else
      @variance_at_completion = param[:variance_at_completion]
    end

    #当初予定期間…SAC(schedule_at_completion) = effective_date - start_date
    if param[:schedule_at_completion].nil?
      @schedule_at_completion = 0.00
    else
      @schedule_at_completion = param[:schedule_at_completion]
    end

    #完了期間予測…TEAC(time_estimate_at_completion) = SAC / SPI
    if param[:time_estimate_at_completion].nil?
      @time_estimate_at_completion = 0.00
    else
      @time_estimate_at_completion = param[:time_estimate_at_completion]
    end

    #完了時期予測差異…TVAC(time_variance_at_completion) = SAC - TEAC
    if param[:time_variance_at_completion].nil?
      @time_variance_at_completion = 0.00
    else
      @time_variance_at_completion = param[:time_variance_at_completion]
    end

    #予測完了日…PCD(predictive_completion_date) = start_date + TEAC
    if param[:predictive_completion_date].nil?
      @predictive_completion_date = nil
    else
      @predictive_completion_date = param[:predictive_completion_date]
    end
  end

  attr_reader :project_identifier,
              :project_name,
              :version_id,
              :name,
              :description,
              :effective_date,
              :ticket_num,
              :finish_num,
              :unfinish_num,
              :finish_percentage,
              :unfinish_percentage,
              :done_ratio,
              :start_date,
              :due_date,
              :late,
              :assigned_users,
              :budget_at_completion,
              :actual_cost,
              :planned_value,
              :earned_value,
              :schedule_value,
              :cost_variance,
              :schedule_performance_index,
              :cost_performance_index,
              :critical_ratio,
              :percent_of_completion,
              :to_complete_performance_index,
              :estimate_at_completion,
              :variance_at_completion,
              :schedule_at_completion,
              :time_estimate_at_completion,
              :time_variance_at_completion,
              :predictive_completion_date
end
