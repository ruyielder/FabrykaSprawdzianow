$(document).on 'page:change', ->
  if $('.tests.new').length == 1 or $('.tests.edit').length == 1
    runForm()

runForm = () ->
  activationTagColor = 'rgb(0, 128, 0)'
  normalTagColor = 'rgb(0, 0, 0)'
  titleElement = $('#test_title')
  studentElement = $('#test_student_id')
  uniqueTasksElement = $('#is_unique_tasks')
  searchedTaskContainer = $('#searched_tasks')
  selectedTaskContainer = $('#selected_tasks')
  submitFormElement = $('input[type="submit"]')
  testTasksElement = $('#test_tasks')

  registerFormElement = () ->
    $('#new_test').submit (event) ->
      taskIds = toIds($('.task.selected'))
      if taskIds.length == 0
        event.preventDefault()

  registerTitleElement = () ->
    titleElement.change () ->
      updateSubmitFormEnable()

  registerSubmitFormElement = () ->
    submitFormElement.attr('disabled','disabled')

  registerStudentElement = () ->
    studentElement.click () ->
      searchByUsedTags()

  registerUniqueTasksElement = () ->
    uniqueTasksElement.change () ->
      searchByUsedTags()

  registerTagElements = () ->
    $('.tag').click () ->
      element = $(@)
      element.toggleClass('btn-info')
      element.toggleClass('btn-success')
      element.toggleClass('used')
      searchByUsedTags()

  toIds = (elements) ->
    ($(element).data('id') for element in elements.toArray())

  buildSearchUrl = (tag_ids, student_id) ->
    if uniqueTasksElement.is(':checked')
      return "/tasks/by_tags.json?tags=#{tag_ids.join()}&unique_for=#{student_id}"
    return "/tasks/by_tags.json?tags=#{tag_ids.join()}"

  searchByUsedTags = () ->
    tagIds = toIds($('.tag.used'))
    if tagIds.length > 0
      url = buildSearchUrl(tagIds, studentElement.val())
      $.get(url, replaceSearchedTasks)
    else
      $('.task.searched').remove()

  replaceSearchedTasks = (tasks) ->
    $('.task.searched').remove()
    addSearchedTasks(tasks)
    registerAllSearchedTask()

  addSearchedTasks = (tasks) ->
    for task in tasks
      addSearchedTask(task)

  addSearchedTask = (task) ->
    element = buildSearchedTaskElement(task)
    searchedTaskContainer.append(element)

  buildSearchedTaskElement = (task) ->
    buildTaskElement(task, 'searched')

  buildSelectedTaskElement = (task) ->
    buildTaskElement(task, 'selected')

  buildTaskElement = (task, kind) ->
    $("<li class='task #{kind} list-group-item list-group-item-info' id='#{kind}_task_#{task.id}' data-id='#{task.id}'><strong>#{task.question}</strong></li>")

  registerAllSearchedTask = () ->
    $('li.task.searched').click () ->
      element = $(@)
      if element.hasClass('used')
        dontUseSearchedTaskElement(element)
      else
        useSearchedTaskElement(element)

  dontUseSearchedTaskElement = (element) ->
    element.removeClass('used')
    selected_task_element = getSelectedTaskElement(element.data('id'))
    selected_task_element.remove()

  useSearchedTaskElement = (element) ->
    element.addClass('used')
    task = getTaskFromElement(element)
    addAndRegisterSelectedTask(task)

  getSelectedTaskElement = (task_id) ->
    return $("#selected_task_#{task_id}")

  getTaskFromElement = (element) ->
    return {
    id: element.data('id'),
    question: element.text()
    }

  addAndRegisterSelectedTask = (task) ->
    addSelectedTask(task)
    registerSelectedTask(task)

  addSelectedTask = (task) ->
    element = buildSelectedTaskElement(task)
    selectedTaskContainer.append(element)

  registerSelectedTask = (task) ->
    element = getSelectedTaskElement(task.id)
    element.click () ->
      searchedElement = getSearchedTaskElement(task.id)
      if searchedElement.length > 0
        searchedElement.toggleClass('used')
      $(@).remove()
      updateSubmitFormEnable()
    updateSubmitFormEnable()

  updateSubmitFormEnable = () ->
    console.log('odpalono procedure sprawdzania')
    if $('.task.selected').length > 0 && titleElement.val().trim().length > 0
      testTasksElement.val(toIds($('.task.selected')).join())
      submitFormElement.removeAttr('disabled')
    else
      submitFormElement.attr('disabled','disabled')

  getSearchedTaskElement = (task_id) ->
    return $("#searched_task_#{task_id}")

  registerFormElement()
  registerTitleElement()
  registerSubmitFormElement()
  registerStudentElement()
  registerUniqueTasksElement()
  registerTagElements()


#$(document).ready(ready);
#$(document).on('page:load', ready);