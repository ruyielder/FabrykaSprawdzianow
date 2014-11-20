jQuery ->
  key_a = 65
  key_e = 69
  key_o = 79


  getNorwayLetter = (keyCode, shiftKey) ->
    if shiftKey
      if keyCode == key_a
        return 'Å'
      else if keyCode == key_e
        return 'Æ'
      else if keyCode == key_o
        return 'Ø'
    else
      if keyCode == key_a
        return 'å'
      else if keyCode == key_e
        return 'æ'
      else if keyCode == key_o
        return 'ø'


  $(document).keydown (e) ->
      node = $(e.target)
      if node.is('input') and e.ctrlKey
        norway_letter = getNorwayLetter(e.keyCode, e.shiftKey)
        if norway_letter
          node.val(node.val() + norway_letter)
          e.preventDefault()


