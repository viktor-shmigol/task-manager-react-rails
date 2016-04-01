@TasksManager = React.createClass

  taskType:
    true: 'doneTasks'
    false: 'activeTasks'

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
        newState = [task].concat @state[@taskType[task.done]]
        @setState "#{@taskType[task.done]}": newState
      ).bind(@)

  update: (task) ->
    $.ajax
      method: 'PUT'
      dataType: 'json'
      url: "/tasks/#{task.id}"
      data:
        task: task
      success: ((response)->
        newState = @state[@taskType[response.done]]
        index = _.findIndex newState, id: task.id
        if index == -1
          newState.unshift(response)
          newState = @state[@taskType[!response.done]].filter (item) -> item.id != response.id
          @setState "#{@taskType[!response.done]}": newState
        else
          newState[index] = response
          @setState "#{@taskType[response.done]}": newState
      ).bind(@)

  delete: (task) ->
    $.ajax
      method: 'DELETE'
      dataType: 'json'
      url: "/tasks/#{task.id}"
      success: (->
        newState = @state[@taskType[task.done]].filter (item) -> item.id != task.id
        @setState "#{@taskType[task.done]}": newState
      ).bind(@);

  render: ->
    <div className='row'>
      <div className='col-lg-6'>
        <TaskList tasks={@state.activeTasks}, type='Active' mainComponent={@} />
        <TaskList tasks={@state.doneTasks}, type='Done' mainComponent={@} />
      </div>
      <div className='col-lg-6'>
        <TaskForm create={@create}/>
      </div>
    </div>
