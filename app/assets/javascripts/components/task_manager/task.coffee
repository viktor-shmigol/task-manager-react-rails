@Task = React.createClass
  getInitialState: ->
    showEditForm: false

  handeDelete: ->
    @props.mainComponent.delete(@props.task) if confirm 'Are you sure?'

  handeUpdate: ->
    @props.mainComponent.update(@props.task)

  handeMark: ->
    newTask = @props.task
    newTask.done = !newTask.done
    @handeUpdate()

  toogleEditForm: ->
    @setState showEditForm: !@state.showEditForm

  render: ->
    classes = 'list-group-item'
    classes += ' disabled' if @props.task.done
    <li className={classes}>
      {<div>
        <label>Name</label>
        <p>{@props.task.name}</p>
        <label>Description</label>
        <p>{@props.task.description}</p>
        <div className='btn-group'>
          <button onClick={@toogleEditForm} className='btn btn-primary'>Edit</button>
          {<button onClick={@handeMark} className='btn btn-success'>Mark as done</button> if !@props.task.done}
          {<button onClick={@handeMark} className='btn btn-warning'>Mark as active</button> if @props.task.done}
          <button onClick={@handeDelete} className='btn btn-danger'>Delete</button>
        </div>
      </div> unless @state.showEditForm}
      {<TaskEditForm task={@props.task}, mainComponent={@props.mainComponent}, parentComponent={@}/> if @state.showEditForm}
    </li>
