@TasksMain = React.createClass
  getInitialState: ->
    activeTasks: []
    doneTasks: []

  handleData: (data) ->
    @setState ->
      activeTasks: data.filter (task) -> !task.done
      doneTasks: data.filter (task) -> task.done

  componentDidMount: ->
    $.ajax
      dataType: 'json'
      url: '/tasks'
      success: @handleData

  checkType: (task) ->
    if task.done
      'doneTasks'
    else
      'activeTasks'

  getDefaultProps: ->
    activeTasks: []
    doneTasks: []

  create: (task) ->
    $.ajax
      method: 'POST'
      dataType: 'json'
      url: '/tasks'
      data:
        task: task
      success: ((task)->
        newState = @state[@checkType(task)].concat [task]
        @setState "#{@checkType(task)}": newState
      ).bind(@);

  update: (task) ->
    $.ajax
      method: 'PUT'
      dataType: 'json'
      url: "/tasks/#{task.id}"
      data:
        task: task
      success: ((task)->
        newState = @state[@checkType(task)]
        index = newState.indexOf(task)
        newState[index] = task
        @setState "#{@checkType(task)}": newState
      ).bind(@);

  delete: (task) ->
    $.ajax
      method: 'DELETE'
      dataType: 'json'
      url: "/tasks/#{task.id}"
      success: (->
        newState = @state[@checkType(task)].filter (item) -> item != task
        @setState "#{@checkType(task)}": newState
      ).bind(@);

  render: ->
    <div className='row'>
      <h2 className='text-center'>My tasks</h2>
      <div className='col-lg-6'>
        <TaskList tasks={@state.activeTasks}, parentComponent={@} />
        <TaskList tasks={@state.doneTasks}, parentComponent={@} />
      </div>
      <div className='col-lg-6'>
        <TaskForm create={@create}/>
      </div>
    </div>
