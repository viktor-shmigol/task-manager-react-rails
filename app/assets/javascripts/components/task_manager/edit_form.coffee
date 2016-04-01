@TaskEditForm = React.createClass

  getInitialState: ->
    task: $.extend({}, @props.task)

  handleNameChange: (e) ->
    @changeState 'name', e.target.value

  handleDescriptionChange: (e) ->
    @changeState 'description', e.target.value

  changeState: (field, value) ->
    newTask = @state.task
    newTask[field] = value
    @setState ->
      task: newTask

  hideEditForm:  ->
    @props.parentComponent.toogleEditForm()

  handleSubmit: (e) ->
    e.preventDefault()
    @props.mainComponent.update(@state.task)
    @hideEditForm()

  render: ->
    <div>
      <h5 className='text-center'>Edit task</h5>
      <form onSubmit={@handleSubmit} >
        <div className="form-group">
          <label>Name</label>
          <input onChange={@handleNameChange} value={@state.task.name} type="text" className="form-control" placeholder="Name" required/>
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea onChange={@handleDescriptionChange} value={@state.task.description} type="text" className="form-control" placeholder="Description" required/>
        </div>
        <div className='btn-group'>
          <button type="submit" className="btn btn-success">Save</button>
          <a href='javascript:void(false);' onClick={@hideEditForm} className="btn btn-danger">Cancel</a>
        </div>
      </form>
    </div>
