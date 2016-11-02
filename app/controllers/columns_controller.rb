class ColumnsController < ApplicationController
  def create
    @master_sprint = MasterSprint.new master_sprint_params

    if @master_sprint.save
      @sprint = @master_sprint.sprint
      @tasks = @sprint.tasks
      @assignees = @sprint.assignees
      @total_lost_hour = @sprint.time_logs.size
      @total_time_log = @sprint.log_works.size
      @total_master_sprint = @sprint.master_sprints.size
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @master_sprint = MasterSprint.find_by id: params[:master_sprint_id]
    if @master_sprint
      respond_to do |format|
        format.html {
          render partial: "sprints/delete_column_dialog",
            locals: {
              master_sprint: @master_sprint, sprint: @master_sprint.sprint,
              project: @master_sprint.sprint.project
            }
        }
      end
    end
  end

  def destroy
    @master_sprint = MasterSprint.find_by id: params[:master_sprint_id]
    if @master_sprint.destroy
      respond_to do |format|
        format.html {redirect_to project_sprint_path(@project)}
        format.json {render json: {master_sprints: @master_sprint.sprint.master_sprints}}
      end
    else
      respond_to do |format|
        format.html {redirect_to project_sprint_path(@project)}
        format.json {render json: {master_sprints: @master_sprint.sprint.master_sprints}}
      end
    end
  end

  private
  def master_sprint_params
    params.require(:master_sprint).permit :sprint_id, :date
  end
end
