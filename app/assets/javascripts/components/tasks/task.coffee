@Task = React.createClass
  handeDelete: ->
    @props.parentComponent.delete(@props.task) if confirm 'Are you sure?'

  handeUpdate: ->
    @props.parentComponent.update(@props.task)

  handeMark: ->
    newTask = @props.task
    newTask.done = !newTask.done
    @setState ->
      task: newTask
    @handeUpdate()

  render: ->
    <li className='list-group-item'>
      <label>Name</label>
      <p>{@props.task.name}</p>
      <label>Description</label>
      <p>{@props.task.description}</p>
      <div className='btn-group'>
        <button type='button' className='btn btn-primary'>Edit</button>
        <button type='button' onClick={@handeMark} className='btn btn-success'>Mark as done</button>
        <button type='button' onClick={@handeDelete} className='btn btn-danger'>Delete</button>
      </div>
    </li>
