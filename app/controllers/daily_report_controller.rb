class DailyReportController < ApplicationController
  layout 'tousers'
  def new
    @report = Report.new()
    @report.issue = Issue.new()
    @tasks = Array.new(10,Task.new())
    @projects = Project.all()
    @categories = Category.all()
  end
  def index
    redirect_to(:action => 'new')
  end
  def showDetail #action when detail button is pushed
    r_id = params[:r_id]
    @user = current_user
    #@user = User.find(1)
    @report = Reports.find(r_id.to_i)
    #taskDay = @report.workingDay
    #taskDay = strftime('%Y-%m-%d', taskDay)
    #taskDay_b = taskDay + '00:00:00'
    #taskDay_e = taskDay + '23:59:59'
    
    issue_id = @report.issue_id
    
    @issue.find(issue_id)
    @tasks = Tasks.where(:issu_id => issue_id)
    
  end
  def listing
    @current = Time.now()
    m_start = @current.strftime('%Y-%m-00')
    m_end = @current.strftime('%Y-%m-31')
    @user = current_user
    #@user = User.find(1)
    @reports = Report.where(:workingDay => m_start..m_end)
    logger.debug(@reports.length)
  end
  def search
    @users = User.all
    @projects = Project.all
    @categories  = Category.all
  end
  def showSearchResult
    logger.debug("====================!!!")
    qYear = params[:search][:query_year]
    qMonth = params[:search][:query_month]
    qUsername = params[:search][:query_username]
    qProjectname = params[:search][:query_projectname]
    qCategoryname = params[:search][:query_categoryname]
    @reports = Report.all
    if(qYear.length == 0)
      redirect_to(:action => 'search', :alert => "Please Enter Specific Year") and return
    end
    if(qYear.length != 0)
      yStart = qYear + '-01-01'
      yEnd = qYear + '-12-31'
      @reports = Report.where(:workingDay => yStart..yEnd)
    else
      qYear = Time.now().strftime('%Y')
    end
    if(qMonth.length != 0)
      mStart = qYear + '-' + sprintf('%02d',qMonth) + '-01'
      mEnd = qYear + '-' + sprintf('%02d',qMonth) + '-31'
      @reports = @reports.where(:workingDay => mStart..mEnd)
    else
      mMonth = Time.now().strftime('%m')
    end
    logger.debug(qUsername)
    if(qUsername.length != 0)
      @user = User.where(:username => qUsername).first
      logger.debug("tsttsttest")
      logger.debug(@user.id)
      @reports = @reports.where(:user_id => @user.id)
      logger.debug(@reports)
    else
      redirect_to(:action => 'search', :alert => "Please Enter Specific Username") and return()
    end  
    
    # search with categoryname and projectname has not yet implemented
    # to implement:  
    @reports = @reports.order('workingDay ASC')
    logger.debug(@reports.length)
   render 'daily_report/listing'
  end
  def create
    if(params[:commit].eql?('Cancel'))
      logger.debug('ddd')
      redirect_to(:action => 'new') and return
    end
    #test user
    @user = current_user
    #@user = User.find(1)
    # 1st, new a report
    #:breaktime, :comment, :totalWorkTime, :workingDay, :worktimeBegin, :worktimeEnd
    @report = Report.new()
    @report.workingDay = params[:report][:workingDay]
    @report.worktimeBegin = params[:report][:worktimeBegin]
    @report.worktimeEnd = params[:report][:worktimeEnd]
    @report.breaktime = params[:report][:breaktime]
    @report.comment = params[:report][:comment]
    
    time_begin = params[:report][:worktimeBegin].split(":")
    time_end = params[:report][:worktimeEnd].split(":")
    breaktime = params[:report][:breaktime].split(":")
    
    tB = time_begin[0].to_i*60 + time_begin[1].to_i
    tE = time_end[0].to_i*60 + time_end[1].to_i
    tBreak = breaktime[0].to_i*60 + breaktime[1].to_i
    
    totalwork = (tE - tB) - tBreak
    totalwork_min_inReport = totalwork
    #(tB < tE then assertion)
    #totalwork < 0 then assertion
    totalwork = totalwork.divmod(60)
    totalwork = sprintf('%02d',totalwork[0]) + ":" + sprintf('%02d',totalwork[1]) 
    @totalwork = totalwork
    @report.totalWorkTime = totalwork
    
    
    #respond_to do |format|
    #  if @report.save
    #    format.html { redirect_to @report, notice: 'Task was successfully created.' }
    #    format.json { render json: @report, status: :created, location: @task }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @report.errors, status: :unprocessable_entity }
    #  end
    #end
    
    #2 save issue
    # :totalTime 
    @issue = Issue.new()
    @issue.totalTime = totalwork
    
    #respond_to do |format|
      #if @issue.save
      #  format.html { redirect_to @issue, notice: 'Task was successfully created.' }
      #  format.json { render json: @issue, status: :created, location: @task }
      #else
      #  format.html { render action: "new" }
      #  format.json { render json: @issue.errors, status: :unprocessable_entity }
      #end
    #end
    
    #3rd save tasks
    #if there is no spendtime input from form, then its task is not to be made.
    last_index_to_make = 0
    while params[:task][last_index_to_make.to_s][:spendTime].length != 0
      last_index_to_make = last_index_to_make + 1
    end
    last_index_to_make = last_index_to_make - 1
    #:category, :issue, :project, :spendTime, :taskDay
    bSaveTasks = Array.new(last_index_to_make)
    tasks  = Array.new(last_index_to_make,Task.new())
    totaltime_of_allTasks = 0
    for i in 0..last_index_to_make
      tasks[i] = Task.new()
      tasks[i].spendTime = params[:task][i.to_s][:spendTime]
      tmp = params[:task][i.to_s][:spendTime].split(":")
      totaltime_of_allTasks += tmp[0].to_i*60 + tmp[1].to_i 
      tasks[i].issueTitle = params[:task][i.to_s][:issueTitle]
      #regist project association and projectName
      project = Project.find(params[:task][i.to_s][:project_id])
      tasks[i].projectName = project.projectName
      tasks[i].project = project
      #regist caregory association and categoryName
      category = Category.find(params[:task][i.to_s][:category_id])
      tasks[i].categoryName = category.categoryName
      tasks[i].category = category
      #regist taskday as working day
      tasks[i].taskDay = params[:report][:workingDay] #same as workingday of report
      #asign association to issue and user
      @issue.tasks << tasks[i]
      tasks[i].issue = @issue
      tasks[i].user = @user
    end
    #check if total time of tasks is equal to that of report
    if(totalwork_min_inReport != totaltime_of_allTasks)
      bTotaltimeEqual = false 
      diff_min_s = (totaltime_of_allTasks - totalwork_min_inReport)
      diff_min = diff_min_s.abs
      hour = diff_min/60
      min = diff_min % 60
      if (diff_min_s > 0)
        errorMsg = sprintf('%02d',hour) + ":" + sprintf('%02d',min) + " less required in Issue's log"
        redirect_to(:action => 'new' , :alert => errorMsg) and return
      else 
         errorMsg = sprintf('%02d',hour) + ":" + sprintf('%02d',min) + " more required in Issue's log"
         redirect_to(:action => 'new', :alert => errorMsg) and return
      end
      render :text => "in report " + totalwork_min_inReport.to_s + "</br> " + "in tasks " + totaltime_of_allTasks.to_s
    end
    #assign associations then save.
    @report.issue = @issue
    @report.user = @user
    @issue.user = @user
    
    #save all with transaction
    bSaveAllTasks = true
    #Task.transaction do
    #  tasks.each{|task|
    #    task.save!
    #  }
    #end
    #rescue => e
    #  bSaveAllTasks = false
    #  render :text => e.message
    tasks.each{|task|
      task.save  
    }  
    if(bSaveAllTasks == true)
      bSaveReport = @report.save
      if(bSaveReport == false)
        logger.degug("error in saving report")
        render :text => "error"
      end
      bSaveIssue = @issue.save
      redirect_to(:action => 'new', :notice => "Your Daily Report was successfully submitted")
    end
  end
end
